---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/TrunkConnection/get.md
---

# Cloud Interconnect API, gRPC: TrunkConnectionService.Get {#Get}

Returns the specified TrunkConnection resource.

To get the list of available TrunkConnection resources, make a [List](/docs/cic/workload/api-ref/grpc/TrunkConnection/list#List) request.

## gRPC request

**rpc Get ([GetTrunkConnectionRequest](#yandex.cloud.cic.v1.GetTrunkConnectionRequest)) returns ([TrunkConnection](#yandex.cloud.cic.v1.TrunkConnection))**

## GetTrunkConnectionRequest {#yandex.cloud.cic.v1.GetTrunkConnectionRequest}

```json
{
  "trunkConnectionId": "string"
}
```

#|
||Field | Description ||
|| trunkConnectionId | **string**

Required field. ID of the TrunkConnection resource to return.
To get the trunkConnection ID use a [TrunkConnectionService.List](/docs/cic/workload/api-ref/grpc/TrunkConnection/list#List) request. ||
|#

## TrunkConnection {#yandex.cloud.cic.v1.TrunkConnection}

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folderId": "string",
  "regionId": "string",
  // Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`
  "singlePortDirectJoint": {
    "transceiverType": "TransceiverType",
    "portName": "google.protobuf.StringValue",
    "accessDeviceName": "string"
  },
  "lagDirectJoint": {
    "transceiverType": "TransceiverType",
    "lagAllocationSettings": {
      "lagInfo": {
        "lagId": "google.protobuf.Int64Value",
        "portNames": [
          "string"
        ]
      }
    },
    "accessDeviceName": "string"
  },
  "partnerJointInfo": {
    "serviceKey": "string",
    "partnerId": "google.protobuf.StringValue"
  },
  // end of the list of possible fields
  "pointOfPresenceId": "google.protobuf.StringValue",
  "capacity": "Capacity",
  "labels": "string"
}
```

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
|| folderId | **string**

ID of the folder that the trunkConnection belongs to. ||
|| regionId | **string**

ID of the region that the trunkConnection belongs to. ||
|| singlePortDirectJoint | **[SinglePortDirectJoint](#yandex.cloud.cic.v1.TrunkConnection.SinglePortDirectJoint)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| lagDirectJoint | **[LagDirectJoint](#yandex.cloud.cic.v1.TrunkConnection.LagDirectJoint)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| partnerJointInfo | **[PartnerJointInfo](#yandex.cloud.cic.v1.TrunkConnection.PartnerJointInfo)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| pointOfPresenceId | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

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
- `CAPACITY_100_GBPS` ||
|| labels | **string**

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|#

## SinglePortDirectJoint {#yandex.cloud.cic.v1.TrunkConnection.SinglePortDirectJoint}

Config of trunkConnection that is deployed on single port.

#|
||Field | Description ||
|| transceiverType | enum **TransceiverType**

Type of transceiver that the trunkConnection is deployed on.

- `TRANSCEIVER_TYPE_UNSPECIFIED`
- `TRANSCEIVER_TYPE_1000BASE_LX`
- `TRANSCEIVER_TYPE_10GBASE_LR`
- `TRANSCEIVER_TYPE_10GBASE_ER`
- `TRANSCEIVER_TYPE_100GBASE_LR4`
- `TRANSCEIVER_TYPE_100GBASE_ER4` ||
|| portName | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Name of port that the trunkConnection is deployed on. ||
|| accessDeviceName | **string**

Device name which is set in LLDP message. ||
|#

## LagDirectJoint {#yandex.cloud.cic.v1.TrunkConnection.LagDirectJoint}

Config of trunkConnection that is deployed on lag.

#|
||Field | Description ||
|| transceiverType | enum **TransceiverType**

Type of transceiver that the trunkConnection is deployed on.

- `TRANSCEIVER_TYPE_UNSPECIFIED`
- `TRANSCEIVER_TYPE_1000BASE_LX`
- `TRANSCEIVER_TYPE_10GBASE_LR`
- `TRANSCEIVER_TYPE_10GBASE_ER`
- `TRANSCEIVER_TYPE_100GBASE_LR4`
- `TRANSCEIVER_TYPE_100GBASE_ER4` ||
|| lagAllocationSettings | **[LagAllocationSettings](#yandex.cloud.cic.v1.common.LagAllocationSettings)**

LAG allocation settings that the trunkConnection is deployed on. ||
|| accessDeviceName | **string**

Device name which is set in LLDP message. ||
|#

## LagAllocationSettings {#yandex.cloud.cic.v1.common.LagAllocationSettings}

Structure that describes LAG allocation settings

#|
||Field | Description ||
|| lagInfo | **[LagInfo](#yandex.cloud.cic.v1.common.LagInfo)**

LagInfo ||
|#

## LagInfo {#yandex.cloud.cic.v1.common.LagInfo}

#|
||Field | Description ||
|| lagId | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

ID of LAG.
Optional.
If is not set scheduler selects it by himself. ||
|| portNames[] | **string**

List of port names that the LAG is deployed on. ||
|#

## PartnerJointInfo {#yandex.cloud.cic.v1.TrunkConnection.PartnerJointInfo}

Config of trunkConnection that is deployed on partner joint.

#|
||Field | Description ||
|| serviceKey | **string**

Reserved for future using; ||
|| partnerId | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of partner that the trunkConnection is deployed on.
Optional.
If is not set scheduler selects it by himself. ||
|#