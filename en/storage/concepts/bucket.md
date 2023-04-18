---
title: "Bucket"
description: "A bucket is a logical entity for storing objects. A bucket name is used as part of a URL to access data. Bucket names are unique throughout Object Storage, which means you cannot create two buckets with the same name, even in different folders belonging to different clouds. You should keep this in mind if you are going to create buckets automatically through the API."
keywords:
  - what is a bucket
  - bucket
  - data storage bucket
  - cloud bucket
---

# Bucket in {{ objstorage-name }}

A bucket is a logical entity that handles storing objects.

## Naming buckets {#naming}

A bucket name is used as part of the data access URL and is visible to your users. For example, it may look like `https://{{ s3-storage-host }}/bucket-name`.

The naming requirements are as follows:

- Bucket names are unique throughout {{ objstorage-name }}, which means you cannot create two buckets with the same name, even in different folders belonging to different clouds. You should keep this in mind if you are going to create buckets automatically through the API.
- Bucket names are subject to the following restrictions:

   {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

When choosing a name for your bucket, keep in mind that names containing dots are used for [hosting static websites](hosting.md). You may encounter a name conflict that will prevent you or another user from hosting a website in Object Storage.

## Bucket URL {#bucket-url}

You can use the following URL formats to access a bucket:

- `https://{{ s3-storage-host }}/<bucket>?<parameters>`
- `http://<bucket>.{{ s3-storage-host }}?<parameters>`

{% include [storage-dotnet-host](../_includes_service/storage-dotnet-host.md) %}



## Accessing a bucket via HTTPS {#bucket-https}

{{ objstorage-name }} supports secure connections over [HTTPS](https://en.wikipedia.org/wiki/HTTPS). When accessing your buckets, use URLs in the `https://{{ s3-storage-host }}/<bucket>?<parameters>` format.

{% include [bucket-https](../../_includes/storage/bucket-https.md) %}



## Bucket settings {#bucket-settings}

You can:

- [Limit the maximum bucket size](../operations/buckets/limit-max-volume.md).

   {{ objstorage-name }} will not allow you to upload an object if doing so leads to exceeding the maximum bucket size.

- Set the default [storage class](storage-class.md).

   By default, objects uploaded to a bucket are saved with the storage class specified for that bucket.

- Configure a bucket for [static website hosting](hosting.md).
- Upload a [CORS configuration](cors.md) for a bucket.
- Enable [bucket encryption](../operations/buckets/encrypt.md).

   By default, objects added to the bucket are encrypted with the specified [{{ kms-short-name }} key](../../kms/concepts/key.md).


- Set up [object lifecycles](lifecycles.md).

## Bucket access {#bucket-access}

By default, buckets are created with restricted access, as specified in the [IAM](../../iam/concepts/index.md) settings. You can use the management console to [enable public access](../operations/buckets/bucket-availability.md):

{% include [storage-public-operations](../_includes_service/storage-public-operations.md) %}

If required, you can configure permissions to the buckets and objects they contain using [ACLs](acl.md).

## Recommendations and limitations {#details-of-usage}

- You cannot rename buckets.
- The number of buckets does not affect the performance of {{ objstorage-name }}. How many buckets you use to store your data is up to you.
- Buckets cannot be nested.
- In the management console, information about the number of objects in a bucket and the used space is updated with a few minutes' delay.
- You can only delete an empty bucket.
- It may take some time after deleting a bucket before you can create a new bucket with the same name. There is also a risk that another {{ yandex-cloud }} user might create a bucket with the name you released before you claim it again. Do not delete buckets without a reason.

- Uploading objects quickly one by one may lead to exceeding the specified maximum bucket size.
- After deleting objects from a bucket, their storage capacity is retained for some time.

   {% note info %}

   If you limit the maximum size of a bucket, it may remain temporarily unavailable for writes even after you free up enough space for new objects.

   {% endnote %}
