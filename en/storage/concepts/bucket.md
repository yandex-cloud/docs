---
title: Bucket
description: Bucket is a logical entity that helps store objects. A bucket's name is used as part of the data access URL and is visible to users.  Bucket names are unique, so you can't create two buckets with the same name (even in different folders in different clouds). Keep this in mind if you plan to create buckets automatically via the API.
keywords:
  - what is a bucket
  - bucket
  - bucket storage
  - bucket cloud
---

# Bucket

A logical entity that helps store objects.

## Naming buckets {#naming}

A bucket's name is used as part of the data access URL and is visible to your users. For example, `https://{{ s3-storage-host }}/bucket-name`.

Naming rules:

- Bucket names are unique throughout {{ objstorage-name }}, so you can't create two buckets with the same name (even in different folders in different clouds). Keep this in mind if you plan to create buckets automatically via the API.

- Bucket names are subject to the following restrictions:

   {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

When selecting a bucket name, please keep in mind that names containing dots are used for [hosting static websites](hosting.md). You may encounter a name conflict that prevents you or another user from hosting a website in Object Storage.

## Bucket URL {#bucket-url}

You can use the following URL format to access a bucket:

- `https://{{ s3-storage-host }}/<bucket>?<parameters>`
- `http://<bucket>.{{ s3-storage-host }}?<parameters>`

{% include [storage-dotnet-host](../_includes_service/storage-dotnet-host.md) %}

## Accessing a bucket via HTTPS {#bucket-https}

{{ objstorage-name }} supports secure connections over [HTTPS](https://en.wikipedia.org/wiki/HTTPS). When accessing your buckets, use URLs in the format `https://{{ s3-storage-host }}/<bucket>?<parameters>`.

When you use URLs in the format `http://<bucket>.{{ s3-storage-host }}?<parameters>` HTTPS isn't available.

Read about HTTPS support when hosting websites in {{ objstorage-name }} under [{#T}](hosting.md).

## Bucket settings {#bucket-settings}

You can:

- [Limit the maximum size of a bucket](../operations/buckets/limit-max-volume.md).

    {{ objstorage-name }} doesn't let you upload objects if adding them exceeds the maximum bucket size.

- Set the default [storage class](storage-class.md).

     Objects uploaded to a bucket are by default saved with the storage class specified for that bucket.

- Configure a bucket for [static website hosting](hosting.md).

- Download a [CORS configuration](cors.md) for a bucket.
- Enable [bucket encryption](../operations/buckets/encrypt.md).

    By default, the objects added to the bucket are encrypted with the specified [{{ kms-short-name }} key](../../kms/concepts/key.md).
- Set up [object lifecycles](lifecycles.md).

## Bucket access {#bucket-access}

By default, buckets are created with restricted access, which is defined in the [IAM](../../iam/concepts/index.md) settings. You can use the management console to [enable public access](../operations/buckets/bucket-availability.md):

{% include [storage-public-operations](../_includes_service/storage-public-operations.md) %}

If necessary, you can configure permissions to the buckets and objects they contain using the [ACL](acl.md).

## Guidelines and limitations {#details-of-usage}

- A bucket can't be renamed.

- {{ objstorage-name }} performance doesn't depend on the number of buckets. You can store all your data in one or several buckets.

- Buckets can't be nested.

- You can only delete an empty bucket.

- It may take some time after deleting a bucket before you can create a new bucket with the same name. There is also a risk that another {{ yandex-cloud }} user might create a bucket with the name you've released before you claim it again. Don't delete buckets without a reason.

- When objects are uploaded in quick succession, the maximum specified bucket size can be exceeded.

- After deleting objects from a bucket, their storage capacity is considered occupied for some time.

  {% note info %}

  If you limit the maximum size of a bucket, it may remain unavailable for writes for some time, even if you free up enough space for new objects.

  {% endnote %}