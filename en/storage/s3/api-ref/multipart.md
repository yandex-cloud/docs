---
title: Multipart upload of objects to a {{ objstorage-full-name }} bucket step-by-step
description: In this article, you will learn how to upload objects to buckets in parts.
---

# Multipart upload process

Multipart upload allows you to save objects to {{ objstorage-name }} in parts. This can be useful when uploading or copying large objects. We recommend using a multipart upload for objects that are at least 100 MB.

To find out the maximum size for an object you can upload, see [{#T}](../../concepts/limits.md).

The multipart upload includes the following steps:
1. Initiating the upload.
    The user sends the [request to initiate a multipart upload](multipart/startupload.md) and {{ objstorage-name }} returns the ID to use for all subsequent upload operations.
    At this step, you should provide user-defined object metadata.
1. Uploading an object in parts.
    Each part of the object is sent in a [separate request](multipart/uploadpart.md) and must have a sequence number for {{ objstorage-name }} to assemble the object. If {{ objstorage-name }} receives two parts of the object with the same number, it will save the last one received.
    For each uploaded part, {{ objstorage-name }} returns the `ETag` header in the response. The user should save the numbers and their matching `ETag` values for all uploaded parts to complete the upload operation.
    During the upload, you can get a [list of uploaded object parts](multipart/listparts.md) from {{ objstorage-name }}.
1. Completing the upload.
    After receiving the [complete upload request](multipart/completeupload.md), {{ objstorage-name }} assembles all the uploaded parts into a single object and attaches the metadata provided at the upload initiation.

    {% note info %}

    Until the upload is complete, the object parts are stored separately and take up space, but you cannot retrieve them from {{ objstorage-name }}. Incomplete uploads are taken into account when calculating the space used.

    {% endnote %}

    In addition to the complete upload request, the user can send the [abort upload request](multipart/abortupload.md). In this case, {{ objstorage-name }} deletes all the parts of the object it received and the upload itself.
    After completing or aborting an upload, the user will not be able to use the ID of that upload in requests.

You can run several multipart uploads simultaneously.

You can also [get a list of incomplete uploads](multipart/listuploads.md).

Multipart upload methods:

Method|Description
-----|--------
[startUpload](multipart/startupload.md) | Starts a multipart upload.
[uploadPart](multipart/uploadpart.md) | Uploads a part of an object.
[copyPart](multipart/copypart.md) | Copies part of an object.
[listParts](multipart/listparts.md) | Returns a list of uploaded parts.
[abortUpload](multipart/abortupload.md) | Aborts a multipart upload.
[completeUpload](multipart/completeupload.md) | Completes a multipart upload.
[listUploads](multipart/listuploads.md) | Returns a list of incomplete uploads.

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}