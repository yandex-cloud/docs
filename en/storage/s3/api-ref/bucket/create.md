# create method

Creates a bucket.


## Request {#request}

```
PUT /{bucket} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name.<br/><br/>When creating a bucket, follow the bucket [naming guidelines](../../../concepts/bucket.md#naming). |

### Headers {#request-headers}
Use [common request headers](../common-request-headers.md) in requests.

By using the headers listed below, you can set the [ACL](../../../concepts/acl.md) of the bucket being created.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-bucket-headers.md) %}

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.

