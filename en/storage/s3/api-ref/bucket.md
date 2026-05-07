---
title: What S3 API methods can be used to manage {{ objstorage-full-name }} buckets
description: In this article, you will learn what S3 API methods can be used to manage buckets.
---

# All Bucket methods

#|
|| **Method** | **Description** ||
|| [CreateBucket](bucket/create.md) | Creates a bucket. ||
|| [HeadBucket](bucket/getmeta.md) | Checks the existence of a bucket and access to it. ||
|| [ListObjects](bucket/listobjects.md) | Returns a list of bucket objects. ||
|| [ListBuckets](bucket/list.md) | Returns a list of buckets. ||
|| [DeleteBucket](bucket/delete.md) | Deletes a bucket. ||


|| [GetBucketEncryption](bucket/getbucketencryption.md) | Checks whether the bucket is encrypted. ||
|| [DeleteBucketEncryption](bucket/deletebucketencryption.md) | Removes encryption from the bucket. ||
|| [PutBucketEncryption](bucket/putbucketencryption.md) | Adds encryption to the bucket. ||


|| [PutBucketVersioning](bucket/putBucketVersioning.md) | Enables or suspends bucket versioning. ||
|| [GetBucketVersioning](bucket/getBucketVersioning.md) | Returns the versioning status. ||
|| [PutBucketLogging](bucket/putBucketLogging.md) | Enables and disables bucket logging.


||
|| [GetBucketLogging](bucket/getBucketLogging.md) | Returns the settings for bucket logging.


||
|| [ListObjectVersions](bucket/listObjectVersions.md) | Returns metadata for all versions of objects in the bucket. ||
|| [PutObjectLockConfiguration](bucket/putobjectlockconfiguration.md) | Sets up the mechanism of [object version locks](../../concepts/object-lock.md) in a [versioned bucket](../../concepts/versioning.md). ||
|| [GetObjectLockConfiguration](bucket/getobjectlockconfiguration.md) | Returns the lock configuration. ||
|| [PutBucketTagging](bucket/putbuckettagging.md) | Adds [labels](../../concepts/tags.md) to a bucket. ||
|| [GetBucketTagging](bucket/getbuckettagging.md) | Returns bucket labels. ||
|| [DeleteBucketTagging](bucket/deletebuckettagging.md) | Deletes bucket labels. ||
|#

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}