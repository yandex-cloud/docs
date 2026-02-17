---
editable: false
---

# Cloud Desktop API, gRPC: DesktopGroupService.Update

Updates desktop group properties

## gRPC request

**rpc Update ([UpdateDesktopGroupRequest](#yandex.cloud.clouddesktop.v1.api.UpdateDesktopGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateDesktopGroupRequest {#yandex.cloud.clouddesktop.v1.api.UpdateDesktopGroupRequest}

```json
{
  "desktop_group_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "desktop_image_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "resources_spec": {
    "memory": "int64",
    "cores": "int64",
    "core_fraction": "int64"
  },
  "group_config": {
    "min_ready_desktops": "int64",
    "max_desktops_amount": "int64",
    "desktop_type": "DesktopType",
    "members": [
      {
        "id": "string",
        "type": "string"
      }
    ]
  },
  "boot_disk_spec": {
    "type": "Type",
    "size": "int64"
  },
  "data_disk_spec": {
    "type": "Type",
    "size": "int64"
  },
  // Includes only one of the fields `auto_update_policy`, `manual_update_policy`
  "auto_update_policy": "AutoUpdatePolicy",
  "manual_update_policy": "ManualUpdatePolicy"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| desktop_group_id | **string**

Required field.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)** ||
|| desktop_image_id | **string**

The maximum string length in characters is 50. ||
|| name | **string**

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9]) ```. ||
|| description | **string**

The maximum string length in characters is 1024. ||
|| labels | **object** (map<**string**, **string**>)

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)** ||
|| group_config | **[DesktopGroupConfiguration](#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration)**

Configuration of the desktop group. ||
|| boot_disk_spec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Boot disk specification of the desktop group. ||
|| data_disk_spec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Data disk specification of the desktop group. ||
|| auto_update_policy | **[AutoUpdatePolicy](#yandex.cloud.clouddesktop.v1.api.AutoUpdatePolicy)**

Includes only one of the fields `auto_update_policy`, `manual_update_policy`.

Update policy of the desktop group. ||
|| manual_update_policy | **[ManualUpdatePolicy](#yandex.cloud.clouddesktop.v1.api.ManualUpdatePolicy)**

Includes only one of the fields `auto_update_policy`, `manual_update_policy`.

Update policy of the desktop group. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

RAM volume, in bytes.

The minimum value is 1. ||
|| cores | **int64**

Number of CPU cores.

The minimum value is 1. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.

Acceptable values are 0 to 100, inclusive. ||
|#

## DesktopGroupConfiguration {#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration}

#|
||Field | Description ||
|| min_ready_desktops | **int64**

Minimum number of ready desktops.

Acceptable values are 1 to 512, inclusive. ||
|| max_desktops_amount | **int64**

Maximum number of desktops.

Acceptable values are 0 to 512, inclusive. ||
|| desktop_type | enum **DesktopType**

Type of the desktop.

- `PERSISTENT`
- `NON_PERSISTENT` ||
|| members[] | **[Subject](#yandex.cloud.access.Subject)**

List of members of the desktop group.

The number of elements must be in the range 0-10. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.

It can contain one of the following values:
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given &lt;id&gt;. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given &lt;id&gt;. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`.

The maximum string length in characters is 100. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/grpc/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject).

The maximum string length in characters is 100. ||
|#

## DiskSpec {#yandex.cloud.clouddesktop.v1.api.DiskSpec}

Disk specificaton.

#|
||Field | Description ||
|| type | enum **Type**

Required field. Type of disk.

- `HDD`: HDD disk type.
- `SSD`: SSD disk type. ||
|| size | **int64**

Size of disk.

Value must be greater than 0. ||
|#

## AutoUpdatePolicy {#yandex.cloud.clouddesktop.v1.api.AutoUpdatePolicy}

#|
||Field | Description ||
|| Empty | > ||
|#

## ManualUpdatePolicy {#yandex.cloud.clouddesktop.v1.api.ManualUpdatePolicy}

#|
||Field | Description ||
|| Empty | > ||
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
    "desktop_group_id": "string"
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
|| metadata | **[UpdateDesktopGroupMetadata](#yandex.cloud.clouddesktop.v1.api.UpdateDesktopGroupMetadata)**

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

## UpdateDesktopGroupMetadata {#yandex.cloud.clouddesktop.v1.api.UpdateDesktopGroupMetadata}

#|
||Field | Description ||
|| desktop_group_id | **string**

ID of the desktop group that is being updated. ||
|#