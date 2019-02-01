# delete method

Deletes a static website hosting configuration for a bucket.

## Request {#request}

```
DELETE /{bucket}?website HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#parameters}

| Parameter | Description |
| ----- | ----- |
| `website` | Mandatory parameter to indicate the type of operation. |

### Headers {#request-headers}

In a request, use only [common request headers](../common-request-headers.md).

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [[!TITLE]](../response-codes.md).

If there is no hosting configuration, [!KEYREF objstorage-name] returns 200.

