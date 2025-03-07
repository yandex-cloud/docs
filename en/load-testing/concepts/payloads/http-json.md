# HTTP_JSON

Type of test data for the Pandora load generator. It represents HTTP requests in a JSON structure.

The test data type is specified when [creating a test](../../operations/create-test-bucket.md#create-test).

Data format:

```json
{"host": "example.com", "method": "GET", "uri": "/api/url1", "tag": "url1", "headers": {"User-agent": "Tank", "Connection": "close"}}
{"host": "example.com", "method": "POST", "uri": "/api/url2", "tag": "url2", "headers": {"User-agent": "Tank", "Connection": "close"}, "body": "body_data"}
```

Where:

* `host`: `Host` header value.
* `method`: HTTP request method.
* `uri`: Request URI.
* `tag`: Request tag to display in reports.
* `headers`: Request headers.
* `body`: POST request body. It is specified only if `method=POST`.

When providing a JSON structure in the `body` parameter, use the `\` character to escape quotation marks:

```json
{"host": "example.com", "method": "POST", "uri": "/api/url2", "tag": "url2", "headers": {"User-agent": "Tank", "Connection": "close"}, "body": "{\"data\": \"some_data\"}"}
```

When configuring the Pandora load generator using a file, specify the `http/json` type in the `ammo` section:

```yaml
config_content:
          pools:
           - id: HTTP
             ammo:
               type: http/json
               file: ./ammo.json
```

When uploading a file with test data via the management console, this is done automatically.


## Use cases {#examples}

* [{#T}](../../tutorials/loadtesting-gitlab-ci.md)
* [{#T}](../../tutorials/loadtesting-grpc.md)