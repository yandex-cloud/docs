# General procedure for multipart upload

Multipart upload allows saving objects to Yandex {{ objstorage-name }} in parts. This can be useful when uploading or copying large objects. We recommend that you use multipart upload for objects starting from 100 MB in size.

To find out the maximum size of an object to upload, see the section [#T](../../concepts/limits.md).

Multipart upload consists of the following steps:

1. Starting upload.
The user sends the [start multipart upload request](multipart/startupload.md) and{{ objstorage-name }} returns the ID to be used for all subsequent upload operations.
At this step, user-defined metadata should be passed.

1. Uploading an object in parts.
Each part of the object is sent in a [separate request](multipart/uploadpart.md) and must have a sequence number that is used to build the object on the {{ objstorage-name }} side. If {{ objstorage-name }} receives two parts of the object with the same number, it will save the last one received.
For each uploaded part, {{ objstorage-name }} returns the `ETag` header in the response. The user should save the numbers and their corresponding `ETag` headers for all uploaded parts. This is necessary when running the complete upload operation.
During the upload, you can get from {{ objstorage-name }} [a list of already uploaded object parts](multipart/listparts.md).

1. Completing upload.
Upon receipt of the [complete upload request](multipart/completeupload.md,) {{ objstorage-name }} combines all the uploaded parts into a single object and attaches the metadata that was passed for starting the upload.

    {% note info %}

    Until the upload is completed, the object parts are stored separately and occupy some space, therefore they cannot be retrieved from {{ objstorage-name }}. Incomplete uploads are taken into account when calculating the space used.

    {% endnote %}

    In addition to the complete upload request, the user can send the [abort upload request](multipart/abortupload.md). In this case, {{ objstorage-name }} deletes all the object parts received for the specified upload and the upload itself.
After completing or aborting an upload, the user will not be able to use the ID of that upload in requests.

You can run several multipart uploads simultaneously.

You can also [get a list of incomplete uploads](multipart/listuploads.md).

Multipart upload methods:

| Method | Description |
| ----- | -------- |
| [startUpload](multipart/startupload.md) | Starts multipart upload. |
| [uploadPart](multipart/uploadpart.md) | Uploads a part of an object. |
| [copyPart](multipart/copypart.md) | Copies part of an object. |
| [listParts](multipart/listparts.md) | Displays a list of uploaded parts. |
| [abortUpload](multipart/abortupload.md) | Aborts multipart upload. |
| [completeUpload](multipart/completeupload.md) | Completes multipart upload. |
| [listUploads](multipart/listuploads.md) | Returns a list of incomplete uploads. |

