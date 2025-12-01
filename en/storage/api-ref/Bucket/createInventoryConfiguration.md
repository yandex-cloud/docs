---
editable: false
apiPlayground:
  - url: https://storage.{{ api-host }}/storage/v1/buckets/{bucket}/{id}:createInventoryConfiguration
    method: post
    path:
      type: object
      properties:
        bucket:
          description: |-
            **string**
            Required field. Name of the bucket to update the inventory configuration for.
          type: string
        id:
          description: |-
            **string**
            Required field. ID of the inventory configuration to set.
          type: string
      required:
        - bucket
        - id
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        configuration:
          description: |-
            **[InventoryConfiguration](#yandex.cloud.storage.v1.InventoryConfiguration)**
            Required field. Inventory configuration.
          $ref: '#/definitions/InventoryConfiguration'
      required:
        - configuration
      additionalProperties: false
    definitions:
      InventoryBucketDestination:
        type: object
        properties:
          bucket:
            description: |-
              **string**
              Required field. Bucket where inventory results will be published.
            type: string
          format:
            description: |-
              **enum** (Format)
              Required field. Specifies the output format of the inventory results.
              - `CSV`: CSV format.
            type: string
            enum:
              - FORMAT_UNSPECIFIED
              - CSV
          prefix:
            description: |-
              **string**
              The prefix that is prepended to all inventory results.
            type: string
        required:
          - bucket
          - format
      InventoryDestination:
        type: object
        properties:
          bucketDestination:
            description: |-
              **[InventoryBucketDestination](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryBucketDestination)**
              Required field. Destination bucket settings
            $ref: '#/definitions/InventoryBucketDestination'
        required:
          - bucketDestination
      InventorySchedule:
        type: object
        properties:
          frequency:
            description: |-
              **enum** (Frequency)
              Required field. Specifies how frequently inventory results are produced.
              - `DAILY`: Daily generation.
              - `WEEKLY`: Weekly generation.
            type: string
            enum:
              - FREQUENCY_UNSPECIFIED
              - DAILY
              - WEEKLY
        required:
          - frequency
      InventoryFilter:
        type: object
        properties:
          prefix:
            description: |-
              **string**
              Required field. The prefix that an object must have to be included in the inventory results.
            type: string
        required:
          - prefix
      InventoryConfiguration:
        type: object
        properties:
          id:
            description: |-
              **string**
              Required field. The ID used to identify the inventory configuration.
            type: string
          destination:
            description: |-
              **[InventoryDestination](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryDestination)**
              Required field. Contains information about where to publish the inventory results.
            $ref: '#/definitions/InventoryDestination'
          includedObjectVersions:
            description: |-
              **enum** (IncludedObjectVersions)
              Required field. Object versions to include in the inventory list.
              - `ALL`: Include all versions.
              - `CURRENT`: Include only the current version.
            type: string
            enum:
              - INCLUDED_OBJECT_VERSIONS_UNSPECIFIED
              - ALL
              - CURRENT
          isEnabled:
            description: |-
              **boolean**
              Specifies whether the inventory is enabled.
            type: boolean
          schedule:
            description: |-
              **[InventorySchedule](#yandex.cloud.storage.v1.InventoryConfiguration.InventorySchedule)**
              Required field. Specifies the schedule for generating inventory results.
            $ref: '#/definitions/InventorySchedule'
          filter:
            description: |-
              **[InventoryFilter](#yandex.cloud.storage.v1.InventoryConfiguration.InventoryFilter)**
              Specifies the filter for objects to include in the inventory.
            $ref: '#/definitions/InventoryFilter'
          optionalFields:
            description: |-
              **enum** (OptionalField)
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
              - `OBJECT_OWNER`: The owner of the object.
            type: array
            items:
              type: string
              enum:
                - OPTIONAL_FIELD_UNSPECIFIED
                - SIZE
                - LAST_MODIFIED_DATE
                - STORAGE_CLASS
                - ETAG
                - IS_MULTIPART_UPLOADED
                - ENCRYPTION_STATUS
                - OBJECT_LOCK_RETAIN_UNTIL_DATE
                - OBJECT_LOCK_MODE
                - OBJECT_LOCK_LEGAL_HOLD_STATUS
                - CHECKSUM_ALGORITHM
                - OBJECT_ACCESS_CONTROL_LIST
                - OBJECT_OWNER
        required:
          - id
          - destination
          - includedObjectVersions
          - schedule
sourcePath: en/_api-ref/storage/v1/api-ref/Bucket/createInventoryConfiguration.md
---

# Object Storage API, REST: Bucket.CreateInventoryConfiguration

Create/Update an inventory configuration with the corresponding ID

## HTTP request

```
POST https://storage.{{ api-host }}/storage/v1/buckets/{bucket}/{id}:createInventoryConfiguration
```

## Path parameters

#|
||Field | Description ||
|| bucket | **string**

Required field. Name of the bucket to update the inventory configuration for. ||
|| id | **string**

Required field. ID of the inventory configuration to set. ||
|#

## Body parameters {#yandex.cloud.storage.v1.CreateBucketInventoryConfigurationRequest}

```json
{
  "configuration": {
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
}
```

#|
||Field | Description ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "name": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  }
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateBucketInventoryConfigurationMetadata](#yandex.cloud.storage.v1.CreateBucketInventoryConfigurationMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#