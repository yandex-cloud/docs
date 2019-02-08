# delete method

Deletes a CORS configuration for a bucket.

## Request {#request}

```
DELETE /{bucket}?cors HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |

### Query parameters {#parameters}

| Parameter | Description |
| ----- | ----- |
| `cors` | Mandatory parameter to indicate the type of operation. |

### Headers {#request-headers}

In a request, use only [common request headers](../common-request-headers.md).

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [[!TITLE]](../response-codes.md).

If there is no CORS configuration, [!KEYREF objstorage-name] returns code `204 No Content`.

