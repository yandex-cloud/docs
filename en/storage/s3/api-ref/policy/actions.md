---
title: Actions upon triggering the {{ objstorage-full-name }} bucket access policy you can set in the S3 API
description: In this article, you will learn what actions upon triggering the {{ objstorage-full-name }} bucket access policy can be set in the S3 API.
---

# Actions

Action                        | S3 API method | Description
------------------------------- | ------------ | --------
`s3:AbortMultipartUpload`       | [abortUpload](../multipart/abortupload.md) | Gives the permission to abort a multipart upload.
`s3:DeleteBucketWebsite`        | [delete](../hosting/delete.md) | Gives the permission to delete the configuration of a bucket’s website.
`s3:DeleteObject`               | [delete](../object/delete.md) | Gives the permission to delete the null version and adds a delete marker to the latest object version.
`s3:DeleteObjectVersion`        | [delete](../object/delete.md) | Gives the permission to delete the specified object version.
`s3:GetBucketAcl`               | [bucketGetAcl](../acl/bucketget.md) | Gives the permission to read a bucket ACL.
`s3:GetBucketCORS`              | [get](../cors/get.md) | Gives the permission to read information about the CORS configuration.
`s3:GetBucketLocation`          | [GetBucketLocation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLocation.html) | Gives the permission to read information about a bucket's location.
`s3:GetBucketVersioning`        | [getBucketVersioning](../bucket/getBucketVersioning.md) | Gives the permission to read information about the bucket versioning.
`s3:GetBucketWebsite`           | [get](../hosting/get.md) | Gives the permission to read a bucket's website configuration.
`s3:GetEncryptionConfiguration` | [getBucketEncryption](../bucket/getbucketencryption.md) | Gives the permission to read a bucket's default encryption configuration.
`s3:GetLifecycleConfiguration`  | [get](../lifecycles/get.md) | Gives the permission to read a bucket's lifecycle configuration.
`s3:GetObject`                  | [get](../object/get.md) | Gives the permission to read objects.
`s3:GetObjectAcl`               | [objectGetAcl](../acl/objectget.md) | Gives the permission to read an object ACL.
`s3:GetObjectVersion`           | [get](../object/get.md) | Gives the permission to read a specific object version.
`s3:GetObjectVersionAcl`        | [get](../object/get.md) | Gives the permission to read a specific object version's ACL.
`s3:ListBucket`                 | [list](../bucket/list.md) | Gives the permission to read a list of some or all objects in a bucket.
`s3:ListBucketMultipartUploads` | [listUploads](../multipart/listuploads.md) | Gives the permission to read a list of incomplete multipart uploads.
`s3:ListBucketVersions`         | [listObjectVersions](../bucket/listObjectVersions.md) | Gives the permission to read metadata about all object versions in a bucket.
`s3:ListMultipartUploadParts`   | [listParts](../multipart/listparts.md) | Gives the permission to read a list of uploaded parts of a specific multipart upload.
`s3:PutBucketAcl`               | [bucketPutAcl](../acl/bucketput.md) | Gives the permission to set ACL permissions to buckets.
`s3:PutBucketCORS`              | [upload](../cors/upload.md) | Gives the permission to set a bucket CORS configuration.
`s3:PutBucketVersioning`        | [putBucketVersioning](../bucket/putBucketVersioning.md) | Gives the permission to set the bucket versioning.
`s3:PutBucketWebsite`           | [upload](../hosting/upload.md) | Gives the permission to set a bucket's website configuration.
`s3:PutEncryptionConfiguration` | [putBucketEncryption](../bucket/putbucketencryption.md) | Gives the permission to set a bucket's encryption configuration.
`s3:PutLifecycleConfiguration`  | [upload](../lifecycles/upload.md) | Gives the permission to set a bucket's lifecycle configuration or replace an existing one.
`s3:PutObject`                  | [upload](../object/upload.md) | Gives the permission to add objects to buckets.
`s3:PutObjectAcl`               | [objectPutAcl](../acl/objectput.md) | Gives the permission to set the specified object ACL.
`s3:PutObjectVersionAcl`        | [objectPutAcl](../acl/objectput.md) | Gives the permission to set the specified object version's ACL.

#### Related articles {#related-articles}

* [{#T}](../../../concepts/policy.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
