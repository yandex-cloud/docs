# delete method

Deletes a CORS configuration for a bucket.


## Request {#request}

```
DELETE /{bucket}?cors HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Query parameters {#parameters}

| Parameter | Description |
----- | -----
| `cors` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in your requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

If there is no CORS configuration, {{ objstorage-name }} returns the code `204 No Content`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}