# get method

Returns a CORS configuration for a bucket.

## Request {#request}

```
GET /{bucket}?cors HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `cors` | Mandatory parameter to indicate the type of operation. |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

### Data schema {#response-scheme}

The structure of returned data is the same as that of the data passed by the [upload](upload.md) method.

