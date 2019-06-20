# delete method

Deletes a bucket's object lifecycle configuration from {{ objstorage-name }}.

## Request {#request}

```
DELETE /{bucket}?lifecycle HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |

### Query parameters {#parameters}

| Parameter | Description |
| ----- | ----- |
| `lifecycle` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

In a request, use only [common request headers](../common-request-headers.md).

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [#T](../response-codes.md).

If there is no bucket object lifecycle configuration, {{ objstorage-name }} returns 200.

