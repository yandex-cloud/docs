---
editable: false
---

# Object Storage API, gRPC: BucketService.ListInventoryConfigurations

Listing inventory configurations

## gRPC request

**rpc ListInventoryConfigurations ([ListBucketInventoryConfigurationsRequest](#yandex.cloud.storage.v1.ListBucketInventoryConfigurationsRequest)) returns ([ListBucketInventoryConfigurationsResponse](#yandex.cloud.storage.v1.ListBucketInventoryConfigurationsResponse))**

## ListBucketInventoryConfigurationsRequest {#yandex.cloud.storage.v1.ListBucketInventoryConfigurationsRequest}

```json
{
  "bucket": "string",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| bucket | **string**

Required field. Name of the bucket to list the inventory configurations for. ||
|| page_token | **string**

Continuation token ||
|#

## ListBucketInventoryConfigurationsResponse {#yandex.cloud.storage.v1.ListBucketInventoryConfigurationsResponse}

```json
{
  "configurations": [
    {
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| configurations[] | **[InventoryConfiguration](#yandex.cloud.storage.v1.InventoryConfiguration)**

List of inventory configurations. ||
|| next_page_token | **string**

Continuation token to retrieve the next page of results. ||
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