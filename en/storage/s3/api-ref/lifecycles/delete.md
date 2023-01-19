# delete method

Deletes a bucket object lifecycle configuration from {{ objstorage-name }}.

## Request {#request}

```
DELETE /{bucket}?lifecycle HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Query parameters {#parameters}

| Parameter | Description |
----- | -----
| `lifecycle` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

If there isn't a bucket object lifecycle configuration, {{ objstorage-name }} returns a 200 code.
