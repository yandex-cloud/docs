---
title: Storage classes in {{ objstorage-full-name }}
description: '{{ objstorage-name }} allows you to store objects in storages of various classes depending on how long you want to store your objects and how often you access them. You can choose between a standard, cold, and ice storage.'
---

# Storage class

{{ objstorage-name }} allows you to store objects in storages of various _classes_ depending on how long you want to store your objects and how often you access them. The following options are available:

#|
|| **Storage class** {.cell-align-center} | **Access to data** {.cell-align-center} | **Cost** {.cell-align-center} | > ||
|| ^ | ^ | **Requests** {.cell-align-center} | **Data storage** {.cell-align-center} ||
|| Standard
(`STANDARD`)^1^ | Frequent | ![image](../../_assets/console-icons/sack.svg) | ![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg) ||
|| Cold
(`COLD`) | Rare, approximately once a month | ![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg) | ![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg) ||
|| Ice
(`ICE`) | Very rare, approximately once a year or less often | ![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg) | ![image](../../_assets/console-icons/sack.svg)^2^ ||
|#


^1^ For `STANDARD`, the [free tier](../../billing/concepts/serverless-free-tier.md#objstorage) is available.

^2^ Provided data is stored for no less than 12 months.


_Cold_ classes are designed to store objects that you plan to use less frequently for longer periods of time. The _colder_ your storage is, the less you pay for storing data; however, the costs of reading and writing data increase. For more information, see [examples of cost comparison in the Pricing policy section](../pricing.md#comparison-examples).

You can select a storage class individually for every object when uploading them.

## Features of storage classes {#features}

All storage classes have the [same SLA]({{ link-yandex }}/legal/cloud_sla_storage/ru/) and protect data from loss even in the event of a full failure in one of the three [availability zones](../../overview/concepts/geo-scope.md).

The `STANDARD` and `COLD` storages have identical technical properties and data backup schemes, where ×3 replication is used to create one backup in each of the availability zones.


The performance of `ICE` storages may slightly differ from that of the `STANDARD` and `COLD` classes when working with object data. In other respects, you can use `ICE` storages in the same way as any other storage class. This is the advantage of `ICE` in {{ objstorage-name }} over other solutions, since you can access data directly for read and write operations. In other solutions purpose-built for data archiving, accessing data may take from dozens of minutes to several days. For example, [AWS Glacier](https://en.wikipedia.org/wiki/Amazon_S3_Glacier) does not support direct access to data. You need to transfer your data to a hotter storage before you can read it, which takes considerable time. The `ICE` storage class enables you to operate a less complex infrastructure and reduce your costs.

{% note info %}

The minimum billable storage duration of an object in ice storage is 12 months. If you delete an object that was stored for less than 12 months, you will be charged the remaining [storage cost](../pricing.md#prices) after deletion.

{% endnote %}


## Default storage for a bucket {#default-storage-class}

If you do not specify the storage class when uploading your object, the object will be saved to the bucket default storage.

You can set the default storage when creating a bucket in the management console. Afterwards, you can change this setting for each bucket also in the management console. You cannot set or change the default storage any other way. If you create a bucket not from the management console, the default standard storage is set for this bucket. You cannot set the default storage for all buckets in a folder or cloud at once.

Setting the default storage may be useful when the tool you use does not allow you to set the object storage class.

## Changing an object storage class {#changing-storage-class}

To change the storage class, you can:

* Upload the object to {{ objstorage-name }} again and select the required storage class.
* Move or copy an object specifying a new storage class.

    
    {% note info %}

    If you move an object or reupload it with the same key, the original object will be deleted. If you delete an object that was stored for less than 12 months, you will be charged the remaining [storage cost](../pricing.md#prices) after deletion. If you copy an object without deletion, these charges do not apply.

    {% endnote %}


* Set the criteria for changing the storage class to a _colder_ one using [object lifecycles](lifecycles.md). For more information about the lifecycle rule format, see [{#T}](../s3/api-ref/lifecycles/xml-config.md).

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



