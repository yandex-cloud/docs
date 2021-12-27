# HTTP_JSON

A type of payload for the Pandora load generator. It represents HTTP requests in a JSON structure.

Data format:

```
{"host": "example.com", "method": "GET", "uri": "/api/url1", "tag": "url1", "headers": {"User-agent": "Tank", "Connection": "close"}}
{"host": "example.com", "method": "POST", "uri": "/api/url2", "tag": "url2", "headers": {"User-agent": "Tank", "Connection": "close"}, "body": "body_data"}
```

Where:

* `host`: The value of the `Host` header.
* `method`: The HTTP request method.
* `uri`: The request URI.
* `tag`: The request tag to display in reports.
* `headers`: Request headers.
* `body`: The POST request body. Specified if `method=POST`.

When configuring the Pandora load generator using a file, specify the `http/json` type in the `ammo` section:

```
config_content:
          pools:
           - id: HTTP
             ammo:
               type: http/json
               file: ./ammo.json
```

This is done automatically when uploading a file with a payload via the management console.
