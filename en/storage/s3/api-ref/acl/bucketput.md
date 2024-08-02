# bucketPutAcl method

Uploads an access control list for a bucket.

{% note info %}

ACLs can be uploaded as XML documents or using special `X-Amz-Grant*` headers. Don't use XML documents and `X-Amz-Grant*` headers in the same request.

{% endnote %}

## Request {#request}

```
PUT /{bucket}?acl HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `acl` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your requests.

You can also use the headers listed below.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-bucket-headers.md) %}

### Data schema {#data-schema}

ACLs are passed as XML documents. For the schema description, see [ACL XML schema](xml-config.md).

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}