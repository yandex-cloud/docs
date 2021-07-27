---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# abortUpload method

Aborts an upload and deletes all object parts that were saved from {{ objstorage-name }}. If the abort upload request was received during the upload of any part, no result is guaranteed.

We recommend that you [get a list of parts](listparts.md) after aborting the upload and, if it is not empty, resend the request. Abort requests should be sent until the list of parts is returned empty.

## Request {#request}

```
DELETE /{bucket}/{key}?uploadId=UploadId HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |
| `key` | Object key. |

### Query parameters {#request-parameters}

| Parameter | Description |
| ----- | ----- |
| `uploadId` | ID of the multipart upload returned by {{ objstorage-name }} at the [start](startupload.md). |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

Additionally, {{ objstorage-name }} may return errors described in the table below.

| Error | Description | HTTP code |
| ----- | ----- | ----- |
| `NoSuchUpload` | The specified upload doesn't exist. The specified upload ID might be incorrect or the upload was completed or deleted. | 404 Not Found |

