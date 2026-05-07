---
title: Multipart upload of objects to a {{ objstorage-full-name }} bucket step-by-step
description: In this article, you will learn how to upload objects to buckets in parts.
---

# Multipart upload process

Multipart upload allows you to save objects to {{ objstorage-name }} in parts. This can be useful when uploading or copying large objects. We recommend using a multipart upload for objects that are at least 100 MB.

To find out the maximum size for an object you can upload, see [{#T}](../../concepts/limits.md).

The multipart upload includes the following steps:
1. Upload initiation.
    The user sends a [request to initiate a multipart upload (CreateMultipartUpload)](multipart/startupload.md), and {{ objstorage-name }} returns an ID for all subsequent operations with the upload.
    User-defined object metadata should be provided at this step.
1. Multipart object upload.
    Each part of the object is sent as a [separate request (UploadPart)](multipart/uploadpart.md) and required to have a sequence number {{ objstorage-name }} will use to assemble the object. If {{ objstorage-name }} receives two parts of the object with the same number, it will save the last one received.
    For each uploaded part, {{ objstorage-name }} returns the `ETag` header in the response. The user should save the numbers and their corresponding `ETag` values for all uploaded parts. It is necessary for the upload complete operation.
    During the upload, {{ objstorage-name }} can give you a [list of already uploaded object parts (ListParts)](multipart/listparts.md).
1. Completing the upload.
    Once it gets the [complete upload request (CompleteMultipartUpload)](multipart/completeupload.md), {{ objstorage-name }} assembles all the uploaded parts into a single object and attaches to it the metadata provided during the initiation of the upload.

    {% note info %}

    Until the upload is complete, the object parts are stored separately and take up space, but you cannot retrieve them from {{ objstorage-name }}. Incomplete uploads are taken into account when calculating the space used.

    {% endnote %}

    Other than the complete upload request, the user can also send the [abort upload request (AbortMultipartUpload)](multipart/abortupload.md). In this case, {{ objstorage-name }} deletes all the parts of the object it received and the upload itself.
    After completing or aborting an upload, the user will not be able to use the ID of that upload in requests.

You can run several multipart uploads simultaneously.

You can [get a list of incomplete uploads (ListMultipartUploads)](multipart/listuploads.md).

Multipart upload methods:

Method|Description
-----|--------
[CreateMultipartUpload](multipart/startupload.md) | Starts a multipart upload.
[UploadPart](multipart/uploadpart.md) | Uploads a part of an object.
[UploadPartCopy](multipart/copypart.md) | Copies part of an object.
[ListParts](multipart/listparts.md) | Returns a list of uploaded parts.
[AbortMultipartUpload](multipart/abortupload.md) | Aborts a multipart upload.
[CompleteMultipartUpload](multipart/completeupload.md) | Completes a multipart upload.
[ListMultipartUploads](multipart/listuploads.md) | Returns a list of incomplete uploads.

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}