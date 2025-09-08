---
title: Storage classes in {{ objstorage-full-name }}
description: '{{ objstorage-name }} allows you to store objects in storages of various classes depending on how long you want to store your objects and how often you access them. You can choose between a standard, cold, and ice storage.'
---

# Storage class

{{ objstorage-name }} allows you to store objects in storages of various _classes_ depending on how long you want to store your objects and how often you access them. The following classes are available:

* Standard storage
* Cold storage
* Ice storage

_Cold_ classes are designed to store objects that you plan to use less frequently for longer periods of time. The _colder_ your storage is, the less you pay for storing data; however, the costs of reading and writing data increase. For more information about the pricing, see [{#T}](../pricing.md).


{% note info %}

The minimum billable storage duration of an object in ice storage is 12 months. If you delete an object that was stored for less than 12 months, you will be charged the remaining cost after deletion.

{% endnote %}


If you need, you can specify the storage class when uploading each individual object.

## Default storage for a bucket {#default-storage-class}

If you do not specify the storage class when uploading your object, the object will be saved to the bucket default storage.

You can set the default storage when creating a bucket in the management console. Afterwards, you can change this setting for each bucket also in the management console. You cannot set or change the default storage any other way. If you create a bucket not from the management console, the default standard storage is set for this bucket. You cannot set the default storage for all buckets in a folder or cloud at once.

Setting the default storage may be useful when the tool you use does not allow you to set the object storage class.

## Changing an object storage class {#changing-storage-class}

{{ objstorage-name }} does not support direct changes of the storage class for an object. To change the storage class, you can:

- Upload the object to {{ objstorage-name }} again and select the required storage class.
- Set the criteria for changing the storage class to a _colder_ one using [object lifecycles](lifecycles.md). You can configure the change to the `ICE` class using the {{ yandex-cloud }} CLI, AWS CLI, {{ TF }}, and the API. For more information about the lifecycle rule format, see [{#T}](../s3/api-ref/lifecycles/xml-config.md).

## Storage class IDs {#storage-class-identifiers}

If you work with {{ objstorage-name }} via an [Amazon S3-compatible API](../s3/index.md) or the tools described in [{#T}](../tools/index.md), use the following IDs for storage classes:

* Standard storage: `STANDARD`.
* Cold storage: `COLD`, `STANDARD_IA`, or `NEARLINE` (use the last two only for uploading objects to a bucket).
* Ice storage: `ICE` or `GLACIER` (use the latter only for uploading objects to a bucket).


## Use cases {#examples}

* [{#T}](../tutorials/greenplum-yezzey.md)
* [{#T}](../tutorials/log-ingestion.md)
* [{#T}](../tutorials/hystax-backup.md)
* [{#T}](../tutorials/clickhouse-hybrid-storage.md)


#### See also {#see-also}

* [{{ objstorage-full-name }}: How to select a storage class](https://yandex.cloud/ru/blog/object-storage-class)