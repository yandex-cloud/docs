---
title: Storage classes in {{ objstorage-full-name }}
description: '{{ objstorage-name }} allows you to store objects in storages of various classes depending on how long you want to store your objects and how often you access them. You can choose among the standard, cold, ice, and intelligent-tiering storage.'
---

# Storage class

{{ objstorage-name }} allows you to store objects in storages of various _classes_ depending on how long you want to store your objects and how often you access them. You can choose among the following options:

#|
|| **Storage class** {align="center"} | **Access to data** {align="center"} | **Cost** {align="center"} | > ||
|| ^ | ^ | **Requests** {align="center"} | **Data storage** {align="center"} ||
|| Standard
(`STANDARD`)^1^ | Frequent | ![image](../../_assets/console-icons/sack.svg) | ![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg) ||
|| Cold
(`COLD`) | Rare, approximately once a month | ![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg) | ![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg) ||
|| Ice
(`ICE`) | Very rare, approximately once a year or less often | ![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg)![image](../../_assets/console-icons/sack.svg) | ![image](../../_assets/console-icons/sack.svg)^2^ ||
|| Intelligent
(`INTELLIGENT_TIERING`)^3^ | Hard to predict or changing | Optimized automatically | > ||
|#


^1^ For `STANDARD`, the [free tier](../../billing/concepts/serverless-free-tier.md#objstorage) is available.

^2^ Provided data is stored for no less than 12 months.



^3^ The cost depends on the object’s current access tier.


{% include [storage-class-cold-desc](../../_includes/storage/storage-class-cold-desc.md) %}

For more information, see [these examples of cost comparison in the Pricing policy section](../pricing.md#comparison-examples).

You can select a storage class individually for every object when uploading them.

## Features of storage classes {#features}

All storage classes have the [same SLA]({{ link-yandex }}/legal/cloud_sla_storage/ru/) and protect data from loss even in the event of a full failure in one of the three [availability zones](../../overview/concepts/geo-scope.md).


### Standard, cold, ice storage {#features-all}


`STANDARD` and `COLD` storage share identical technical specifications and data redundancy policies: x3 replication with one copy in each availability zone.

The performance of `ICE` storage may slightly differ from that of the `STANDARD` and `COLD` classes when working with object data. In other respects, you can use `ICE` storage in the same way as any other storage class. This is the advantage of `ICE` in {{ objstorage-name }} over other solutions, since you can access data directly for read and write operations. In other solutions purpose-built for data archiving, accessing data may take from dozens of minutes to several days. For example, [AWS Glacier](https://en.wikipedia.org/wiki/Amazon_S3_Glacier) does not support direct access to data. Instead, you need to move it to a more active storage class before you can read it, which takes considerable time. The `ICE` storage class enables you to operate a less complex infrastructure and reduce your costs.


{% note info %}

The minimum billable storage duration of an object in ice storage is 12 months. If you delete an object that had been in storage for less than 12 months, the balance of the [storage charge](../pricing.md#prices) will be debited after the deletion.

{% endnote %}



### Intelligent-tiering storage {#features-intelligent-tiering}

The `INTELLIGENT_TIERING` storage automatically optimizes costs by moving objects across access tiers based on access frequency. This allows you to save on storage if your data access frequency constantly varies or is hard to predict.

Unlike the [lifecycles](lifecycles.md), this storage does not require manual configuration of rules and filters: you can set a default storage class for the entire bucket to automatically optimize storage properties for each object inside it. At the same time, intelligent-tiering storage not only tiers down objects, but also tiers them back up when access frequency increases.

The intelligent-tiering storage comprises `FREQUENT`, `INFREQUENT`, and `ARCHIVE` access tiers. The objects are moved across them based on these rules:

* New objects are uploaded to the `FREQUENT` tier.
* `FREQUENT`-tier objects accessed less than 100 times per day for 30 days get automatically moved to `INFREQUENT`.
* `INFREQUENT`-tier objects accessed less than 100 times per day for 90 days gets automatically moved to `ARCHIVE`.
* If an object is accessed 100 times per day or more, it gets automatically restored to `FREQUENT`.

Accessing an object means operations involving copying or downloading, i.e., [CopyObject](../s3/api-ref/object/copy.md), [GetObject](../s3/api-ref/object/get.md), RestoreObject, and [UploadPartCopy](../s3/api-ref/multipart/copypart.md). The interface you use to perform the operation is irrelevant. For example, [downloading an object](../operations/objects/download.md) via the management console and [copying](../operations/objects/copy.md) it using the {{ yandex-cloud }} CLI will both count as access.

The operations of uploading new object versions or partial update, i.e., [PutObject](../s3/api-ref/object/upload.md) and [PatchObject](../s3/api-ref/object/patch.md), will have the same result as uploading a new object to the `FREQUENT` tier. Other operations do not affect moving the object across access tiers.

The cost of storage and operations with an object depends on what tier the object is currently on. You can learn the object's current tier by [downloading its metadata](../operations/buckets/manage-s3-inventory.md).

There are separate charges for the total number of objects in the intelligent-tiering storage and the use of lifecycles to move objects to the intelligent-tiering storage. For more information, see [Pricing policy](../pricing.md).



## Default storage for a bucket {#default-storage-class}

If you do not specify the storage class when uploading your object, the object will be saved to the bucket’s default storage.

You can set the default storage class when creating a bucket in the management console. Afterwards, you also can change this setting for each bucket in the management console. You cannot set or change the default storage any other way. If you create a bucket not from the management console, the default standard storage is set for this bucket. You cannot set the default storage for all buckets in a folder or cloud at once.

Setting the default storage may be useful when the tool you use does not allow you to set the object storage class.

## Changing an object storage class {#changing-storage-class}


{% include [changing-storage-class](../../_includes/storage/changing-storage-class.md) %}


To change the storage class, you can:

* Upload the object to {{ objstorage-name }} again and select the required storage class.
* Move or copy an object specifying a new storage class.

    
    {% note info %}

    If you move an object or re-upload it with the same key, the original object will be deleted. After you delete an object that had been stored in `ICE` for less than 12 months, the balance of the [storage charge](../pricing.md#prices) will be debited after the deletion. If you copy an object without deletion, these charges will not apply.

    {% endnote %}


* Configure [lifecycle](lifecycles.md) rules to tier down the storage class. For more information about the lifecycle rules format, see [{#T}](../s3/api-ref/lifecycles/xml-config.md).

## Storage class IDs {#storage-class-identifiers}

If you work with {{ objstorage-name }} via an [Amazon S3-compatible API](../s3/index.md) or the tools described in [{#T}](../tools/index.md), use the following IDs for storage classes:

* Standard storage: `STANDARD`.
* Cold storage: `COLD`, `STANDARD_IA`, or `NEARLINE` (use the last two only for uploading objects to a bucket).
* Ice storage: `ICE` or `GLACIER` (use the latter only for uploading objects to a bucket).
* Intelligent-tiering storage: `INTELLIGENT_TIERING`.


## Use cases {#examples}

* [{#T}](../tutorials/greenplum-yezzey.md)
* [{#T}](../tutorials/log-ingestion.md)
* [{#T}](../tutorials/hystax-backup.md)
* [{#T}](../tutorials/clickhouse-hybrid-storage.md)



