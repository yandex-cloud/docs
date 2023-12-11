---
title: "What S3 API methods can be used to manage {{ objstorage-full-name }}"
description: "In this tutorial, you will learn about the S3 API methods you can use to manage {{ objstorage-full-name }}."
---

# All services and methods

{{ objstorage-name }} HTTP API provides the following services:

| Service | Description |
-------|---------
| [Bucket](bucket.md) | Manages the buckets. |
| [Object](object.md) | Performs object management. |
| [Multipart upload](multipart.md) | Controls uploading of large objects. |
| [Static Website Hosting](hosting.md) | Manages bucket configurations for static web hosting. |
| [CORS](cors.md) | Manages CORS configurations for buckets. |
| [Lifecycles](lifecycles.md) | Manages bucket object lifecycle configurations. |
| [ACL](acl.md) | Manages access control lists. |
| [Bucket Policy](policy.md) | Manages the bucket access policies. |

## Supported methods {#operations-list}

### Bucket service {#bucket-service}



| Method | Description |
----- | -----
| [create](bucket/create.md) | Creates a bucket. |
| [getBucketEncryption](bucket/getbucketencryption.md) | Checks whether the bucket is encrypted. |
| [getMeta](bucket/getmeta.md) | Checks the existence of a bucket and access to it. |
| [listObjects](bucket/listobjects.md) | Returns a list of bucket objects. |
| [listBuckets](bucket/list.md) | Returns a list of buckets. |
| [deleteBucket](bucket/delete.md) | Deletes a bucket. |
| [deleteBucketEncryption](bucket/deletebucketencryption.md) | Removes encryption from the bucket. |
| [putBucketEncryption](bucket/putbucketencryption.md) | Adds encryption to the bucket. |
| [putBucketVersioning](bucket/putBucketVersioning.md) | Enables or pauses versioning of the bucket. |
| [getBucketVersioning](bucket/getBucketVersioning.md) | Returns the versioning status. |
| [putBucketLogging](bucket/putBucketLogging.md) | Enables and disables logging of actions with the bucket. |
| [getBucketLogging](bucket/getBucketLogging.md) | Returns settings for logging actions with the bucket. |
| [listObjectVersions](bucket/listObjectVersions.md) | Returns metadata for all versions of objects in the bucket. |
| [putObjectLockConfiguration](bucket/putobjectlockconfiguration.md) | Sets up the mechanism of [object version locks](../../concepts/object-lock.md) in a [versioned bucket](../../concepts/versioning.md). |
| [getObjectLockConfiguration](bucket/getobjectlockconfiguration.md) | Returns the lock configuration. |
| [putBucketTagging](bucket/putbuckettagging.md) | Adds [labels](../../concepts/tags.md) to a bucket. |
| [getBucketTagging](bucket/getbuckettagging.md) | Returns bucket labels. |
| [deleteBucketTagging](bucket/deletebuckettagging.md) | Deletes bucket labels. |




### Object service {#object-service}

| Method | Description |
----- | -----
| [upload](object/upload.md) | Uploads an object to {{ objstorage-name }}. |
| [get](object/get.md) | Retrieves an object from {{ objstorage-name }}. |
| [patch](object/patch.md) | [Partially modifies](../../concepts/object-patch.md) an object. |
| [copy](object/copy.md) | Copies an object stored in {{ objstorage-name }}. |
| [getObjectMeta](object/getobjectmeta.md) | Retrieves object metadata. |
| [delete](object/delete.md) | Deletes an object. |
| [deleteMultipleObjects](object/deletemultipleobjects.md) | Deletes objects based on a list. |
| [options](object/options.md) | Checks whether a CORS request to an object can be made. |
| [selectObjectContent](object/select.md) | Filters and returns the contents of an object based on an SQL query. |
| [putObjectRetention](object/putobjectretention.md) | Puts [retention](../../concepts/object-lock.md) on the object version or enables/disables a previously set lock. |
| [putObjectLegalHold](object/putobjectlegalhold.md) | Puts or removes legal hold for an object version. |
| [getObjectRetention](object/getobjectretention.md) | Returns the settings of retention put on the object version. |
| [getObjectLegalHold](object/getobjectlegalhold.md) | Returns the settings of legal hold put on the object version. |
| [putObjectTagging](object/putobjecttagging.md) | Adds [labels](../../concepts/tags.md) to an object. |
| [getObjectTagging](object/getobjecttagging.md) | Returns object labels. |
| [deleteObjectTagging](object/deleteobjecttagging.md) | Deletes object labels. |

### Multipart upload service {#multipart-upload-service}

| Method | Description |
----- | -----
| [startUpload](multipart/startupload.md) | Starts multipart upload. |
| [uploadPart](multipart/uploadpart.md) | Uploads a part of an object. |
| [copyPart](multipart/copypart.md) | Copies part of an object. |
| [listParts](multipart/listparts.md) | Displays a list of uploaded parts. |
| [abortUpload](multipart/abortupload.md) | Aborts multipart upload. |
| [completeUpload](multipart/completeupload.md) | Completes multipart upload. |
| [listUploads](multipart/listuploads.md) | Returns a list of incomplete uploads. |

### Static Website Hosting service {#static-website-hosting-service}

| Method | Description |
----- | -----
| [upload](hosting/upload.md) | Uploads a bucket configuration for static website hosting to {{ objstorage-name }}. |
| [get](hosting/get.md) | Returns a bucket configuration for static website hosting from {{ objstorage-name }}. |
| [delete](hosting/delete.md) | Deletes a bucket configuration for static website hosting. |

### CORS service {#cors-service}

| Method | Description |
----- | -----
| [upload](cors/upload.md) | Uploads a CORS configuration for a bucket. |
| [get](cors/get.md) | Returns a CORS configuration for a bucket. |
| [delete](cors/delete.md) | Deletes a CORS configuration for a bucket. |

### Lifecycles service {#lifecycles-service}

| Method | Description |
----- | -----
| [upload](lifecycles/upload.md) | Uploads an object lifecycle configuration to {{ objstorage-name }}. |
| [get](lifecycles/get.md) | Returns an object lifecycle configuration from {{ objstorage-name }}. |
| [delete](lifecycles/delete.md) | Deletes an object lifecycle configuration from {{ objstorage-name }}. |

### ACL service {#acl-service}

| Method | Description |
----- | -----
| [objectGetAcl](acl/objectget.md) | Returns the access control list for an object. |
| [objectPutAcl](acl/objectput.md) | Uploads an access control list for an object. |
| [bucketGetAcl](acl/bucketget.md) | Returns the access control list for a bucket. |
| [bucketPutAcl](acl/bucketput.md) | Uploads an access control list for a bucket. |

### Bucket Policy service {#bucket-policy}

| Method | Description |
----- | -----
| [GetBucketPolicy](policy/get.md) | Returns the access policy for the specified bucket. |
| [PutBucketPolicy](policy/put.md) | Applies the access policy to the specified bucket. |
| [DeleteBucketPolicy](policy/delete.md) | Removes the access policy from the specified bucket. |

## See also {#see-also}
* [{#T}](../../s3/index.md)
* [{#T}](../../tools/index.md)
