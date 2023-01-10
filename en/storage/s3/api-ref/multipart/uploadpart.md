---
title: "uploadPart method. {{ objstorage-name }} API (S3)"
description: "The uploadPart method in {{ objstorage-name }} API (S3) saves a part of the object. Users number object parts themselves and pass the numbers to {{ objstorage-name }}. The number uniquely identifies the part and determines its position in the general sequence. The number is an integer in the range from 1 to 10000 inclusive."
---

# uploadPart method

Saves a part of an object.

Users number object parts themselves and pass the numbers to {{ objstorage-name }}. The number uniquely identifies the part and determines its position in the general sequence. The number is an integer in the range from 1 to 10000 inclusive.

If multiple parts with the same number are uploaded, {{ objstorage-name }} saves the last one received.

The size of each part, except the last one, should be at least 5 MB.

For more information, see [{#T}](../multipart.md).


## Request {#request}

```
PUT /{bucket}/{key}?partNumber=PartNumber&uploadId=UploadId HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. |


### Query parameters {#request-parameters}

| Parameter | Description |
----- | -----
| `partNubmer` | ID that you assigned to the uploaded part. |
| `uploadId` | ID of the multipart upload returned by {{ objstorage-name }} at [startup](startupload.md). |


### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

The `Content-Length` header is required.

The `Content-MD5` header is mandatory if [default object locks](../../../concepts/object-lock.md#default) are set up in the bucket.


## Response {#response}

### Headers {#response-headers}

A response may contain [common response headers](../common-response-headers.md) and the headers listed in the table below.

| Header | Description |
----- | -----
| `X-Amz-Storage-Class` | Object [storage class](../../../concepts/storage-class.md).<br/>Has the `COLD` value if the object is in cold storage{% if audience != "internal" %}, or `ICE` if in ice storage.{% endif %}<br/><br/>If the object is stored in standard storage, there's no header. |


### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

Additionally, {{ objstorage-name }} may return errors described in the table below.

| Error | Description | HTTP code |
----- | ----- | -----
| `NoSuchUpload` | The specified upload doesn't exist. The specified upload ID might be incorrect or the upload was completed or deleted. | 404 Not Found |
| `EntityTooSmall` | The part is too small.<br/><br/>The uploaded part must be at least 5 MB. | 400 Bad Request |


