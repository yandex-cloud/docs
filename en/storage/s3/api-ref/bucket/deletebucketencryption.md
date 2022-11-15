# deleteBucketEncryption method

Removes encryption from the bucket. For more information about bucket encryption, see [{#T}](../../../concepts/encryption.md).

## Request {#request}

```
DELETE /{bucket}?encryption HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).
