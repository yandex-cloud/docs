# delete method

Deletes an object.


## Request {#request}

```
DELETE /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. |

### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `versionId` | Link to a specific version of the object. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

Moreover, if a [lock](../../../concepts/object-lock.md) with governance-mode retention is set for an object version in a versioned bucket, make sure to use the below-specified header to bypass retention and confirm deletion. Only users with the [`storage.admin` role](../../../security/index.md) can delete a retained object version. To check retention status, use the [getObjectRetention](getobjectretention.md) method.

| Header | Description |
--- | ---
| `X-Amz-Bypass-Governance-Retention` | Header that confirms bypassing of the governance retention. Enter `true`. |


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

