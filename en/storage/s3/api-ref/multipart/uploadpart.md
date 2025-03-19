---
title: uploadPart method. {{ objstorage-name }} API (S3)
description: The `uploadPart` method in the {{ objstorage-name }} API (S3) saves a part of the object. Users number object parts themselves and transmit these numbers to {{ objstorage-name }}. The number uniquely identifies the part and determines its position in the general sequence. The number is an integer from 1 to 10,000 inclusive.
---

# uploadPart method

Saves a part of an object.

Users number object parts themselves and transmit these numbers to {{ objstorage-name }}. The number uniquely identifies the part and determines its position in the general sequence. The number is an integer from 1 to 10,000 inclusive.

If multiple parts with the same number are uploaded, {{ objstorage-name }} saves the last one received.

The size of each part, except the last one, should be at least 5 MB.

For more information, see [{#T}](../multipart.md).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PUT /{bucket}/{key}?partNumber=PartNumber&uploadId=UploadId HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.


### Request parameters {#request-parameters}

Parameter | Description
----- | -----
`partNumber` | ID that you assigned to the uploaded part.
`uploadId` | ID of the multipart upload returned by {{ objstorage-name }} at [startup](startupload.md).


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

The `Content-Length` header is required.

The `Content-MD5` header is required if [default object locks](../../../concepts/object-lock.md#default) are configured in the bucket.


## Response {#response}

### Headers {#response-headers}

A response may contain [common headers](../common-response-headers.md) and the headers listed in the table below.

Header | Description
----- | -----
`X-Amz-Storage-Class` | [Storage class](../../../concepts/storage-class.md) of the object.<br/>It takes the `COLD` value if the object is in a cold storage, or `ICE`, if it is in an ice storage.<br/><br/>If the object is in a standard storage, there is no header.


### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

Additionally, {{ objstorage-name }} may return errors described in the table below.

Error | Description | HTTP code
----- | ----- | -----
`NoSuchUpload` | The specified upload does not exist. This may happen if you specify a wrong upload ID or the upload was completed or deleted. | 404 Not Found
`EntityTooSmall` | The part is too small.<br/><br/>The part to upload must be at least 5 MB. | 400 Bad Request

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}