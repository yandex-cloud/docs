---
title: Bucket
description: A bucket is an {{ objstorage-name }} storage unit allocated for user data. A bucket name is used as part of a URL to access data. Bucket names are unique across {{ yandex-cloud }}, i.e., you cannot create two buckets with identical names even if the folders they reside in belong to different clouds. You should keep this in mind if you are going to create buckets automatically through the API.
keywords:
  - what is a bucket
  - bucket
  - data storage bucket
  - cloud bucket
---

# Bucket in {{ objstorage-name }}

A _bucket_ is an {{ objstorage-name }} storage unit allocated for user data. Each {{ yandex-cloud }} bucket has a [unique name](#naming) used in requests to {{ objstorage-name }}.

Buckets store data as [objects](./object.md). To organize data, you can create multiple buckets or use [folders](./object.md#folder) and prefixes within a single bucket.

You can also use buckets to [host static websites](./hosting.md).

For more information on getting started with buckets, see [{#T}](../quickstart.md).

You can [create a bucket](../operations/buckets/create.md) via the [management console]({{ link-console-main }}), [YC CLI](../../cli/quickstart.md), [{{ TF }}]({{ tf-provider-resources-link }}/storage_bucket), [API](../../api-design-guide/concepts/general.md), or using some popular [tools](../tools/index.md) designed to work with the Amazon S3 HTTP API.

## Naming buckets {#naming}

A bucket name is used as part of the data access URL and is visible to your users, e.g., `https://{{ s3-storage-host }}/bucket-name`.

The naming requirements are as follows:

- Bucket names are unique throughout {{ objstorage-name }}, which means you cannot create two buckets with the same name, even in different folders belonging to different clouds. You should keep this in mind if you are going to create buckets automatically through the API.
- Bucket names are subject to the following restrictions:

   {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

When choosing a name for your bucket, keep in mind that names containing dots are used for [hosting static websites](hosting.md). You may encounter a name conflict that will prevent you or another user from hosting a website in Object Storage.

## Bucket URL {#bucket-url}

You can use the following URL formats to access a bucket:


* `http(s)://{{ s3-storage-host }}/<bucket_name>?<parameters>`
* `http(s)://<bucket_name>.{{ s3-storage-host }}?<parameters>`


{% include [storage-dotnet-host](../_includes_service/storage-dotnet-host.md) %}


## Accessing a bucket via HTTPS {#bucket-https}

{{ objstorage-name }} supports secure connections over HTTPS.

{% include [bucket-https](../../_includes/storage/bucket-https.md) %}

For more information on HTTPS support when hosting websites in {{ objstorage-name }}, see [{#T}](./hosting.md).


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


## Accessing buckets from {{ vpc-full-name }} cloud networks {#access-via-vpc}

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}

{% include [intro-access-via-vpc](../../_includes/storage/intro-access-via-vpc.md) %}

For more information on configuring access, see [{#T}](../operations/buckets/access-via-vpc.md).


## Public access to buckets {#bucket-access}

{% include [public-access](../../_includes/storage/security/public-access.md) %}

## Statistics {#stats}

{{ objstorage-name }} automatically delivers bucket performance metrics to [{{ monitoring-full-name }}](../../monitoring/).

Performance statistics are available from the [bucket page](../operations/buckets/get-stats.md#storage-ui) or the [{{ monitoring-name }} interface](../operations/buckets/get-stats.md#monitoring).

For a list of metrics delivered to {{ monitoring-name }}, see the [reference](../metrics.md).

You can also access aggregate bucket statistics [through the {{ yandex-cloud }} CLI](../operations/buckets/get-info.md#get-statistics).

## Recommendations and limitations {#details-of-usage}

- You cannot rename buckets.
- The number of buckets does not affect the performance of {{ objstorage-name }}. How many buckets you use to store your data is up to you.
- Buckets cannot be nested.
- In the management console, information about the number of objects in a bucket and the used space is updated with a few minutes' delay.
- You can delete only an empty bucket.
- After deleting a bucket, you may not be able to immediately create a new bucket with the same name. There is also a risk that another {{ yandex-cloud }} user might create a bucket with the name you released before you claim it again. Do not delete buckets without a reason.
- Uploading objects quickly one by one may lead to exceeding the specified maximum bucket size.
- After deleting objects from a bucket, their storage capacity is retained for some time.

  {% note info %}

  If you limit the maximum size of a bucket, it may remain temporarily unavailable for writes even after you free up enough space for new objects.

  {% endnote %}


### See also {#see-also}

* [{#T}](../security/overview.md)
