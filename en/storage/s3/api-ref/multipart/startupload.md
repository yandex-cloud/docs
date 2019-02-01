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
| `key` | Object key. The object will be saved in [!KEYREF objstorage-name] under the specified name. |

### Query parameters {#request-parameters}

| Parameter | Description |
| ----- | ----- |
| `uploads` | Flag indicating a multipart upload operation. |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

You can also use the headers listed in the table below.

| Header name | Description |
| ----- | ----- |
| `x-amz-meta-*` | User-defined metadata of the object.<br/><br/>[!KEYREF objstorage-name] considers all headers starting with `x-amz-meta-` as user-defined. It does not process these headers, but saves them in the original form.<br/><br/>The total size of user-defined headers should not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The header names and their values are included when calculating the size. |
| `x-amz-storage-class` | Object storage class.<br/><br/>Possible values:<br/><br/>- `COLD` for uploading an object to the cold storage.<br/>- `STANDARD` for uploading an object to the standard storage.<br/><br/><br/>If no header is specified, the object is saved to the standard storage. |

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [[!TITLE]](../response-codes.md).

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
| `UploadId` | Upload ID.<br/><br/>All subsequent upload operations should pass this ID to [!KEYREF objstorage-name].<br/><br/>Path: `/InitiateMultipartUploadResult/UploadId`. |

