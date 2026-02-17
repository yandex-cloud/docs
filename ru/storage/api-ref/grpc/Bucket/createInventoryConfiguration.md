---
editable: false
---

# Object Storage API, gRPC: BucketService.CreateInventoryConfiguration

Create/Update an inventory configuration with the corresponding ID

## gRPC request

**rpc CreateInventoryConfiguration ([CreateBucketInventoryConfigurationRequest](#yandex.cloud.storage.v1.CreateBucketInventoryConfigurationRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateBucketInventoryConfigurationRequest {#yandex.cloud.storage.v1.CreateBucketInventoryConfigurationRequest}

```json
{
  "bucket": "string",
  "id": "string",
  "configuration": {
    "id": "string",
    "destination": {
      "bucket_destination": {
        "bucket": "string",
        "format": "Format",
        "prefix": "google.protobuf.StringValue"
      }
    },
    "included_object_versions": "IncludedObjectVersions",
    "is_enabled": "bool",
    "schedule": {
      "frequency": "Frequency"
    },
    "filter": {
      "prefix": "string"
    },
    "optional_fields": [
      "OptionalField"
    ]
  }
}
```

#|
||Field | Description ||
|| bucket | **string**

Required field. Name of the bucket to update the inventory configuration for. ||
|| id | **string**

Required field. ID of the inventory configuration to set. ||
|| configuration | **[InventoryConfiguration](#yandex.cloud.storage.v1.InventoryConfiguration)**

Required field. Inventory configuration. ||
|#

## InventoryConfiguration {#yandex.cloud.storage.v1.InventoryConfiguration}

#|
||Field | Description ||
|| id | **string**

Required field. The ID used to identify the inventory configuration. ||
|| destination | **[InventoryDestination](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryDestination)**

Required field. Contains information about where to publish the inventory results. ||
|| included_object_versions | enum **IncludedObjectVersions**

Required field. Object versions to include in the inventory list.

- `ALL`: Include all versions.
- `CURRENT`: Include only the current version. ||
|| is_enabled | **bool**

Specifies whether the inventory is enabled. ||
|| schedule | **[InventorySchedule](#yandex.cloud.storage.v1.InventoryConfiguration.InventorySchedule)**

Required field. Specifies the schedule for generating inventory results. ||
|| filter | **[InventoryFilter](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryFilter)**

Specifies the filter for objects to include in the inventory. ||
|| optional_fields[] | enum **OptionalField**

Contains the optional fields that are included in the inventory results.

- `SIZE`: The object size in bytes.
- `LAST_MODIFIED_DATE`: The object creation date or the last modified date, whichever is the latest.
- `STORAGE_CLASS`: The storage class that's used for storing the object.
- `ETAG`: The entity tag (ETag) is a hash of the object.
- `IS_MULTIPART_UPLOADED`: Specifies that the object was uploaded as a multipart upload.
- `ENCRYPTION_STATUS`: The server-side encryption type that's used to encrypt the object.
- `OBJECT_LOCK_RETAIN_UNTIL_DATE`: The date until which the object is locked.
- `OBJECT_LOCK_MODE`: The level of protection applied to the object, either Governance or Compliance.
- `OBJECT_LOCK_LEGAL_HOLD_STATUS`: The legal hold status of the locked object.
- `CHECKSUM_ALGORITHM`: Indicates the algorithm that is used to create the checksum for the object.
- `OBJECT_ACCESS_CONTROL_LIST`: An access control list (ACL) for each object.
- `OBJECT_OWNER`: The owner of the object. ||
|#

## InventoryDestination {#yandex.cloud.storage.v1.InventoryConfiguration.InventoryDestination}

#|
||Field | Description ||
|| bucket_destination | **[InventoryBucketDestination](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryBucketDestination)**

Required field. Destination bucket settings ||
|#

## InventoryBucketDestination {#yandex.cloud.storage.v1.InventoryConfiguration.InventoryBucketDestination}

#|
||Field | Description ||
|| bucket | **string**

Required field. Bucket where inventory results will be published. ||
|| format | enum **Format**

Required field. Specifies the output format of the inventory results.

- `CSV`: CSV format. ||
|| prefix | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

The prefix that is prepended to all inventory results. ||
|#

## InventorySchedule {#yandex.cloud.storage.v1.InventoryConfiguration.InventorySchedule}

#|
||Field | Description ||
|| frequency | enum **Frequency**

Required field. Specifies how frequently inventory results are produced.

- `DAILY`: Daily generation.
- `WEEKLY`: Weekly generation. ||
|#

## InventoryFilter {#yandex.cloud.storage.v1.InventoryConfiguration.InventoryFilter}

#|
||Field | Description ||
|| prefix | **string**

Required field. The prefix that an object must have to be included in the inventory results. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateBucketInventoryConfigurationMetadata](#yandex.cloud.storage.v1.CreateBucketInventoryConfigurationMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateBucketInventoryConfigurationMetadata {#yandex.cloud.storage.v1.CreateBucketInventoryConfigurationMetadata}

#|
||Field | Description ||
|| name | **string**

Bucket name for which inventory configuration will be set ||
|#