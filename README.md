# Premailer API

As a Docker container.

```
$ docker pull keichan34/premailer-api:latest
$ docker run --rm -p 8080:80 keichan34/premailer-api:latest
```

## Usage

`POST` your e-mail contents as the `content` parameter either as a multipart/form-data,
or inside a JSON document.

```
POST /1.0/document HTTP/1.1
Content-Type: multipart/form-data; boundary=__BOUNDARY__

--__BOUNDARY__
Content-Disposition: form-data; name="content"

<html>
...
</html>
```

Example response:

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "processed_content": "<html>...</html>",
  "warnings": {
    "safe": [
      "text-decoration CSS property may not render properly in Eudora"
    ],
    "poor": [
      "display CSS property may not render properly in Outlook 07, Eudora"
    ],
    "risky": [
      "visibility CSS property may not render properly in Outlook 07, Notes 6, Eudora, Old GMail, New GMail, aolWeb"
    ]
  }
}
```
