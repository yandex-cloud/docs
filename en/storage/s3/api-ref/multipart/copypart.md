# copyPart method

Copies part of an object.

Has the same functionality as [{#T}](uploadpart.md), but data isn't passed in the request body. It's copied from an existing object.

## Request {#request}

```
PUT /{bucket}/{key}?partNumber=PartNumber&uploadId=UploadId HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the resulting bucket. |
| `key` | Key of the resulting object. ID that the object is saved with in {{ objstorage-name }}. |

### Query parameters {#request-parameters}

| Parameter | Description |
| ----- | ----- |
| `partNubmer` | ID that you assigned to the uploaded part. |
| `uploadId` | ID of the multipart upload returned by {{ objstorage-name }} at the [start](startupload.md). |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

The `Content-Length` header is required. The headers listed in the table below are also required.

| Header | Description |
| ----- | ----- |
| `x-amz-copy-source` | The name of the bucket and the key of the object whose data will be copied, separated by the `/` character.<br/><br/>For example, `x-amz-copy-source: /source_bucket/sourceObject`. |
| `x-amz-copy-source-range` | Byte range to copy from the source object. For example, if you specify `x-amz-copy-source-range:bytes=10-36`, then {{ objstorage-name }} will copy the range from the 10th to the 36th bytes of the source object. |

If you want to add copy conditions, use the headers listed in the table below.

Use the headers from the table below if you need to change the default behavior of the `copy` method.

| Header | Description |
| ----- | ----- |
| `x-amz-copy-source-if-match` | Object copying criteria.<br/><br/>If the `ETag` of an object is the same as in the header, the object is copied.<br/><br/>If the criteria isn't met, {{ objstorage-name }} returns a 412 error.<br/><br/>Can be used with the `x-amz-copy-source-if-unmodified-since` header. |
| `x-amz-copy-source-if-none-match` | Object copying criteria.<br/><br/>If the `ETag` of the object isn't the same as in the header, the object is copied.<br/><br/>If the criteria isn't met, {{ objstorage-name }} returns a 412 error.<br/><br/>Can be used with the  `x-amz-copy-source-if-modified-since` method. |
| `x-amz-copy-source-if-unmodified-since` | Object copying criteria.<br/><br/>The object is copied if it didn't change since the specified time.<br/><br/>If the criteria isn't met, {{ objstorage-name }} returns a 412 error.<br/><br/>Can be used with the `x-amz-copy-source-if-match` header. |
| `x-amz-copy-source-if-modified-since` | Object copying criteria.<br/><br/>The object is copied if it changed since the specified time.<br/><br/>If the criteria isn't met, {{ objstorage-name }} returns a 412 error.<br/><br/>Can be used with the `x-amz-copy-source-if-none-match` header. |

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

Additionally, {{ objstorage-name }} may return errors described in the table below.

| Error | Description | HTTP code |
| ----- | ----- | ----- |
| `NoSuchUpload` | The specified upload doesn't exist. The specified upload ID might be incorrect or the upload was completed or deleted. | 404 Not Found |
| `EntityTooSmall` | The part is too small.<br/><br/>The uploaded part must be at least 5 MB. | 400 Bad Request |

### Data schema {#response-scheme}

```
<CopyObjectResult>
   <LastModified>2019-02-15T14:32:00</LastModified>
   <ETag>"9bgh7535f2734ec974343yuc93985328"</ETag>
</CopyObjectResult>
```

| Element | Description |
| ----- | ----- |
| `CopyObjectResult` | Contains response elements.<br/><br/>Path: `/CopyObjectResult`. |
| `ETag` | `ETag` of the resulting part of multipart upload.<br/><br/>Path: `/CopyObjectResult/ETag`. |
| `LastModified` | Date when a part of multipart upload was last modified.<br/><br/>Path: `/CopyObjectResult/LastModified`. |

