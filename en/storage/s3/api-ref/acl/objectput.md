# objectPutAcl method

Uploads an access control list for an object.

{% note info %}

ACLs can be uploaded as XML documents or using special `x-amx-grant*` headers. Do not use XML documents and `x-amx-grant*` headers in the same request.

{% endnote %}

## Request {#request}

```
PUT /{bucket}/{key}?acl HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |
| `key` | Object key. ID to use for saving the object in Object Storage. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `acl` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

You can also use the headers listed below.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md) %}

### Data schema

ACLs are passed as XML documents. For a description of the schema, see [ACL XML schema](xmlscheme.md).

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [#T](../response-codes.md).

