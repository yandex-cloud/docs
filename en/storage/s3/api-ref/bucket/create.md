# Create method

Creates a bucket.


## Request {#request}

```http
PUT /{bucket} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.<br/><br/>When creating a bucket, follow the [naming conventions](../../../concepts/bucket.md#naming).

### Headers {#request-headers}
Use [common request headers](../common-request-headers.md) in your requests.

By using the headers listed below, you can set the [ACL](../../../concepts/acl.md) of the bucket being created.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-bucket-headers.md) %}

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}