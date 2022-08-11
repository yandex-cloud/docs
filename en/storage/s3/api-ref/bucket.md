# All Bucket methods

{% if product == "yandex-cloud" %}

| Method | Description |
| ----- | ----- |
| [create](bucket/create.md) | Creates a bucket. |
| [getMeta](bucket/getmeta.md) | Checks the existence of a bucket and access to it. |
| [listObjects](bucket/listobjects.md) | Returns a list of bucket objects. |
| [listBuckets](bucket/list.md) | Returns a list of buckets. |
| [deleteBucket](bucket/delete.md) | Deletes a bucket. |
| [putBucketVersioning](bucket/putBucketVersioning.md) | Enables or pauses versioning of the bucket. |
| [getBucketVersioning](bucket/getBucketVersioning.md) | Returns the versioning status. |
| [putBucketLogging](bucket/putBucketLogging.md) | Enables and disables logging of actions with the bucket. |
| [getBucketLogging](bucket/getBucketLogging.md) | Returns settings for logging actions with the bucket. |
| [listObjectVersions](bucket/listObjectVersions.md) | Returns metadata for all versions of objects in the bucket. |

{% endif %}

{% if product == "cloud-il" %}

Method | Description
----- | -----
[create](bucket/create.md) | Creates a bucket.
[getMeta](bucket/getmeta.md) | Checks the existence of a bucket and access to it.
[listObjects](bucket/listobjects.md) | Returns a list of bucket objects.
[listBuckets](bucket/list.md) | Returns a list of buckets.
[deleteBucket](bucket/delete.md) | Deletes a bucket.
[putBucketVersioning](bucket/putBucketVersioning.md) | Enables or pauses versioning of the bucket.
[getBucketVersioning](bucket/getBucketVersioning.md) | Returns the versioning status.
[listObjectVersions](bucket/listObjectVersions.md) | Returns metadata for all versions of objects in the bucket.

{% endif %}