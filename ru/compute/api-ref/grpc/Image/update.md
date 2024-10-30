---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Image/update.md
---

# Compute Cloud API, gRPC: ImageService.Update {#Update}

Updates the specified image.

## gRPC request

**rpc Update ([UpdateImageRequest](#yandex.cloud.compute.v1.UpdateImageRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateImageRequest {#yandex.cloud.compute.v1.UpdateImageRequest}

```json
{
  "imageId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "minDiskSize": "int64",
  "labels": "string"
}
```

#|
||Field | Description ||
|| imageId | **string**

Required field. ID of the Image resource to update.
To get the image ID, use a [ImageService.List](/docs/compute/api-ref/grpc/Image/list#List) request. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Image resource are going to be updated. ||
|| name | **string**

Name of the image. ||
|| description | **string**

Description of the image. ||
|| minDiskSize | **int64**

Minimum size of the disk that can be created from this image.
Specified in bytes. Should be more than the volume of source data and more than the virtual disk size. ||
|| labels | **string**

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "imageId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "family": "string",
    "storageSize": "int64",
    "minDiskSize": "int64",
    "productIds": [
      "string"
    ],
    "status": "Status",
    "os": {
      "type": "Type"
    },
    "pooled": "bool",
    "hardwareGeneration": {
      // Includes only one of the fields `legacyFeatures`, `generation2Features`
      "legacyFeatures": {
        "pciTopology": "PCITopology"
      },
      "generation2Features": "Generation2HardwareFeatures"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateImageMetadata](#yandex.cloud.compute.v1.UpdateImageMetadata)**

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
|| response | **[Image](#yandex.cloud.compute.v1.Image)**

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

## UpdateImageMetadata {#yandex.cloud.compute.v1.UpdateImageMetadata}

#|
||Field | Description ||
|| imageId | **string**

ID of the Image resource that is being updated. ||
|#

## Image {#yandex.cloud.compute.v1.Image}

An Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folderId | **string**

ID of the folder that the image belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the image. 1-63 characters long. ||
|| description | **string**

Description of the image. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| family | **string**

The name of the image family to which this image belongs.

You can get the most recent image from a family by using
the [yandex.cloud.compute.v1.ImageService.GetLatestByFamily](/docs/compute/api-ref/grpc/Image/getLatestByFamily#GetLatestByFamily) request
and create the disk from this image. ||
|| storageSize | **int64**

The size of the image, specified in bytes. ||
|| minDiskSize | **int64**

Minimum size of the disk which will be created from this image. ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to this resource.
License IDs are used to calculate additional charges for the use of the virtual machine.

The correct license ID is generated by the platform. IDs are inherited by new resources created from this resource.

If you know the license IDs, specify them when you create the image.
For example, if you create a disk image using a third-party utility and load it into Object Storage, the license IDs will be lost.
You can specify them in the [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/Image/create#Create) request. ||
|| status | enum **Status**

Current status of the image.

- `STATUS_UNSPECIFIED`
- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered a problem and cannot operate.
- `DELETING`: Image is being deleted. ||
|| os | **[Os](#yandex.cloud.compute.v1.Os)**

Operating system that is contained in the image. ||
|| pooled | **bool**

When true, indicates there is an image pool for fast creation disks from the image. ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

If specified, forces the same HardwareGeneration features to be applied to the instance
created using this image as a source for the boot disk. Otherwise the current default will be used. ||
|| kmsKey | **[KMSKey](#yandex.cloud.compute.v1.KMSKey)**

Key encryption key info. ||
|#

## Os {#yandex.cloud.compute.v1.Os}

#|
||Field | Description ||
|| type | enum **Type**

Operating system type. The default is `LINUX`.

This field is used to correctly emulate a vCPU and calculate the cost of using an instance.

- `TYPE_UNSPECIFIED`
- `LINUX`: Linux operating system.
- `WINDOWS`: Windows operating system. ||
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
|| generation2Features | **[Generation2HardwareFeatures](#yandex.cloud.compute.v1.Generation2HardwareFeatures)**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pciTopology | enum **PCITopology**

- `PCI_TOPOLOGY_UNSPECIFIED`
- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
|#

## Generation2HardwareFeatures {#yandex.cloud.compute.v1.Generation2HardwareFeatures}

A second hardware generation, which by default assumes PCI_TOPOLOGY_V2
and UEFI boot (with UEFI related features).

#|
||Field | Description ||
|| Empty | > ||
|#

## KMSKey {#yandex.cloud.compute.v1.KMSKey}

#|
||Field | Description ||
|| keyId | **string**

ID of KMS symmetric key ||
|| versionId | **string**

Version of KMS symmetric key ||
|#