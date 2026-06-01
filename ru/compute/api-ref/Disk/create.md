---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/disks
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to create a disk in.
            To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
            The length must be less than or equal to 50.
            This field is required.
          type: string
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
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
            Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
            The length of each map key must be between 1 and 63.
            The length of each map value must be less than or equal to 63.
            The number of elements must be less than or equal to 64.
          type: object
          additionalProperties:
            type: string
        typeId:
          description: |-
            **string**
            ID of the disk type.
            To get a list of available disk types use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request.
            The length must be less than or equal to 50.
          type: string
        zoneId:
          description: |-
            **string**
            ID of the availability zone where the disk resides.
            To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
            The length must be less than or equal to 50.
            This field is required.
          type: string
        size:
          description: |-
            **string** (int64)
            Size of the disk, specified in bytes.
            If the disk was created from a image, this value should be more than the
            [yandex.cloud.compute.v1.Image.minDiskSize](/docs/compute/api-ref/Image/get#yandex.cloud.compute.v1.Image) value.
            The value must be between 4194304 and 28587302322176.
            This field is required.
          type: string
          format: int64
        blockSize:
          description: |-
            **string** (int64)
            Block size used for disk, specified in bytes. The default is 4096.
          type: string
          format: int64
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
        diskPlacementPolicy:
          description: |-
            **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**
            Placement policy configuration.
          $ref: '#/definitions/DiskPlacementPolicy'
        snapshotScheduleIds:
          description: |-
            **string**
            List of IDs of the snapshot schedules to attach the disk to.
          type: array
          items:
            type: string
        hardwareGeneration:
          description: |-
            **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**
            Specify the overrides to hardware_generation of a source disk, image or snapshot,
            or to the default values if the source does not define it.
          $ref: '#/definitions/HardwareGeneration'
        kmsKeyId:
          description: |-
            **string**
            ID of KMS key for disk encryption.
            The length must be less than or equal to 50.
          type: string
      additionalProperties: false
      oneOf:
        - required:
            - imageId
        - required:
            - snapshotId
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
      LegacyHardwareFeatures:
        type: object
        properties:
          pciTopology:
            description: |-
              **enum** (PCITopology)
              - `PCI_TOPOLOGY_V1`
              - `PCI_TOPOLOGY_V2`
            type: string
            enum:
              - PCI_TOPOLOGY_UNSPECIFIED
              - PCI_TOPOLOGY_V1
              - PCI_TOPOLOGY_V2
      Generation2HardwareFeatures:
        type: object
        properties: {}
      HardwareGeneration:
        type: object
        properties:
          legacyFeatures:
            description: |-
              **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures)**
              Includes only one of the fields `legacyFeatures`, `generation2Features`.
            $ref: '#/definitions/LegacyHardwareFeatures'
          generation2Features:
            description: |-
              **object**
              Includes only one of the fields `legacyFeatures`, `generation2Features`.
            $ref: '#/definitions/Generation2HardwareFeatures'
        oneOf:
          - required:
              - legacyFeatures
          - required:
              - generation2Features
---

# Compute Cloud API, REST: Disk.Create

Creates a disk in the specified folder.
You can create an empty disk or restore it from a snapshot or an image.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/disks
```

## Body parameters {#yandex.cloud.compute.v1.CreateDiskRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "typeId": "string",
  "zoneId": "string",
  "size": "string",
  "blockSize": "string",
  // Includes only one of the fields `imageId`, `snapshotId`
  "imageId": "string",
  "snapshotId": "string",
  // end of the list of possible fields
  "diskPlacementPolicy": {
    "placementGroupId": "string",
    "placementGroupPartition": "string"
  },
  "snapshotScheduleIds": [
    "string"
  ],
  "hardwareGeneration": {
    // Includes only one of the fields `legacyFeatures`, `generation2Features`
    "legacyFeatures": {
      "pciTopology": "string"
    },
    "generation2Features": "object"
    // end of the list of possible fields
  },
  "kmsKeyId": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create a disk in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the disk.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the disk.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| typeId | **string**

ID of the disk type.
To get a list of available disk types use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request.
The length must be less than or equal to 50. ||
|| zoneId | **string**

ID of the availability zone where the disk resides.
To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| size | **string** (int64)

Size of the disk, specified in bytes.
If the disk was created from a image, this value should be more than the
[yandex.cloud.compute.v1.Image.minDiskSize](/docs/compute/api-ref/Image/get#yandex.cloud.compute.v1.Image) value.
The value must be between 4194304 and 28587302322176.
This field is required. ||
|| blockSize | **string** (int64)

Block size used for disk, specified in bytes. The default is 4096. ||
|| imageId | **string**

ID of the image to create the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

ID of the snapshot to restore the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| diskPlacementPolicy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| snapshotScheduleIds[] | **string**

List of IDs of the snapshot schedules to attach the disk to. ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

Specify the overrides to hardware_generation of a source disk, image or snapshot,
or to the default values if the source does not define it. ||
|| kmsKeyId | **string**

ID of KMS key for disk encryption.
The length must be less than or equal to 50. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **string** (int64) ||
|#

## HardwareGeneration {#yandex.cloud.compute.v1.HardwareGeneration}

A set of features, specific to a particular Compute hardware generation.
They are not necessary supported by every host OS or distro, thus they are fixed to an image
and are applied to all instances created with it as their boot disk image.
These features significantly determine how the instance is created, thus cannot be changed after the fact.

#|
||Field | Description ||
|| legacyFeatures | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures)**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|| generation2Features | **object**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pciTopology | **enum** (PCITopology)

- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
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