---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Image/list.md
---

# Compute Cloud API, REST: Image.List {#List}

Retrieves the list of Image resources in the specified folder.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/images
```

## Query parameters {#yandex.cloud.compute.v1.ListImagesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list images in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListImagesResponse.nextPageToken](#yandex.cloud.compute.v1.ListImagesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListImagesResponse.nextPageToken](#yandex.cloud.compute.v1.ListImagesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
The default sorting order is ascending ||
|#

## Response {#yandex.cloud.compute.v1.ListImagesResponse}

**HTTP Code: 200 - OK**

```json
{
  "images": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "family": "string",
      "storageSize": "string",
      "minDiskSize": "string",
      "productIds": [
        "string"
      ],
      "status": "string",
      "os": {
        "type": "string"
      },
      "pooled": "boolean",
      "hardwareGeneration": {
        // Includes only one of the fields `legacyFeatures`, `generation2Features`
        "legacyFeatures": {
          "pciTopology": "string"
        },
        "generation2Features": "object"
        // end of the list of possible fields
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.compute.v1.Image)**

List of images. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListSnapshotsRequest.pageSize](/docs/compute/api-ref/Snapshot/list#yandex.cloud.compute.v1.ListSnapshotsRequest), use
the `nextPageToken` as the value
for the [ListSnapshotsRequest.pageToken](/docs/compute/api-ref/Snapshot/list#yandex.cloud.compute.v1.ListSnapshotsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Image {#yandex.cloud.compute.v1.Image}

An Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folderId | **string**

ID of the folder that the image belongs to. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the image. 1-63 characters long. ||
|| description | **string**

Description of the image. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| family | **string**

The name of the image family to which this image belongs.

You can get the most recent image from a family by using
the [yandex.cloud.compute.v1.ImageService.GetLatestByFamily](/docs/compute/api-ref/Image/getLatestByFamily#GetLatestByFamily) request
and create the disk from this image. ||
|| storageSize | **string** (int64)

The size of the image, specified in bytes. ||
|| minDiskSize | **string** (int64)

Minimum size of the disk which will be created from this image. ||
|| productIds[] | **string**

License IDs that indicate which licenses are attached to this resource.
License IDs are used to calculate additional charges for the use of the virtual machine.

The correct license ID is generated by the platform. IDs are inherited by new resources created from this resource.

If you know the license IDs, specify them when you create the image.
For example, if you create a disk image using a third-party utility and load it into Object Storage, the license IDs will be lost.
You can specify them in the [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/Image/create#Create) request. ||
|| status | **enum** (Status)

Current status of the image.

- `STATUS_UNSPECIFIED`
- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered a problem and cannot operate.
- `DELETING`: Image is being deleted. ||
|| os | **[Os](#yandex.cloud.compute.v1.Os)**

Operating system that is contained in the image. ||
|| pooled | **boolean**

When true, indicates there is an image pool for fast creation disks from the image. ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

If specified, forces the same HardwareGeneration features to be applied to the instance
created using this image as a source for the boot disk. Otherwise the current default will be used. ||
|#

## Os {#yandex.cloud.compute.v1.Os}

#|
||Field | Description ||
|| type | **enum** (Type)

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