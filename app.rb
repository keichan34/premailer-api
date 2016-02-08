require "rubygems"
require "bundler/setup"
Bundler.require(ENV["RACK_ENV"])

require "sinatra/base"
require "premailer"
require "oj"

class App < Sinatra::Base
  get '/' do
    headers "Content-Type" => "application/json"
    Oj.dump({
      "version" => "1.0",
      "source" => "https://github.com/keichan34/premailer-api"
    })
  end

  post "/1.0/document" do
    email_contents = params["content"]
    premailer = Premailer.new(email_contents,
      with_html_string: true,
      adapter: :nokogiri)

    headers "Content-Type" => "application/json"
    Oj.dump({
      "processed_content" => premailer.to_inline_css,
      "warnings" => premailer.warnings.group_by { |w| w[:level].downcase }.map do |key, wa|
        [key, wa.map do |w|
          "#{w[:message]} may not render properly in #{w[:clients]}"
        end]
      end.to_h
    })
  end
end
