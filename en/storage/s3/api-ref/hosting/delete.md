# delete method

Deletes a static website hosting configuration for a bucket.


## Request {#request}

```
DELETE /{bucket}?website HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Query parameters {#parameters}

| Parameter | Description |
----- | -----
| `website` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

If there aren't any hosting configurations, {{ objstorage-name }} returns a 200 code.
