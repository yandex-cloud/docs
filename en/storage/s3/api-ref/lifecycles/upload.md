# upload method

Uploads the bucket object lifecycle configuration to {{ objstorage-name }}.

## Request {#request}

```
PUT /{bucket}?lifecycle HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `lifecycle` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

The `Content-MD5` header is required.

### Data schema {#request-scheme}

The configuration type is described in [{#T}](xml-config.md).

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

