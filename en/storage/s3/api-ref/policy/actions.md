---
title: Actions upon triggering the {{ objstorage-full-name }} bucket access policy you can set in the S3 API
description: In this article, you will learn what actions upon triggering the {{ objstorage-full-name }} bucket access policy can be set in the S3 API.
---

# Actions

Action | Description
----- | -----
`s3:AbortMultipartUpload` | Gives the permission to abort a multipart upload.
`s3:DeleteBucketWebsite` | Gives the permission to delete the configuration of a bucket’s website.
[s3:DeleteObject](../object/delete.md) | Gives the permission to delete the null version and adds a delete marker to the latest object version.
`s3:DeleteObjectVersion` | Gives the permission to delete the specified object version.
`s3:GetBucketAcl` | Gives the permission to read a bucket ACL.
`s3:GetBucketCORS` | Gives the permission to read information about the CORS configuration.
`s3:GetBucketLocation` | Gives the permission to read information about a bucket's location.
`s3:GetBucketVersioning` | Gives the permission to read information about the bucket versioning.
`s3:GetBucketWebsite` | Gives the permission to read a bucket's website configuration.
`s3:GetEncryptionConfiguration` | Gives the permission to read a bucket's default encryption configuration.
`s3:GetLifecycleConfiguration` | Gives the permission to read a bucket's lifecycle configuration.
[s3:GetObject](../object/get.md) | Gives the permission to read objects.
`s3:GetObjectAcl` | Gives the permission to read an object ACL.
`s3:GetObjectVersion` | Gives the permission to read a specific object version.
`s3:GetObjectVersionAcl` | Gives the permission to read a specific object version's ACL.
`s3:ListBucket` | Gives the permission to read a list of some or all objects in a bucket.
`s3:ListBucketMultipartUploads` | Gives the permission to read a list of incomplete multipart uploads.
`s3:ListBucketVersions` | Gives the permission to read metadata about all object versions in a bucket.
`s3:ListMultipartUploadParts` | Gives the permission to read a list of uploaded parts of a specific multipart upload.
`s3:PutBucketAcl` | Gives the permission to set ACL permissions to buckets.
`s3:PutBucketCORS` | Gives the permission to set a bucket CORS configuration.
`s3:PutBucketVersioning` | Gives the permission to set the bucket versioning.
`s3:PutBucketWebsite` | Gives the permission to set a bucket's website configuration.
`s3:PutEncryptionConfiguration` | Gives the permission to set a bucket's encryption configuration.
`s3:PutLifecycleConfiguration` | Gives the permission to set a bucket's lifecycle configuration or replace an existing one.
[s3:PutObject](../object/upload.md) | Gives the permission to add objects to buckets.
`s3:PutObjectAcl` | Gives the permission to set the specified object ACL.
`s3:PutObjectVersionAcl` | Gives the permission to set the specified object version's ACL.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}