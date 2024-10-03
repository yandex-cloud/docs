---
title: What S3 API methods can be used to manage {{ objstorage-full-name }} buckets
description: In this tutorial, you will learn what S3 API methods can be used to manage buckets.
---

# All Bucket methods

#|
|| **Method** | **Description** ||
|| [create](bucket/create.md) | Creates a bucket. ||
|| [getMeta](bucket/getmeta.md) | Checks the existence of a bucket and access to it. ||
|| [listObjects](bucket/listobjects.md) | Returns a list of objects in a bucket. ||
|| [listBuckets](bucket/list.md) | Returns a list of buckets. ||
|| [deleteBucket](bucket/delete.md) | Deletes a bucket. ||


|| [getBucketEncryption](bucket/getbucketencryption.md) | Checks whether a bucket is encrypted. ||
|| [deleteBucketEncryption](bucket/deletebucketencryption.md) | Removes encryption from a bucket. ||
|| [putBucketEncryption](bucket/putbucketencryption.md) | Adds encryption to a bucket. ||


|| [putBucketVersioning](bucket/putBucketVersioning.md) | Enables or pauses bucket versioning. ||
|| [getBucketVersioning](bucket/getBucketVersioning.md) | Returns the versioning option state. ||
|| [putBucketLogging](bucket/putBucketLogging.md) | Enables and disables bucket actions logging.


||
|| [getBucketLogging](bucket/getBucketLogging.md) | Returns the settings for bucket actions logging.


||
|| [listObjectVersions](bucket/listObjectVersions.md) | Returns metadata about all versions of objects in a bucket. ||
|| [putObjectLockConfiguration](bucket/putobjectlockconfiguration.md) | Sets up the mechanism of [object version locks](../../concepts/object-lock.md) in a [versioned](../../concepts/versioning.md) bucket. ||
|| [getObjectLockConfiguration](bucket/getobjectlockconfiguration.md) | Returns the locking mechanism settings. ||
|| [putBucketTagging](bucket/putbuckettagging.md) | Adds [labels](../../concepts/tags.md) to a bucket. ||
|| [getBucketTagging](bucket/getbuckettagging.md) | Returns bucket labels. ||
|| [deleteBucketTagging](bucket/deletebuckettagging.md) | Deletes bucket labels. ||
|#

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}