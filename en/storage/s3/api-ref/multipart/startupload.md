# startUpload method

Returns the ID that should be used in all subsequent operations for uploading objects.

If the object is to be stored with user-defined metadata, it should be passed in this request.

## Request {#request}

```
POST /{bucket}/{key}?uploads HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |
| `key` | Object key. The object will be saved in {{ objstorage-name }} with the specified name. |

### Query parameters {#request-parameters}

| Parameter | Description |
| ----- | ----- |
| `uploads` | Flag indicating a multipart upload operation. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

You can also use the headers listed in the table below.

| Header | Description |
| ----- | ----- |
| `X-Amz-Meta-*` | User-defined metadata of the object.<br/><br/> {{ objstorage-name }} treats all headers starting with `X-Amz-Meta-` as user-defined. It doesn't process these headers, but saves them in the original format.<br/><br/>The total size of user-defined headers must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The header names and their values are included when calculating the size. |
| `X-Amz-Storage-Class` | Object storage class.<br/><br/>Possible values:<br/>- `STANDARD` for uploading an object to standard storage.<br/>- `COLD`, `STANDARD_IA`, and `NEARLINE` for uploading an object to cold storage.<br/><br/>If the header is omitted, the object is saved to the storage specified in the bucket settings. |

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
| ----- | ----- |
| `InitiateMultipartUploadResult` | Response root tag.<br/><br/>Path: `/InitiateMultipartUploadResult`. |
| `Bucket` | Name of the bucket the object is uploaded to.<br/><br/>Path: `/InitiateMultipartUploadResult/Bucket`. |
| `Key` | Key associated with the object after the upload is complete.<br/><br/>Path: `/InitiateMultipartUploadResult/Key`. |
| `UploadId` | Upload ID.<br/><br/>All subsequent upload operations must pass this ID to {{ objstorage-name }}.<br/><br/>Path: `/InitiateMultipartUploadResult/UploadId`. |

