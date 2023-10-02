# HTTP_JSON

A type of payload for the Pandora load generator. It represents HTTP requests in a JSON structure.

Data format:

```
{"host": "example.com", "method": "GET", "uri": "/api/url1", "tag": "url1", "headers": {"User-agent": "Tank", "Connection": "close"}}
{"host": "example.com", "method": "POST", "uri": "/api/url2", "tag": "url2", "headers": {"User-agent": "Tank", "Connection": "close"}, "body": "body_data"}
```

Where:

* `host`: Value of the `Host` header
* `method`: HTTP request method
* `uri`: Request URI
* `tag`: Request tag to display in reports
* `headers`: Request headers
* `body`: POST request body; specified if `method=POST`

When passing a JSON structure in the `body` parameter, use the `\` character to escape quotation marks:

```
{"host": "example.com", "method": "POST", "uri": "/api/url2", "tag": "url2", "headers": {"User-agent": "Tank", "Connection": "close"}, "body": "{\"data\": \"some_data\"}"}
```

When configuring the Pandora load generator using a file, specify the `http/json` type in the `ammo` section:

```
config_content:
          pools:
           - id: HTTP
             ammo:
               type: http/json
               file: ./ammo.json
```

When uploading a file with a payload via the management console, this is done automatically.