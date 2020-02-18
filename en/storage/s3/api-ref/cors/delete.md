# delete method

Deletes a CORS configuration for a bucket.

## Request {#request}

```
DELETE /{bucket}?cors HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#parameters}

| Parameter | Description |
| ----- | ----- |
| `cors` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

If there is no CORS configuration, {{ objstorage-name }} returns the code `204 No Content`.

