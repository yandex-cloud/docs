---
title: Object metadata export (S3 Inventory)
description: In {{ objstorage-name }}, you can export metadata of bucket objects for further analysis and cataloging. Data is exported to a different bucket in CSV format and includes object size, creation date, MD5 checksum, storage class, versioning data, object ACLs, and more.
---

# Object metadata export (S3 Inventory)

In {{ objstorage-name }}, you can export [metadata](./object.md#metadata) of bucket objects (S3 Inventory) for further analysis and cataloging. Data is exported to a different bucket in [CSV](https://{{ lang }}.wikipedia.org/wiki/CSV) format and includes object size, creation date, MD5 checksum, [storage class](./storage-class.md), [versioning](./versioning.md) data, [object ACLs](./acl.md), and more.

{% include [s3-inventory-pricing](../../_includes/storage/s3-inventory-pricing.md) %}

Export of all objects’ metadata is useful for the following tasks:

* Data discovery and analysis.
* Deduplication of bucket files.
* Simplifying synchronization with other storage systems and services.
* Improving observability.
* Implementing backup and versioned data recovery scenarios.

## How export works {#how-work}

The S3 Inventory export is a list of objects with metadata, generated based on the [eventual consistency](https://en.wikipedia.org/wiki/Eventual_consistency) model. This list is not an atomic or consistent snapshot of object metadata.

There is a reason for implementing such an approach. To ensure horizontal scalability, fault tolerance, and availability, {{ objstorage-name }} partitions data into separate segments, or _shards_. Thus, to avoid impacting bucket performance, all shards are scanned asynchronously during export generation.

If objects are written to a shard that has already been scanned, the export will not include data on those objects. Similarly, object deletions may not be immediately reflected. This is a standard behavior for `LIST` operations on buckets.

{% note tip %}

Before performing any action with an object featured in an export, check its current state using the `HeadObject` method as described in [this guide](../operations/objects/object-meta.md#get-object-meta).
 
{% endnote %}

## Source and target buckets {#source-destination-buckets}

Metadata is exported from the _source bucket_. This bucket contains the export configuration and objects whose metadata will be exported. You can export metadata for all objects in the source bucket or filter objects by folder (prefix).

The exported metadata is written to the _target bucket_. You can specify an export prefix in the configuration to organize exported files within the target bucket.

### Prerequisites {#requirements}

* Source and target can be the same bucket.
* Source and target buckets must reside in the same [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* [Encryption](../operations/buckets/encrypt.md) must be disabled on the target bucket.

{% note info %}

To write reports to a target bucket with an [access policy](./policy.md) configured, [add](../operations/buckets/policy.md#apply-policy) a rule to this policy to allow any account to perform the `PutObject` action, and specify `<export_prefix>/` as the resource.

{% endnote %}

## Export configuration and metadata types {#config}

You can [create an export configuration](../operations/buckets/manage-s3-inventory.md#create-inventory) using the {{ yandex-cloud }} CLI or {{ yandex-cloud }} API. The configuration includes the following parameters:

* Configuration name.
* Target bucket and export prefix.
* Report frequency (daily or weekly).
* Included [versions](./versioning.md) (current versions only or all object versions).
* Optional prefix to filter objects included in the report.
* Configuration status: enabled or disabled.
* List of optional object metadata fields.

Each export report contains a list of source bucket objects and their metadata. The following fields are included by default:

* `BUCKET_NAME`: Source bucket name.
* `KEY`: Object [key](./object.md#key).

If exporting metadata of all object versions, the report will also indicate:

* `VERSION_ID`: Version ID.
* `IS_LATEST`: Latest version flag.
* `DELETE_MARKER`: Delete marker flag.

Optionally, you add the following metadata fields to the configuration:

* `SIZE`: Size in bytes, excluding incomplete parts of [multipart uploads](./multipart.md), object metadata, and delete markers.
* `LAST_MODIFIED_DATE`: Creation or last modification date.
* `ETAG`: Hash.
* `STORAGE_CLASS`: [Storage class](./storage-class.md).
* `IS_MULTIPART_UPLOADED`: Multipart upload indicator.
* `ENCRYPTION_STATUS`: [Encryption](./encryption.md) status.
* `OBJECT_LOCK_RETAIN_UNTIL_DATE`: [Version lock](./object-lock.md) expiration date.
* `OBJECT_LOCK_MODE`: Version lock type.
* `OBJECT_LOCK_LEGAL_HOLD_STATUS`: Version legal hold status.
* `CHECKSUM_ALGORITHM`: Algorithm used to compute the checksum.
* `OBJECT_ACCESS_CONTROL_LIST`: [ACL](./acl.md), Base64-encoded.
* `OBJECT_OWNER`: Owner account ID.

For an up-to-date list of available parameters, refer to the [API Reference](../api-ref/Bucket/createInventoryConfiguration.md).

## Export results {#results}

S3 Inventory generates an export manifest, a manifest checksum file, and a report.

### Manifest {#manifest}

The report manifest consists of two files:

* `<export_prefix>/<source_bucket_name>/<configuration_ID>/<export_date>/manifest.json`: Manifest file.
* `<export_prefix>/<source_bucket_name>/<configuration_ID>/<export_date>/manifest.checksum`: [MD5](https://{{ lang }}.wikipedia.org/wiki/MD5) checksum of the manifest.

  Where:
  
  * `<export_prefix>`: Prefix used for the export.
  * `<source_bucket_name>`: Name of the bucket to export metadata from.
  * `<configuration_ID>`: Export configuration ID.
  * `<export_date>`: Export date in `YYYY-MM-DDThh:mmZ` format.

The manifest contains the following report information:

* Source bucket.
* Target bucket.
* S3 Inventory version.
* Bucket scan start time.
* File format.
* Report schema, i.e., fields included in the report.
* List of files in the report.

Manifest example:

```json
{
    "sourceBucket": "source-bucket",
    "destinationBucket": "example-inventory-destination-bucket",
    "version": "2016-11-30",
    "creationTimestamp" : "1514944800000",
    "fileFormat": "CSV",
    "fileSchema": "Bucket, Key, VersionId, IsLatest, IsDeleteMarker, Size",
    "files": [
        {
            "key": "prefix/source-bucket/config-name/data/3a6d560f-d5d5-434c-a896-15b13f52ac09.csv",
            "size": 2147483647,
            "MD5checksum": "f11166069f1990abeb9c97ace9cdfabc"
        }
    ]
}
```

### Report {#report}

The report is a CSV file containing metadata of all source bucket objects. For large buckets, the report may be split into multiple files.

{% note info %}

Objects in the report may not be sorted in any particular order.

{% endnote %}

The report is stored at `<export_prefix>/<source_bucket_name>/<configuration_ID>/data/<report_name>.csv`, where:

* `<export_prefix>`: Prefix used for the export.
* `<source_bucket_name>`: Name of the bucket to export metadata from.
* `<configuration_ID>`: Export configuration ID.
* `<report_name>`: Report [UUID](https://{{ lang }}.wikipedia.org/wiki/UUID) from the manifest.

Report example:

```text
source-bucket-name,some-file-key-1,16777216,2024-11-26 08:22:15.12345+00,STANDARD,75662d2b5026e477f88a1b385fccfad7,f,SSE-S3,,,,MD5,,ajegtlf2q28a********
source-bucket-name,some-file-key-2,647168,2025-05-25 22:05:28.12345+00,COLD,7f9429f312poga209cd412aae2020ae,f,SSE-S3,,,,MD5,,ajegtlf2q28a********
```

#### See also {#see-also}

* [{#T}](../operations/buckets/manage-s3-inventory.md)
* [{#T}](../operations/objects/download.md)
* [{#T}](./server-logs.md)