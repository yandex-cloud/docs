---
editable: false
apiPlayground:
  - url: https://storage.{{ api-host }}/storage/v1/buckets/{bucket}/{id}:getInventoryConfiguration
    method: get
    path:
      type: object
      properties:
        bucket:
          description: |-
            **string**
            Required field. Name of the bucket to get the inventory configuration for.
          type: string
        id:
          description: |-
            **string**
            Required field. ID of the inventory configuration to get.
          type: string
      required:
        - bucket
        - id
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Object Storage API, REST: Bucket.GetInventoryConfiguration

Get an inventory configuration with the corresponding ID

## HTTP request

```
GET https://storage.{{ api-host }}/storage/v1/buckets/{bucket}/{id}:getInventoryConfiguration
```

## Path parameters

#|
||Field | Description ||
|| bucket | **string**

Required field. Name of the bucket to get the inventory configuration for. ||
|| id | **string**

Required field. ID of the inventory configuration to get. ||
|#

## Response {#yandex.cloud.storage.v1.InventoryConfiguration}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "destination": {
    "bucketDestination": {
      "bucket": "string",
      "format": "string",
      "prefix": "string"
    }
  },
  "includedObjectVersions": "string",
  "isEnabled": "boolean",
  "schedule": {
    "frequency": "string"
  },
  "filter": {
    "prefix": "string"
  },
  "optionalFields": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| id | **string**

Required field. The ID used to identify the inventory configuration. ||
|| destination | **[InventoryDestination](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryDestination)**

Required field. Contains information about where to publish the inventory results. ||
|| includedObjectVersions | **enum** (IncludedObjectVersions)

Required field. Object versions to include in the inventory list.

- `ALL`: Include all versions.
- `CURRENT`: Include only the current version. ||
|| isEnabled | **boolean**

Specifies whether the inventory is enabled. ||
|| schedule | **[InventorySchedule](#yandex.cloud.storage.v1.InventoryConfiguration.InventorySchedule)**

Required field. Specifies the schedule for generating inventory results. ||
|| filter | **[InventoryFilter](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryFilter)**

Specifies the filter for objects to include in the inventory. ||
|| optionalFields[] | **enum** (OptionalField)

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
|| bucketDestination | **[InventoryBucketDestination](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryBucketDestination)**

Required field. Destination bucket settings ||
|#

## InventoryBucketDestination {#yandex.cloud.storage.v1.InventoryConfiguration.InventoryBucketDestination}

#|
||Field | Description ||
|| bucket | **string**

Required field. Bucket where inventory results will be published. ||
|| format | **enum** (Format)

Required field. Specifies the output format of the inventory results.

- `CSV`: CSV format. ||
|| prefix | **string**

The prefix that is prepended to all inventory results. ||
|#

## InventorySchedule {#yandex.cloud.storage.v1.InventoryConfiguration.InventorySchedule}

#|
||Field | Description ||
|| frequency | **enum** (Frequency)

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