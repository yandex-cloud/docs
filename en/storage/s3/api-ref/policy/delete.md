# DeleteBucketPolicy method

Removes the access policy from the specified bucket.

## Request {#request}

```bash
DELETE /{bucket}?policy HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `policy` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

## Response {#response}

If the request is successful, the service returns a response with code `HTTP 204` and an empty body.

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).
