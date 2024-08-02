# startUpload method

Returns the ID that should be used in all subsequent operations for uploading objects.

If the object is to be stored with user-defined metadata, it should be passed in this request.


## Request {#request}

```
POST /{bucket}/{key}?uploads HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. The object will be saved in {{ objstorage-name }} with the specified name. |


### Query parameters {#request-parameters}

| Parameter | Description |
----- | -----
| `uploads` | Flag indicating the multipart upload operation. |


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in requests.

You can also use the headers listed in the table below.

| Header | Description |
----- | -----
| `X-Amz-Meta-*` | Object user-defined metadata.<br/><br/>{{ objstorage-name }} transforms all headers starting with `X-Amz-Meta-` as follows: `X-Amz-Meta-foo-bar_baz` → `X-Amz-Meta-Foo-Bar_baz`.<br/><br/>Total user-defined header size must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The header names and their values are included when calculating the size. |
| `X-Amz-Storage-Class` | Object [storage class](../../../concepts/storage-class.md).<br/><br/>Possible values:<ul><li>`STANDARD`: Standard storage.</li><li>`COLD`, `STANDARD_IA`, or `NEARLINE`: Cold storage.</li><li>`ICE` or `GLACIER`: Ice storage.</li></ul>If the header is not specified, the object is stored in the storage defined in the bucket settings. |
| `X-Amz-Object-Lock-Mode` | <p>Type of [retention](../../../concepts/object-lock.md) put on the object (if the bucket is [versioned](../../../concepts/versioning.md) and object lock is enabled in it):</p><ul><li>`GOVERNANCE`: Object lock with a predefined retention period that can be managed.</li><li>`COMPLIANCE`: Object lock with a predefined retention period with strict compliance.</li></ul><p>On an object version, you can put only retention (the headers `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date`), only legal hold (`X-Amz-Object-Lock-Legal-Hold`), or both at the same time. For more information about their combined use, see [{#T}](../../../concepts/object-lock.md#types).</p> |
| `X-Amz-Object-Lock-Retain-Until-Date` | Date and time until which the object is retained, specified in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`. Specify it only with the `X-Amz-Object-Lock-Mode` header. |
| `X-Amz-Object-Lock-Legal-Hold` | <p>Type of [legal hold](../../../concepts/object-lock.md) put on the object (if the bucket is [versioned](../../../concepts/versioning.md) and object lock is enabled in it):</p><ul><li>`ON`: Enabled.</li><li>`OFF`: Disabled.</li></ul><p>On an object version, you can put only retention (the headers `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date`), only legal hold (`X-Amz-Object-Lock-Legal-Hold`), or both at the same time. For more information about their combined use, see [{#T}](../../../concepts/object-lock.md#types).</p> |

By using the headers listed below, you can set the [ACL](../../../concepts/acl.md) for an object to be uploaded.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md) %}


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#response-scheme}

```
<InitiateMultipartUploadResult>
  <Bucket>bucket-name</Bucket>
  <Key>object-key</Key>
  <UploadId>upload-id</UploadId>
</InitiateMultipartUploadResult>
```

| Tag | Description |
----- | -----
| `InitiateMultipartUploadResult` | Response root tag.<br/><br/>Path: `/InitiateMultipartUploadResult`. |
| `Bucket` | Name of the bucket the object is uploaded to.<br/><br/>Path: `/InitiateMultipartUploadResult/Bucket`. |
| `Key` | Key associated with the object after the upload is complete.<br/><br/>Path: `/InitiateMultipartUploadResult/Key`. |
| `uploadId` | Upload ID.<br/><br/>All subsequent upload operations must pass this ID to {{ objstorage-name }}.<br/><br/>Path: `/InitiateMultipartUploadResult/UploadId`. |

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}