# Object Storage API, Amazon S3-compatible REST: GetObjectAcl

Returns an access control list for an object.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}/{key}?acl HTTP/2
```

### Path parameters {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-multipart-path-parameters.md) %}

### Query parameters {#request-params}

{% include [request-params](../../../_includes_service/storage-request-params.md) %}

### Headings {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Data schema {#response-scheme}

The structure of the returned data is described in [ACL XML schema](xml-config.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

#### Related articles {#related-articles}

* [{#T}](../../../concepts/acl.md)

* [{#T}](../../../operations/objects/edit-acl.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
