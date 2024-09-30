---
title: "copyPart method. {{ objstorage-name }} API (S3)"
description: "The copyPart method in the {{ objstorage-name }} API (S3) copies part of an object. It provides the same functionality as the uploadPart method but data is copied from an existing object rather than transmitted in the request body."
---

# copyPart method

Copies part of an object.

This method works much the same as [{#T}](uploadpart.md), except that it copies data from an existing object rather than providing it in the request body.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PUT /{bucket}/{key}?partNumber=PartNumber&uploadId=UploadId HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Name of the resulting bucket.
`key` | Key of the resulting object. ID that the object is saved with in {{ objstorage-name }}.

### Query parameters {#request-parameters}

Parameter | Description
----- | -----
`partNumber` | ID that you assigned to the uploaded part.
`uploadId` | ID of the multipart upload returned by {{ objstorage-name }} at [startup](startupload.md).


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

The `Content-Length` header is required. The headers listed in the table below are also required.

Header | Description
----- | -----
`X-Amz-Copy-Source` | The name of the bucket and the key of the object whose data will be copied, separated by `/`.<br/><br/>For example, `X-Amz-Copy-Source: /source_bucket/sourceObject`.
`X-Amz-Copy-Source-Range` | Byte range to copy from the source object. For example, if you specify `X-Amz-Copy-Source-Range:bytes=10-36`, then {{ objstorage-name }} will copy the range from the 10th to the 36th bytes of the source object.

The `Content-MD5` header is required if [default object locks](../../../concepts/object-lock.md#default) are configured in the bucket.

If you want to add copy conditions, use the headers listed in the table below.

Use the headers from the table below if you need to change the default behavior for the `copy` method.

Header | Description
----- | -----
`X-Amz-Copy-Source-If-Match` | Object copying condition.<br/><br/>If `ETag` of an object is the same as in the header, the object is copied.<br/><br/>If the condition is not met, {{ objstorage-name }} returns the 412 error.<br/><br/>You can use it with the `X-Amz-Copy-Source-If-Unmodified-Since` header.
`X-Amz-Copy-Source-If-None-Match` | Object copying condition.<br/><br/>If `ETag` of an object is not the same as in the header, the object is copied.<br/><br/>If the condition is not met, {{ objstorage-name }} returns the 412 error.<br/><br/>You can use it with the `X-Amz-Copy-Source-If-Modified-Since` header.
`X-Amz-Copy-Source-If-Unmodified-Since` | Object copying condition.<br/><br/>The object is copied if it has not been modified since the specified time.<br/><br/>If the condition is not met, {{ objstorage-name }} returns the 412 error.<br/><br/>You can use it with the `X-Amz-Copy-Source-If-Match` header.
`X-Amz-Copy-Source-If-Modified-Since` | Object copying condition.<br/><br/>The object is copied if it has been modified since the specified time.<br/><br/>If the condition is not met, {{ objstorage-name }} returns the 412 error.<br/><br/>You can use it with the `X-Amz-Copy-Source-If-None-Match` header.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).


### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

Additionally, {{ objstorage-name }} may return errors described in the table below.

Error | Description | HTTP code
----- | ----- | -----
`NoSuchUpload` | The specified upload does not exist. The specified upload ID may be incorrect or the upload was completed or deleted. | 404 Not Found
`EntityTooSmall` | The part is too small.<br/><br/>The part to upload must be at least 5 MB. | 400 Bad Request


### Data schema {#response-scheme}

```xml
<CopyObjectResult>
   <LastModified>2019-02-15T14:32:00</LastModified>
   <ETag>"9bgh7535f2734ec974343yuc93985328"</ETag>
</CopyObjectResult>
```

Element | Description
----- | -----
`CopyObjectResult` | It contains response elements.<br/><br/>Path: `/CopyObjectResult`.
`ETag` | `ETag` of the resulting part of a multipart upload.<br/><br/>Path: `/CopyObjectResult/ETag`.
`LastModified` | Date when a part of a multipart upload was last modified.<br/><br/>Path: `/CopyObjectResult/LastModified`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}