---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Image/list.md
---

# Compute Cloud API, gRPC: ImageService.List

Retrieves the list of Image resources in the specified folder.

## gRPC request

**rpc List ([ListImagesRequest](#yandex.cloud.compute.v1.ListImagesRequest)) returns ([ListImagesResponse](#yandex.cloud.compute.v1.ListImagesResponse))**

## ListImagesRequest {#yandex.cloud.compute.v1.ListImagesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list images in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListImagesResponse.next_page_token](#yandex.cloud.compute.v1.ListImagesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListImagesResponse.next_page_token](#yandex.cloud.compute.v1.ListImagesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
The default sorting order is ascending ||
|#

## ListImagesResponse {#yandex.cloud.compute.v1.ListImagesResponse}

```json
{
  "images": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "family": "string",
      "storage_size": "int64",
      "min_disk_size": "int64",
      "product_ids": [
        "string"
      ],
      "status": "Status",
      "os": {
        "type": "Type"
      },
      "pooled": "bool",
      "hardware_generation": {
        // Includes only one of the fields `legacy_features`, `generation2_features`
        "legacy_features": {
          "pci_topology": "PCITopology"
        },
        "generation2_features": "Generation2HardwareFeatures"
        // end of the list of possible fields
      },
      "kms_key": {
        "key_id": "string",
        "version_id": "string"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.compute.v1.Image)**

List of images. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListSnapshotsRequest.page_size](/docs/compute/api-ref/grpc/Snapshot/list#yandex.cloud.compute.v1.ListSnapshotsRequest), use
the `next_page_token` as the value
for the [ListSnapshotsRequest.page_token](/docs/compute/api-ref/grpc/Snapshot/list#yandex.cloud.compute.v1.ListSnapshotsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Image {#yandex.cloud.compute.v1.Image}

An Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the image. 1-63 characters long. ||
|| description | **string**

Description of the image. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| family | **string**

The name of the image family to which this image belongs.

You can get the most recent image from a family by using
the [yandex.cloud.compute.v1.ImageService.GetLatestByFamily](/docs/compute/api-ref/grpc/Image/getLatestByFamily#GetLatestByFamily) request
and create the disk from this image. ||
|| storage_size | **int64**

The size of the image, specified in bytes. ||
|| min_disk_size | **int64**

Minimum size of the disk which will be created from this image. ||
|| product_ids[] | **string**

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
|| hardware_generation | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

If specified, forces the same HardwareGeneration features to be applied to the instance
created using this image as a source for the boot disk. Otherwise the current default will be used. ||
|| kms_key | **[KMSKey](#yandex.cloud.compute.v1.KMSKey)**

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
|| legacy_features | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures)**

Includes only one of the fields `legacy_features`, `generation2_features`. ||
|| generation2_features | **[Generation2HardwareFeatures](#yandex.cloud.compute.v1.Generation2HardwareFeatures)**

Includes only one of the fields `legacy_features`, `generation2_features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pci_topology | enum **PCITopology**

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
|| key_id | **string**

ID of KMS symmetric key ||
|| version_id | **string**

Version of KMS symmetric key ||
|#