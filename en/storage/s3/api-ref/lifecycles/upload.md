# upload method

Uploads a bucket's object lifecycle configuration to {{ objstorage-name }}.

## Request {#request}

```
PUT /{bucket}?lifecycle HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `lifecycle` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

The `Content-MD5` header is required.

### Data schema {#request-scheme}

For the configuration description, see [{#T}](../../../lifecycles/configuration.md).

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

