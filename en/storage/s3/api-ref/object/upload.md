# upload method

Uploads an object and its metadata to {{ objstorage-full-name }}.

{% note info %}

{{ objstorage-name }} doesn't block objects for writing and can accept multiple requests to write to the same object in parallel, but the user can only get the latest object saved from {{ objstorage-name }}.

{% endnote %}

To make sure an object is passed via the network uncorrupted, use the `Content-MD5` header. {{ objstorage-name }} calculates the `MD5` value for a saved object and, if the calculated `MD5` value doesn't match the value passed in the header, it returns an error. You can also perform this check on the client side by comparing the `ETag` from the {{ objstorage-name }} response with the precalculated `MD5` value.

## Request {#request}

```
PUT /{bucket}/{key} HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |
| `key` | Object key. ID for saving the object in {{ objstorage-name }}. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

You can also use the headers listed in the table below.

| Header | Description |
| ----- | ----- |
| `x-amz-meta-*` | User-defined object metadata.<br/><br/>{{ objstorage-name }} considers all headers starting with `x-amz-meta-` as user-defined. It doesn't process these headers. Instead, it saves them in their original format.<br/><br/>The total size of user-defined headers must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The header names and their values are included when calculating the size. |
| `x-amz-storage-class` | Object storage class.<br/><br/>Possible values:<br/>- `STANDARD` for uploading an object to standard storage.<br/>- `COLD`, `STANDARD_IA`, and `NEARLINE` for uploading an object to cold storage.<br/><br/>If the header is omitted, the object is saved to the storage specified in the bucket settings. |
| `x-amz-server-side-encryption` | Object encryption algorithm. Available values: `aws:kms`. |
| `x-amz-server-side-encryption-aws-kms-key-id` | ID of the [{{ kms-short-name }} key](../../../../kms/concepts/key.md) that is used to encrypt the uploaded object. |

By using the headers listed below, you can set the [ACL](../../../concepts/acl.md) for an object to be uploaded.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md) %}

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).   
