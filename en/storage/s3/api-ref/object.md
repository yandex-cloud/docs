---
title: What S3 API methods can be used to manage objects in a {{ objstorage-full-name }} bucket
description: In this article, you will learn about S3 API methods that can be used to manage objects in a bucket.
---

# All Object methods

Method | Description
----- | -----
[PutObject](object/upload.md) | Uploads an object to {{ objstorage-name }}.
[GetObject](object/get.md) | Retrieves an object from {{ objstorage-name }}.
[patch](object/patch.md) | [Partially modifies](../../concepts/object-patch.md) an object.
[CopyObject](object/copy.md) | Copies an object stored in {{ objstorage-name }}.
[HeadObject](object/getobjectmeta.md) | Retrieves object metadata.
[DeleteObject](object/delete.md) | Deletes an object.
[DeleteObjects](object/deletemultipleobjects.md) | Deletes objects based on a list.
[options](object/options.md) | Checks whether a [CORS request](../../concepts/cors.md) to an object can be made.
[SelectObjectContent](object/select.md) | Filters and returns the contents of an object using an SQL query.
[PutObjectTagging](object/putobjecttagging.md) | Adds [labels](../../concepts/tags.md) to an object.
[GetObjectTagging](object/getobjecttagging.md) | Returns object labels.
[DeleteObjectTagging](object/deleteobjecttagging.md) | Deletes object labels.

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}