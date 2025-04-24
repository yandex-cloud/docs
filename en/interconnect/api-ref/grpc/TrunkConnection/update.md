---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/TrunkConnection/update.md
---

# Cloud Interconnect API, gRPC: TrunkConnectionService.Update

Updates a TrunkConnection resource using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc Update ([UpdateTrunkConnectionRequest](#yandex.cloud.cic.v1.UpdateTrunkConnectionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateTrunkConnectionRequest {#yandex.cloud.cic.v1.UpdateTrunkConnectionRequest}

```json
{
  "trunk_connection_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "region_id": "string",
  "point_of_presence_id": "google.protobuf.StringValue",
  "capacity": "Capacity",
  "labels": "map<string, string>",
  "deletion_protection": "bool"
}
```

#|
||Field | Description ||
|| trunk_connection_id | **string**

Required field. ID of the TrunkConnection resource to return. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the TrunkConnection resource are going to be updated. ||
|| name | **string**

Name of the trunkConnection.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the trunkConnection. 0-256 characters long. ||
|| region_id | **string**

ID of the region that the trunkConnection belongs to. ||
|| point_of_presence_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of pointOfPresence that the trunkConnection is deployed on.
Optional.
If is not set scheduler selects it by himself. ||
|| capacity | enum **Capacity**

Capacity of the trunkConnection

- `CAPACITY_UNSPECIFIED`
- `CAPACITY_50_MBPS`
- `CAPACITY_100_MBPS`
- `CAPACITY_200_MBPS`
- `CAPACITY_300_MBPS`
- `CAPACITY_400_MBPS`
- `CAPACITY_500_MBPS`
- `CAPACITY_1_GBPS`
- `CAPACITY_2_GBPS`
- `CAPACITY_3_GBPS`
- `CAPACITY_4_GBPS`
- `CAPACITY_5_GBPS`
- `CAPACITY_10_GBPS`
- `CAPACITY_20_GBPS`
- `CAPACITY_30_GBPS`
- `CAPACITY_40_GBPS`
- `CAPACITY_50_GBPS`
- `CAPACITY_100_GBPS`
- `CAPACITY_200_GBPS` ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| deletion_protection | **bool**

Deletion protection flag.
Optional.
If set prohibits deletion of the trunkConnection. ||
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
    "trunk_connection_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "folder_id": "string",
    "region_id": "string",
    "created_at": "google.protobuf.Timestamp",
    // Includes only one of the fields `single_port_direct_joint`, `lag_direct_joint`, `partner_joint_info`
    "single_port_direct_joint": {
      "transceiver_type": "TransceiverType",
      "port_name": "google.protobuf.StringValue",
      "access_device_name": "string"
    },
    "lag_direct_joint": {
      "transceiver_type": "TransceiverType",
      "lag_allocation_settings": {
        "lag_info": {
          "lag_id": "google.protobuf.Int64Value",
          "port_names": [
            "string"
          ]
        }
      },
      "access_device_name": "string"
    },
    "partner_joint_info": {
      "service_key": "string",
      "partner_id": "google.protobuf.StringValue"
    },
    // end of the list of possible fields
    "point_of_presence_id": "google.protobuf.StringValue",
    "capacity": "Capacity",
    "labels": "map<string, string>",
    "status": "Status",
    "deletion_protection": "bool"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateTrunkConnectionMetadata](#yandex.cloud.cic.v1.UpdateTrunkConnectionMetadata)**

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
|| response | **[TrunkConnection](#yandex.cloud.cic.v1.TrunkConnection)**

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

## UpdateTrunkConnectionMetadata {#yandex.cloud.cic.v1.UpdateTrunkConnectionMetadata}

#|
||Field | Description ||
|| trunk_connection_id | **string**

ID of the TrunkConnection resource. ||
|#

## TrunkConnection {#yandex.cloud.cic.v1.TrunkConnection}

A TrunkConnection resource.

#|
||Field | Description ||
|| id | **string**

ID of the trunkConnection. ||
|| name | **string**

Name of the trunkConnection.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the trunkConnection. 0-256 characters long. ||
|| folder_id | **string**

ID of the folder that the trunkConnection belongs to. ||
|| region_id | **string**

ID of the region that the trunkConnection belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| single_port_direct_joint | **[SinglePortDirectJoint](#yandex.cloud.cic.v1.TrunkConnection.SinglePortDirectJoint)**

Includes only one of the fields `single_port_direct_joint`, `lag_direct_joint`, `partner_joint_info`.

Special trunkConnection config ||
|| lag_direct_joint | **[LagDirectJoint](#yandex.cloud.cic.v1.TrunkConnection.LagDirectJoint)**

Includes only one of the fields `single_port_direct_joint`, `lag_direct_joint`, `partner_joint_info`.

Special trunkConnection config ||
|| partner_joint_info | **[PartnerJointInfo](#yandex.cloud.cic.v1.TrunkConnection.PartnerJointInfo)**

Includes only one of the fields `single_port_direct_joint`, `lag_direct_joint`, `partner_joint_info`.

Special trunkConnection config ||
|| point_of_presence_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of pointOfPresence that the trunkConnection is deployed on.
Optional.
If is not set scheduler selects it by himself. ||
|| capacity | enum **Capacity**

Capacity of the trunkConnection

- `CAPACITY_UNSPECIFIED`
- `CAPACITY_50_MBPS`
- `CAPACITY_100_MBPS`
- `CAPACITY_200_MBPS`
- `CAPACITY_300_MBPS`
- `CAPACITY_400_MBPS`
- `CAPACITY_500_MBPS`
- `CAPACITY_1_GBPS`
- `CAPACITY_2_GBPS`
- `CAPACITY_3_GBPS`
- `CAPACITY_4_GBPS`
- `CAPACITY_5_GBPS`
- `CAPACITY_10_GBPS`
- `CAPACITY_20_GBPS`
- `CAPACITY_30_GBPS`
- `CAPACITY_40_GBPS`
- `CAPACITY_50_GBPS`
- `CAPACITY_100_GBPS`
- `CAPACITY_200_GBPS` ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| status | enum **Status**

Status of the trunkConnection.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| deletion_protection | **bool**

Optional deletion protection flag.
If set prohibits deletion of the trunkConnection. ||
|#

## SinglePortDirectJoint {#yandex.cloud.cic.v1.TrunkConnection.SinglePortDirectJoint}

Config of trunkConnection that is deployed on single port.

#|
||Field | Description ||
|| transceiver_type | enum **TransceiverType**

Type of transceiver that the trunkConnection is deployed on.

- `TRANSCEIVER_TYPE_UNSPECIFIED`
- `TRANSCEIVER_TYPE_1000BASE_LX`
- `TRANSCEIVER_TYPE_10GBASE_LR`
- `TRANSCEIVER_TYPE_10GBASE_ER`
- `TRANSCEIVER_TYPE_100GBASE_LR4`
- `TRANSCEIVER_TYPE_100GBASE_ER4` ||
|| port_name | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Name of port that the trunkConnection is deployed on. ||
|| access_device_name | **string**

Device name which is set in LLDP message. ||
|#

## LagDirectJoint {#yandex.cloud.cic.v1.TrunkConnection.LagDirectJoint}

Config of trunkConnection that is deployed on lag.

#|
||Field | Description ||
|| transceiver_type | enum **TransceiverType**

Type of transceiver that the trunkConnection is deployed on.

- `TRANSCEIVER_TYPE_UNSPECIFIED`
- `TRANSCEIVER_TYPE_1000BASE_LX`
- `TRANSCEIVER_TYPE_10GBASE_LR`
- `TRANSCEIVER_TYPE_10GBASE_ER`
- `TRANSCEIVER_TYPE_100GBASE_LR4`
- `TRANSCEIVER_TYPE_100GBASE_ER4` ||
|| lag_allocation_settings | **[LagAllocationSettings](#yandex.cloud.cic.v1.common.LagAllocationSettings)**

LAG allocation settings that the trunkConnection is deployed on. ||
|| access_device_name | **string**

Device name which is set in LLDP message. ||
|#

## LagAllocationSettings {#yandex.cloud.cic.v1.common.LagAllocationSettings}

Structure that describes LAG allocation settings

#|
||Field | Description ||
|| lag_info | **[LagInfo](#yandex.cloud.cic.v1.common.LagInfo)**

LagInfo ||
|#

## LagInfo {#yandex.cloud.cic.v1.common.LagInfo}

#|
||Field | Description ||
|| lag_id | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

ID of LAG.
Optional.
If is not set scheduler selects it by himself. ||
|| port_names[] | **string**

List of port names that the LAG is deployed on. ||
|#

## PartnerJointInfo {#yandex.cloud.cic.v1.TrunkConnection.PartnerJointInfo}

Config of trunkConnection that is deployed on partner joint.

#|
||Field | Description ||
|| service_key | **string**

Reserved for future using; ||
|| partner_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of partner that the trunkConnection is deployed on.
Optional.
If is not set scheduler selects it by himself. ||
|#