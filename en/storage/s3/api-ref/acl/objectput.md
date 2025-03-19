# objectPutAcl method

Uploads an access control list for an object.

{% note info %}

You can upload an ACL as an XML document or using special `X-Amz-Grant*` headers. Do not use an XML document and `X-Amz-Grant*` headers in the same request.

{% endnote %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PUT /{bucket}/{key}?acl HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key. ID for saving the object in {{ objstorage-name }}.

### Request parameters {#request-params}

Parameter | Description
----- | -----
`acl` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

You can also use the headers listed below.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md) %}

### Data schema {#data-schema}

ACLs are provided as XML documents. For the schema description, see [ACL XML schema](xml-config.md).

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}