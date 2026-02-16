# Create method

Creates a bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PUT /{bucket} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.<br/><br/>When creating a bucket, follow the [naming conventions](../../../concepts/bucket.md#naming).

### Headers {#request-headers}
Use [common headers](../common-request-headers.md) in your requests.

The headers below enable you to set the [ACL](../../../concepts/acl.md) for the bucket being created.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-bucket-headers.md) %}

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}