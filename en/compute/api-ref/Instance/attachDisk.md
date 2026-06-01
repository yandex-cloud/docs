---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:attachDisk
    method: post
    path:
      type: object
      properties:
        instanceId:
          description: |-
            **string**
            ID of the instance to attach the disk to.
            To get the instance ID, use a [InstanceService.List](/docs/compute/api-ref/Instance/list#List) request.
            The length must be less than or equal to 50.
            This field is required.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        attachedDiskSpec:
          description: |-
            **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**
            Disk that should be attached.
            This field is required.
          $ref: '#/definitions/AttachedDiskSpec'
      additionalProperties: false
    definitions:
      DiskPlacementPolicy:
        type: object
        properties:
          placementGroupId:
            description: |-
              **string**
              Placement group ID.
            type: string
          placementGroupPartition:
            description: '**string** (int64)'
            type: string
            format: int64
      DiskSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the disk.
              The value must match the regular expression: `|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?`.
            type: string
          description:
            description: |-
              **string**
              Description of the disk.
              The length must be less than or equal to 256.
            type: string
          typeId:
            description: |-
              **string**
              ID of the disk type.
              To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request.
              The length must be less than or equal to 50.
            type: string
          size:
            description: |-
              **string** (int64)
              Size of the disk, specified in bytes.
              The value must be between 4194304 and 4398046511104.
              This field is required.
            type: string
            format: int64
          blockSize:
            description: |-
              **string** (int64)
              Block size of the disk, specified in bytes. The default is 4096.
            type: string
            format: int64
          diskPlacementPolicy:
            description: |-
              **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**
              Placement policy configuration.
            $ref: '#/definitions/DiskPlacementPolicy'
          imageId:
            description: |-
              **string**
              ID of the image to create the disk from.
              The length must be less than or equal to 50.
              Includes only one of the fields `imageId`, `snapshotId`.
            type: string
          snapshotId:
            description: |-
              **string**
              ID of the snapshot to restore the disk from.
              The length must be less than or equal to 50.
              Includes only one of the fields `imageId`, `snapshotId`.
            type: string
          kmsKeyId:
            description: |-
              **string**
              ID of KMS key for disk encryption
              The length must be less than or equal to 50.
            type: string
        oneOf:
          - required:
              - imageId
          - required:
              - snapshotId
      AttachedDiskSpec:
        type: object
        properties:
          mode:
            description: |-
              **enum** (Mode)
              The mode in which to attach this disk.
              - `READ_ONLY`: Read-only access.
              - `READ_WRITE`: Read/Write access.
            type: string
            enum:
              - MODE_UNSPECIFIED
              - READ_ONLY
              - READ_WRITE
          deviceName:
            description: |-
              **string**
              Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree
              of a Linux operating system running within the instance.
              This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
              If not specified, a random value will be generated.
              The value must match the regular expression: `[a-z][a-z0-9-_]{,19}`.
            type: string
          autoDelete:
            description: |-
              **boolean**
              Specifies whether the disk will be auto-deleted when the instance is deleted.
            type: boolean
          diskSpec:
            description: |-
              **[DiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec)**
              Disk specification.
              Includes only one of the fields `diskSpec`, `diskId`.
              Only one field must by specified.
            $ref: '#/definitions/DiskSpec'
          diskId:
            description: |-
              **string**
              ID of the disk that should be attached.
              The length must be less than or equal to 50.
              Includes only one of the fields `diskSpec`, `diskId`.
              Only one field must by specified.
            type: string
        oneOf:
          - required:
              - diskSpec
          - required:
              - diskId
---

# Compute Cloud API, REST: Instance.AttachDisk

Attaches the disk to the instance.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:attachDisk
```

## Path parameters

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the instance to attach the disk to.
To get the instance ID, use a [InstanceService.List](/docs/compute/api-ref/Instance/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|#

## Body parameters {#yandex.cloud.compute.v1.AttachInstanceDiskRequest}

```json
{
  "attachedDiskSpec": {
    "mode": "string",
    "deviceName": "string",
    "autoDelete": "boolean",
    // Includes only one of the fields `diskSpec`, `diskId`
    "diskSpec": {
      "name": "string",
      "description": "string",
      "typeId": "string",
      "size": "string",
      "blockSize": "string",
      "diskPlacementPolicy": {
        "placementGroupId": "string",
        "placementGroupPartition": "string"
      },
      // Includes only one of the fields `imageId`, `snapshotId`
      "imageId": "string",
      "snapshotId": "string",
      // end of the list of possible fields
      "kmsKeyId": "string"
    },
    "diskId": "string"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| attachedDiskSpec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Disk that should be attached.
This field is required. ||
|#

## AttachedDiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

The mode in which to attach this disk.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| deviceName | **string**

Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.
This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
If not specified, a random value will be generated.
The value must match the regular expression: `[a-z][a-z0-9-_]{,19}`. ||
|| autoDelete | **boolean**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| diskSpec | **[DiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec)**

Disk specification.

Includes only one of the fields `diskSpec`, `diskId`.

Only one field must by specified. ||
|| diskId | **string**

ID of the disk that should be attached.
The length must be less than or equal to 50.

Includes only one of the fields `diskSpec`, `diskId`.

Only one field must by specified. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| name | **string**

Name of the disk.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the disk.
The length must be less than or equal to 256. ||
|| typeId | **string**

ID of the disk type.
To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request.
The length must be less than or equal to 50. ||
|| size | **string** (int64)

Size of the disk, specified in bytes.
The value must be between 4194304 and 4398046511104.
This field is required. ||
|| blockSize | **string** (int64)

Block size of the disk, specified in bytes. The default is 4096. ||
|| diskPlacementPolicy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| imageId | **string**

ID of the image to create the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

ID of the snapshot to restore the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| kmsKeyId | **string**

ID of KMS key for disk encryption
The length must be less than or equal to 50. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **string** (int64) ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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