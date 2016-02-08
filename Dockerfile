FROM ruby:2.3.0

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN bundle install --without development

COPY . /app

ENV RACK_ENV="production"

EXPOSE 80
CMD ["bundle", "exec", "rackup", "--server", "puma", "--host", "0.0.0.0", "--port", "80"]
