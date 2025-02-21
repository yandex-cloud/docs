---
editable: false
sourcePath: en/_api-ref/cic/v1/api-ref/TrunkConnection/create.md
---

# Cloud Interconnect API, REST: TrunkConnection.Create

Creates a TrunkConnection resource in the specified folder using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
POST https://cic.{{ api-host }}/cic/v1/trunkConnections
```

## Body parameters {#yandex.cloud.cic.v1.CreateTrunkConnectionRequest}

```json
{
  "name": "string",
  "description": "string",
  "folderId": "string",
  "regionId": "string",
  // Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`
  "singlePortDirectJoint": {
    "transceiverType": "string"
  },
  "lagDirectJoint": {
    "transceiverType": "string"
  },
  "partnerJointInfo": {
    "partnerId": "string"
  },
  // end of the list of possible fields
  "pointOfPresenceId": "string",
  "capacity": "string",
  "labels": "object",
  "deletionProtection": "boolean"
}
```

#|
||Field | Description ||
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
|| singlePortDirectJoint | **[SinglePortDirectJoint](#yandex.cloud.cic.v1.CreateTrunkConnectionRequest.SinglePortDirectJoint)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| lagDirectJoint | **[LagDirectJoint](#yandex.cloud.cic.v1.CreateTrunkConnectionRequest.LagDirectJoint)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| partnerJointInfo | **[PartnerJoint](#yandex.cloud.cic.v1.CreateTrunkConnectionRequest.PartnerJoint)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| pointOfPresenceId | **string**

ID of pointOfPresence that the trunkConnection is deployed on.
Optional.
If is not set scheduler selects it by himself. ||
|| capacity | **enum** (Capacity)

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
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| deletionProtection | **boolean**

Deletion protection flag.
Optional.
If set prohibits deletion of the trunkConnection. ||
|#

## SinglePortDirectJoint {#yandex.cloud.cic.v1.CreateTrunkConnectionRequest.SinglePortDirectJoint}

Config of trunkConnection that is deployed on single port.

#|
||Field | Description ||
|| transceiverType | **enum** (TransceiverType)

Type of transceiver that the trunkConnection is deployed on.

- `TRANSCEIVER_TYPE_UNSPECIFIED`
- `TRANSCEIVER_TYPE_1000BASE_LX`
- `TRANSCEIVER_TYPE_10GBASE_LR`
- `TRANSCEIVER_TYPE_10GBASE_ER`
- `TRANSCEIVER_TYPE_100GBASE_LR4`
- `TRANSCEIVER_TYPE_100GBASE_ER4` ||
|#

## LagDirectJoint {#yandex.cloud.cic.v1.CreateTrunkConnectionRequest.LagDirectJoint}

Config of trunkConnection that is deployed on lag.

#|
||Field | Description ||
|| transceiverType | **enum** (TransceiverType)

Type of transceiver that the trunkConnection is deployed on.

- `TRANSCEIVER_TYPE_UNSPECIFIED`
- `TRANSCEIVER_TYPE_1000BASE_LX`
- `TRANSCEIVER_TYPE_10GBASE_LR`
- `TRANSCEIVER_TYPE_10GBASE_ER`
- `TRANSCEIVER_TYPE_100GBASE_LR4`
- `TRANSCEIVER_TYPE_100GBASE_ER4` ||
|#

## PartnerJoint {#yandex.cloud.cic.v1.CreateTrunkConnectionRequest.PartnerJoint}

Config of trunkConnection that is deployed on partner joint.

#|
||Field | Description ||
|| partnerId | **string**

ID of partner that the trunkConnection is deployed on.
Optional.
If is not set scheduler selects it by himself. ||
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
    "trunkConnectionId": "string"
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
    "name": "string",
    "description": "string",
    "folderId": "string",
    "regionId": "string",
    "createdAt": "string",
    // Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`
    "singlePortDirectJoint": {
      "transceiverType": "string",
      "portName": "string",
      "accessDeviceName": "string"
    },
    "lagDirectJoint": {
      "transceiverType": "string",
      "lagAllocationSettings": {
        "lagInfo": {
          "lagId": "string",
          "portNames": [
            "string"
          ]
        }
      },
      "accessDeviceName": "string"
    },
    "partnerJointInfo": {
      "serviceKey": "string",
      "partnerId": "string"
    },
    // end of the list of possible fields
    "pointOfPresenceId": "string",
    "capacity": "string",
    "labels": "object",
    "status": "string",
    "deletionProtection": "boolean"
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
|| metadata | **[CreateTrunkConnectionMetadata](#yandex.cloud.cic.v1.CreateTrunkConnectionMetadata)**

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

## CreateTrunkConnectionMetadata {#yandex.cloud.cic.v1.CreateTrunkConnectionMetadata}

#|
||Field | Description ||
|| trunkConnectionId | **string**

ID of the TrunkConnection resource. ||
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
|| folderId | **string**

ID of the folder that the trunkConnection belongs to. ||
|| regionId | **string**

ID of the region that the trunkConnection belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| singlePortDirectJoint | **[SinglePortDirectJoint](#yandex.cloud.cic.v1.TrunkConnection.SinglePortDirectJoint)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| lagDirectJoint | **[LagDirectJoint](#yandex.cloud.cic.v1.TrunkConnection.LagDirectJoint)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| partnerJointInfo | **[PartnerJointInfo](#yandex.cloud.cic.v1.TrunkConnection.PartnerJointInfo)**

Includes only one of the fields `singlePortDirectJoint`, `lagDirectJoint`, `partnerJointInfo`.

Special trunkConnection config ||
|| pointOfPresenceId | **string**

ID of pointOfPresence that the trunkConnection is deployed on.
Optional.
If is not set scheduler selects it by himself. ||
|| capacity | **enum** (Capacity)

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
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| status | **enum** (Status)

Status of the trunkConnection.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| deletionProtection | **boolean**

Optional deletion protection flag.
If set prohibits deletion of the trunkConnection. ||
|#

## SinglePortDirectJoint {#yandex.cloud.cic.v1.TrunkConnection.SinglePortDirectJoint}

Config of trunkConnection that is deployed on single port.

#|
||Field | Description ||
|| transceiverType | **enum** (TransceiverType)

Type of transceiver that the trunkConnection is deployed on.

- `TRANSCEIVER_TYPE_UNSPECIFIED`
- `TRANSCEIVER_TYPE_1000BASE_LX`
- `TRANSCEIVER_TYPE_10GBASE_LR`
- `TRANSCEIVER_TYPE_10GBASE_ER`
- `TRANSCEIVER_TYPE_100GBASE_LR4`
- `TRANSCEIVER_TYPE_100GBASE_ER4` ||
|| portName | **string**

Name of port that the trunkConnection is deployed on. ||
|| accessDeviceName | **string**

Device name which is set in LLDP message. ||
|#

## LagDirectJoint {#yandex.cloud.cic.v1.TrunkConnection.LagDirectJoint}

Config of trunkConnection that is deployed on lag.

#|
||Field | Description ||
|| transceiverType | **enum** (TransceiverType)

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
|| lagId | **string** (int64)

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
|| partnerId | **string**

ID of partner that the trunkConnection is deployed on.
Optional.
If is not set scheduler selects it by himself. ||
|#