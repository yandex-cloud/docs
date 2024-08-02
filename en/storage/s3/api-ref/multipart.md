---
title: "General procedure for a multipart upload of objects to a {{ objstorage-full-name }} bucket"
description: "In this tutorial, you will learn about the steps for a multipart upload of objects to a bucket."
---

# General procedure for a multipart upload

Multipart upload lets you save objects to {{ objstorage-name }} in parts. This can be useful when uploading or copying large objects. We recommend using multipart upload for objects that are at least 100 MB.

To find out the maximum size for an uploaded object, see [{#T}](../../concepts/limits.md).

Multipart upload consists of the following steps:
1. Starting the upload.
   The user sends the [start multipart upload request](multipart/startupload.md) and {{ objstorage-name }} returns the ID to be used for all subsequent upload operations.
   At this step, user-defined metadata should be passed.
1. Uploading an object in parts.
   Each part of the object is sent in a [separate request](multipart/uploadpart.md) and must have a sequence number that is used to build the object on the {{ objstorage-name }} side. If {{ objstorage-name }} receives two parts of the object with the same number, it will save the last one received.
   For each uploaded part, {{ objstorage-name }} returns the `ETag` header in the response. The user should save the numbers and their corresponding `ETag` headers for all uploaded parts. It is necessary for the upload complete operation.
   During the upload, you can get a [list of already uploaded object parts](multipart/listparts.md) from {{ objstorage-name }}.
1. Completing the upload.
   After receiving the [complete upload request](multipart/completeupload.md), {{ objstorage-name }} combines all the uploaded parts into a single object and attaches the metadata that was passed when the upload started.

   {% note info %}

   Until the upload is complete, the object parts are stored separately and take up space, therefore they can't be retrieved from {{ objstorage-name }}. Incomplete uploads are taken into account when calculating the space used.

   {% endnote %}

   In addition to the complete upload request, the user can send the [abort upload request](multipart/abortupload.md). In this case, {{ objstorage-name }} deletes all the parts of the object that it received and the upload itself.
   After completing or aborting an upload, the user will not be able to use the ID of that upload in requests.

You can run several multipart uploads simultaneously.

You can also [get a list of incomplete uploads](multipart/listuploads.md).

Multipart upload methods:

| Method | Description |
-----|--------
| [startUpload](multipart/startupload.md) | Starts multipart upload. |
| [uploadPart](multipart/uploadpart.md) | Uploads a part of an object. |
| [copyPart](multipart/copypart.md) | Copies part of an object. |
| [listParts](multipart/listparts.md) | Displays a list of uploaded parts. |
| [abortUpload](multipart/abortupload.md) | Aborts multipart upload. |
| [completeUpload](multipart/completeupload.md) | Completes multipart upload. |
| [listUploads](multipart/listuploads.md) | Returns a list of incomplete uploads. |


{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}