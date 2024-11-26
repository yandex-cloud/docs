---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Snapshot/create.md
---

# Compute Cloud API, REST: Snapshot.Create

Creates a snapshot of the specified disk.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/snapshots
```

## Body parameters {#yandex.cloud.compute.v1.CreateSnapshotRequest}

```json
{
  "folderId": "string",
  "diskId": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "hardwareGeneration": {
    // Includes only one of the fields `legacyFeatures`, `generation2Features`
    "legacyFeatures": {
      "pciTopology": "string"
    },
    "generation2Features": "object"
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a snapshot in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| diskId | **string**

Required field. ID of the disk to create the snapshot from.
To get the disk ID use a [yandex.cloud.compute.v1.DiskService.List](/docs/compute/api-ref/Disk/list#List) request. ||
|| name | **string**

Name of the snapshot. ||
|| description | **string**

Description of the snapshot. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

Specify the overrides to hardware_generation of a source disk, image or snapshot,
or to the default values if the source does not define it. ||
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

- `PCI_TOPOLOGY_UNSPECIFIED`
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
  "metadata": {
    "snapshotId": "string",
    "diskId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "string",
    "storageSize": "string",
    "diskSize": "string",
    "productIds": [
      "string"
    ],
    "status": "string",
    "sourceDiskId": "string",
    "hardwareGeneration": {
      // Includes only one of the fields `legacyFeatures`, `generation2Features`
      "legacyFeatures": {
        "pciTopology": "string"
      },
      "generation2Features": "object"
      // end of the list of possible fields
    },
    "kmsKey": {
      "keyId": "string",
      "versionId": "string"
    }
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
|| metadata | **[CreateSnapshotMetadata](#yandex.cloud.compute.v1.CreateSnapshotMetadata)**

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
|| response | **[Snapshot](#yandex.cloud.compute.v1.Snapshot)**

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

## CreateSnapshotMetadata {#yandex.cloud.compute.v1.CreateSnapshotMetadata}

#|
||Field | Description ||
|| snapshotId | **string**

ID of the snapshot that is being created. ||
|| diskId | **string**

ID of the source disk used to create this snapshot. ||
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

## Snapshot {#yandex.cloud.compute.v1.Snapshot}

A Snapshot resource. For more information, see [Snapshots](/docs/compute/concepts/snapshot).

#|
||Field | Description ||
|| id | **string**

ID of the snapshot. ||
|| folderId | **string**

ID of the folder that the snapshot belongs to. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the snapshot. 1-63 characters long. ||
|| description | **string**

Description of the snapshot. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| storageSize | **string** (int64)

Size of the snapshot, specified in bytes. ||
|| diskSize | **string** (int64)

Size of the disk when the snapshot was created, specified in bytes. ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to this resource.
License IDs are used to calculate additional charges for the use of the virtual machine.

The correct license ID is generated by the platform. IDs are inherited by new resources created from this resource.

If you know the license IDs, specify them when you create the image.
For example, if you create a disk image using a third-party utility and load it into Object Storage, the license IDs will be lost.
You can specify them in the [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/Image/create#Create) request. ||
|| status | **enum** (Status)

Current status of the snapshot.

- `STATUS_UNSPECIFIED`
- `CREATING`: Snapshot is being created.
- `READY`: Snapshot is ready to use.
- `ERROR`: Snapshot encountered a problem and cannot operate.
- `DELETING`: Snapshot is being deleted. ||
|| sourceDiskId | **string**

ID of the source disk used to create this snapshot. ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration2)**

If specified, forces the same HardwareGeneration features to be applied to the instance
created using this snapshot as source for the boot disk. Otherwise the current default will be used. ||
|| kmsKey | **[KMSKey](#yandex.cloud.compute.v1.KMSKey)**

Key encryption key info. ||
|#

## HardwareGeneration {#yandex.cloud.compute.v1.HardwareGeneration2}

A set of features, specific to a particular Compute hardware generation.
They are not necessary supported by every host OS or distro, thus they are fixed to an image
and are applied to all instances created with it as their boot disk image.
These features significantly determine how the instance is created, thus cannot be changed after the fact.

#|
||Field | Description ||
|| legacyFeatures | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures2)**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|| generation2Features | **object**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures2}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pciTopology | **enum** (PCITopology)

- `PCI_TOPOLOGY_UNSPECIFIED`
- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
|#

## KMSKey {#yandex.cloud.compute.v1.KMSKey}

#|
||Field | Description ||
|| keyId | **string**

ID of KMS symmetric key ||
|| versionId | **string**

Version of KMS symmetric key ||
|#