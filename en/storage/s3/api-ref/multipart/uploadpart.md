# uploadPart method

Saves a part of an object.

Users number object parts themselves and pass the numbers to {{ objstorage-name }}. The number uniquely identifies the part and determines its position in the general sequence. The number is an integer in the range from 1 to 10000 inclusive.

If multiple parts with the same number are uploaded, {{ objstorage-name }} saves the last received.

The size of each part, except the last one, should be at least 5 MB.

For more information, see the section [#T](../multipart.md).

## Request {#request}

```
PUT /{bucket}/{key}?partNumber=PartNumber&uploadId=UploadId HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |
| `key` | Object key. |

### Query parameters {#request-parameters}

| Parameter | Description |
| ----- | ----- |
| `partNubmer` | ID that you assigned to the uploaded part. |
| `uploadId` | ID of the multipart upload returned by {{ objstorage-name }} at the [start](startupload.md). |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

The `Content-Length` header is required.

## Response {#response}

### Headers {#response-headers}

A response may contain [common response headers](../common-response-headers.md) and the headers listed in the table below.

| Header name | Description |
| ----- | ----- |
| `x-amz-storage-class` | Object storage class.<br/>The value is `COLD` if the object is stored in cold storage.<br/><br/>If it is stored in standard storage, the header is omitted. |

### Response codes {#response-codes}

For a list of possible responses, see [#T](../response-codes.md).

Additionally, {{ objstorage-name }} may return errors described in the table below.

| Error | Description | HTTP code |
| ----- | ----- | ----- |
| `NoSuchUpload` | The specified upload does not exist. The specified upload ID might be incorrect or the upload was completed or deleted. | 404 Not Found |
| `EntityTooSmall` | The part is too small.<br/><br/>The uploaded part must be at least 5 MB. | 400 Bad Request |

