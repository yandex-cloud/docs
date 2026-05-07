---
title: What S3 API methods can be used to manage {{ objstorage-full-name }}
description: In this article, you will learn what S3 API methods can be used to manage {{ objstorage-name }}.
---

# All services and methods

The {{ objstorage-name }} HTTP API provides the following services:

Service | Description
-------|---------
[Bucket](bucket.md) | Manages buckets.
[Object](object.md) | Manages objects.
[Multipart upload](multipart.md) | Controls upload of large objects.
[Static Website Hosting](hosting.md) | Manages bucket configurations for static website hosting.
[CORS](cors.md) | Manages CORS configurations for buckets.
[Lifecycles](lifecycles.md) | Manages bucket object lifecycle configurations.
[ACL](acl.md) | Manages access control lists.
[Bucket Policy](policy.md) | Manages bucket access policies.

## Supported methods {#operations-list}

### Bucket service {#bucket-service}

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

### Object service {#object-service}

Method | Description
----- | -----
[PutObject](object/upload.md) | Uploads an object to {{ objstorage-name }}.
[GetObject](object/get.md) | Retrieves an object from {{ objstorage-name }}.
[patch](object/patch.md) | [Partially modifies](../../concepts/object-patch.md) an object.
[CopyObject](object/copy.md) | Copies an object stored in {{ objstorage-name }}.
[HeadObject](object/getobjectmeta.md) | Retrieves object metadata.
[DeleteObject](object/delete.md) | Deletes an object.
[DeleteObjects](object/deletemultipleobjects.md) | Deletes objects based on a list.
[options](object/options.md) | Checks whether a CORS request to an object can be made.
[SelectObjectContent](object/select.md) | Filters and returns the contents of an object using an SQL query.
[PutObjectRetention](object/putobjectretention.md) | Puts [retention](../../concepts/object-lock.md) on the object version or configures/disables a previously set lock.
[PutObjectLegalHold](object/putobjectlegalhold.md) | Puts or removes legal hold for an object version.
[GetObjectRetention](object/getobjectretention.md) | Returns the settings of the retention put on an object version.
[GetObjectLegalHold](object/getobjectlegalhold.md) | Returns the settings of the legal hold placed on the object version.
[PutObjectTagging](object/putobjecttagging.md) | Adds [labels](../../concepts/tags.md) to an object.
[GetObjectTagging](object/getobjecttagging.md) | Returns object labels.
[DeleteObjectTagging](object/deleteobjecttagging.md) | Deletes object labels.

### Multipart upload service {#multipart-upload-service}

Method | Description
----- | -----
[CreateMultipartUpload](multipart/startupload.md) | Starts a multipart upload.
[UploadPart](multipart/uploadpart.md) | Uploads a part of an object.
[UploadPartCopy](multipart/copypart.md) | Copies part of an object.
[ListParts](multipart/listparts.md) | Returns a list of uploaded parts.
[AbortMultipartUpload](multipart/abortupload.md) | Aborts a multipart upload.
[CompleteMultipartUpload](multipart/completeupload.md) | Completes a multipart upload.
[ListMultipartUploads](multipart/listuploads.md) | Returns a list of incomplete uploads.

### Static Website Hosting service {#static-website-hosting-service}

Method | Description
----- | -----
[PutBucketWebsite](hosting/upload.md) | Uploads a bucket configuration for static website hosting to {{ objstorage-name }}.
[GetBucketWebsite](hosting/get.md) | Returns a bucket configuration for static website hosting from {{ objstorage-name }}.
[DeleteBucketWebsite](hosting/delete.md) | Deletes a bucket configuration for static website hosting.

### CORS service {#cors-service}

Method | Description
----- | -----
[PutBucketCors](cors/upload.md) | Uploads a CORS configuration for a bucket.
[GetBucketCors](cors/get.md) | Returns a CORS configuration for a bucket.
[DeleteBucketCors](cors/delete.md) | Deletes a CORS configuration for a bucket.

### Lifecycles service {#lifecycles-service}

Method | Description
----- | -----
[PutBucketLifecycleConfiguration](lifecycles/upload.md) | Uploads an object lifecycle configuration to {{ objstorage-name }}.
[GetBucketLifecycleConfiguration](lifecycles/get.md) | Returns an object lifecycle configuration from {{ objstorage-name }}.
[DeleteBucketLifecycle](lifecycles/delete.md) | Deletes an object lifecycle configuration from {{ objstorage-name }}.

### ACL service {#acl-service}

Method | Description
----- | -----
[GetObjectAcl](acl/objectget.md) | Returns an access control list for an object.
[PutObjectAcl](acl/objectput.md) | Uploads an access control list for an object.
[GetBucketAcl](acl/bucketget.md) | Returns an access control list for a bucket.
[PutBucketAcl](acl/bucketput.md) | Uploads an access control list for a bucket.

### Bucket Policy service {#bucket-policy}

Method | Description
----- | -----
[GetBucketPolicy](policy/get.md) | Returns the access policy for the specified bucket.
[PutBucketPolicy](policy/put.md) | Applies the access policy to the specified bucket.
[DeleteBucketPolicy](policy/delete.md) | Removes the access policy from the specified bucket.

## See also {#see-also}

* [{#T}](../../s3/s3-api-quickstart.md)
* [{#T}](../../s3/index.md)
* [{#T}](../../tools/index.md)
* [Debugging requests using the AWS CLI](../signing-requests.md#debugging)
* [Example of sending a signed request using curl](../../api-ref/authentication.md#s3-api-example)
* [Code example for generating a signature](../../concepts/pre-signed-urls.md#code-examples)