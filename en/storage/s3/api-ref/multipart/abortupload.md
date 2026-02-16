# abortUpload method

Aborts an upload and deletes all the saved object parts from {{ objstorage-name }}. If the abort upload request was received when uploading any part, no result is guaranteed.

We recommend that you [get a list of parts](listparts.md) after aborting the upload and, if it is not empty, resend the request until the list of the parts becomes empty.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
DELETE /{bucket}/{key}?uploadId=UploadId HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.


### Request parameters {#request-parameters}

Parameter | Description
----- | -----
`uploadId` | ID of the multipart upload returned by {{ objstorage-name }} at [startup](startupload.md).


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

Additionally, {{ objstorage-name }} may return errors described in the table below.

Error | Description | HTTP code
----- | ----- | -----
`NoSuchUpload` | The specified upload does not exist. This may happen if you specify a wrong upload ID or the upload was completed or deleted. | 404 Not Found


{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}