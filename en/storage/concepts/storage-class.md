---
title: Storage class in {{ objstorage-full-name }}
description: '{{ objstorage-name }} allows you to store objects in storages of various classes depending on your requirements for storage duration and frequency of operations with objects. The service offers standard, cold, and ice storage.'
---

# Storage class

{{ objstorage-name }} allows you to store objects in storages of various _classes_ depending on your requirements for storage duration and frequency of object operations. The classes to choose from are:

* Standard storage
* Cold storage
* Ice storage

_Cold_ classes are designed to store objects that you plan to use less frequently for longer periods of time. The _colder_ your storage is, the cheaper it is to store data but the more expensive it is to read from and write to it. For more information about the pricing, see [{#T}](../pricing.md).


{% note info %}

The minimum billable storage time of an object in ice storage is 12 months. If you delete an object that was stored for less than 12 months, you will be charged the remaining cost after deletion.

{% endnote %}


If you need, you can specify your storage class when uploading each individual object.

## Default storage for a bucket {#default-storage-class}

If you do not specify the storage class when uploading your object, the object will be saved to the bucket's default storage.

You can set the default storage when creating a bucket in the management console. Afterwards, you can change this setting for each bucket, also in the management console. You cannot set or change the default storage with other tools. The buckets created outside of the management console use the default standard storage. You cannot set the default storage for all buckets in a folder or cloud at once.

Setting the default storage may be handy when the tool you use does not allow you to set the object storage class.

## Changing an object storage class {#changing-storage-class}

{{ objstorage-name }} does not support changing the storage class of an object directly. To change the storage class, you can:

- Upload the object to {{ objstorage-name }} again and select the required storage class.
- Set the criteria for changing the storage class to a _colder_ one using [object lifecycles](lifecycles.md). You can set the change of the storage class to `ICE` using YC CLI, AWS CLI, {{ TF }}, and the API. For more information about the lifecycle rule format, see [{#T}](../s3/api-ref/lifecycles/xml-config.md).

## Storage class IDs {#storage-class-identifiers}

When working with {{ objstorage-name }} using an [Amazon S3-compatible API](../s3/index.md) or the tools described in the [{#T}](../tools/index.md) section, use the following IDs for storage classes:

* Standard storage: `STANDARD`.
* Cold storage: `COLD`, `STANDARD_IA`, or `NEARLINE` (use the last two only for uploading objects to a bucket).
* Ice storage: `ICE` or `GLACIER` (use the latter only for uploading objects to a bucket).