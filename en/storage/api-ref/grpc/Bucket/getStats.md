---
editable: false
sourcePath: en/_api-ref-grpc/storage/v1/api-ref/grpc/Bucket/getStats.md
---

# Object Storage API, gRPC: BucketService.GetStats

Returns the statistics for the specified bucket.

## gRPC request

**rpc GetStats ([GetBucketStatsRequest](#yandex.cloud.storage.v1.GetBucketStatsRequest)) returns ([BucketStats](#yandex.cloud.storage.v1.BucketStats))**

## GetBucketStatsRequest {#yandex.cloud.storage.v1.GetBucketStatsRequest}

```json
{
  "name": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the bucket to return the statistics for. ||
|#

## BucketStats {#yandex.cloud.storage.v1.BucketStats}

```json
{
  "name": "string",
  "max_size": "google.protobuf.Int64Value",
  "used_size": "int64",
  "storage_class_max_sizes": [
    {
      "storage_class": "string",
      "class_size": "google.protobuf.Int64Value"
    }
  ],
  "storage_class_used_sizes": [
    {
      "storage_class": "string",
      "class_size": "int64"
    }
  ],
  "storage_class_counters": [
    {
      "storage_class": "string",
      "counters": {
        "simple_object_size": "int64",
        "simple_object_count": "int64",
        "objects_parts_size": "int64",
        "objects_parts_count": "int64",
        "multipart_objects_size": "int64",
        "multipart_objects_count": "int64",
        "active_multipart_count": "int64"
      }
    }
  ],
  "default_storage_class": "google.protobuf.StringValue",
  "anonymous_access_flags": {
    "read": "google.protobuf.BoolValue",
    "list": "google.protobuf.BoolValue",
    "config_read": "google.protobuf.BoolValue"
  },
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp"
}
```

A bucket statistics resource.

#|
||Field | Description ||
|| name | **string**

Name of the bucket. ||
|| max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size of the bucket, in bytes. ||
|| used_size | **int64**

Size of used space in the bucket, in bytes. ||
|| storage_class_max_sizes[] | **[OptionalSizeByClass](#yandex.cloud.storage.v1.OptionalSizeByClass)**

Size of available space in the bucket by storage class, in bytes. ||
|| storage_class_used_sizes[] | **[SizeByClass](#yandex.cloud.storage.v1.SizeByClass)**

Size of used space in the bucket by storage class, in bytes. ||
|| storage_class_counters[] | **[CountersByClass](#yandex.cloud.storage.v1.CountersByClass)**

Object-related statistics by storage class and type of upload (simple vs. multipart), in bytes. ||
|| default_storage_class | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage
(`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| anonymous_access_flags | **[AnonymousAccessFlags](#yandex.cloud.storage.v1.AnonymousAccessFlags)**

Flags for configuring public (anonymous) access to the bucket's content and settings.
For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Bucket creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Bucket latest update timestamp. ||
|#

## OptionalSizeByClass {#yandex.cloud.storage.v1.OptionalSizeByClass}

A resource for size of available space in a bucket for a storage class.

#|
||Field | Description ||
|| storage_class | **string**

Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE`
all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| class_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Size of available space in the bucket for the storage class. ||
|#

## SizeByClass {#yandex.cloud.storage.v1.SizeByClass}

A resource for size of used space in a bucket for a storage class.

#|
||Field | Description ||
|| storage_class | **string**

Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE`
all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| class_size | **int64**

Size of used space in the bucket for the storage class. ||
|#

## CountersByClass {#yandex.cloud.storage.v1.CountersByClass}

A resource for object-related statistics for a storage class by type of upload (simple vs. multipart).

#|
||Field | Description ||
|| storage_class | **string**

Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE`
all synonyms), and ice storage (`ice` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| counters | **[Counters](#yandex.cloud.storage.v1.Counters)**

Object-related statistics for the storage class by type of upload. ||
|#

## Counters {#yandex.cloud.storage.v1.Counters}

#|
||Field | Description ||
|| simple_object_size | **int64**

Total size of objects uploaded in single operation, in bytes. ||
|| simple_object_count | **int64**

Number of objects uploaded in single operation. ||
|| objects_parts_size | **int64**

Total size of uploaded parts in incomplete multipart uploads, in bytes. ||
|| objects_parts_count | **int64**

Number of uploaded parts in incomplete multipart uploads. ||
|| multipart_objects_size | **int64**

Total size of objects uploaded in multiple parts, in bytes. ||
|| multipart_objects_count | **int64**

Number of objects uploaded in multiple parts. ||
|| active_multipart_count | **int64**

Number of incomplete multipart uploads. ||
|#

## AnonymousAccessFlags {#yandex.cloud.storage.v1.AnonymousAccessFlags}

#|
||Field | Description ||
|| read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether public (anonymous) access to read objects in the bucket is enabled. ||
|| list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. ||
|| config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors),
[static website hosting](/docs/storage/concepts/hosting), and
[object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. ||
|#