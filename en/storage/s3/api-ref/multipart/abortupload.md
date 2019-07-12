# abortUpload method

Aborts an upload and deletes from Object Storage all object parts that have been saved. If the abort upload request was received during the upload of any part, no result is guaranteed.

We recommend that you [get a list of parts](listparts.md) after aborting the upload and, if it is not empty, resend the request. Abort requests should be sent until the list of parts is returned empty.

## Request {#request}

```
DELETE /{bucket}/{key}?uploadId=UploadId HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |
| `key` | Object key. |

### Query parameters {#request-parameters}

| Parameter | Description |
| ----- | ----- |
| `uploadId` | ID of the multipart upload returned by Object Storage at the [start](startupload.md). |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [#T](../response-codes.md).

Additionally, Object Storage may return errors described in the table below.

| Error | Description | HTTP code |
| ----- | ----- | ----- |
| `NoSuchUpload` | The specified upload does not exist. The specified upload ID might be incorrect or the upload was completed or deleted. | 404 Not Found |

