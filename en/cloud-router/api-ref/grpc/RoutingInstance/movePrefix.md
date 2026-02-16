---
editable: false
sourcePath: en/_api-ref-grpc/cloudrouter/v1/api-ref/grpc/RoutingInstance/movePrefix.md
---

# Cloud Router API, gRPC: RoutingInstanceService.MovePrefix

Moves the specified prefix between availability zones of the RoutingInstance.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc MovePrefix ([MovePrefixRequest](#yandex.cloud.cloudrouter.v1.MovePrefixRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## MovePrefixRequest {#yandex.cloud.cloudrouter.v1.MovePrefixRequest}

```json
{
  "routing_instance_id": "string",
  "src_vpc_network_id": "string",
  "src_az_id": "string",
  "dst_vpc_network_id": "string",
  "dst_az_id": "string",
  "prefix": "string"
}
```

#|
||Field | Description ||
|| routing_instance_id | **string**

Required field. ID of the RoutingInstance resource. ||
|| src_vpc_network_id | **string**

ID of the source VpcNetwork. ||
|| src_az_id | **string**

ID of the AZ in the source VpcNetwork. ||
|| dst_vpc_network_id | **string**

ID of the destination VpcNetwork. ||
|| dst_az_id | **string**

ID of the AZ in the destination VpcNetwork. ||
|| prefix | **string**

Prefix to move. ||
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
    "routing_instance_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "folder_id": "string",
    "region_id": "string",
    "vpc_info": [
      {
        "vpc_network_id": "string",
        "az_infos": [
          {
            "manual_info": {
              "az_id": "string",
              "prefixes": [
                "string"
              ]
            }
          }
        ]
      }
    ],
    "cic_private_connection_info": [
      {
        "cic_private_connection_id": "string"
      }
    ],
    "status": "Status",
    "created_at": "google.protobuf.Timestamp",
    "labels": "map<string, string>"
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
|| metadata | **[UpdateRoutingInstanceMetadata](#yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata)**

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
|| response | **[RoutingInstance](#yandex.cloud.cloudrouter.v1.RoutingInstance)**

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

## UpdateRoutingInstanceMetadata {#yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata}

#|
||Field | Description ||
|| routing_instance_id | **string**

ID of the RoutingInstance resource. ||
|#

## RoutingInstance {#yandex.cloud.cloudrouter.v1.RoutingInstance}

#|
||Field | Description ||
|| id | **string**

ID of the routingInstance. ||
|| name | **string**

Name of the routingInstance.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the routingInstance. 0-256 characters long. ||
|| folder_id | **string**

ID of the folder that the routingInstance belongs to. ||
|| region_id | **string**

ID of the region that the routingInstance belongs to. ||
|| vpc_info[] | **[VpcInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo)**

List of the info about vpcNetworks which are attached to routingInstance. ||
|| cic_private_connection_info[] | **[CicPrivateConnectionInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo)**

List of the info about privateConnections which are attached to routingInstance. ||
|| status | enum **Status**

Status of the routingInstance.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|#

## VpcInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo}

#|
||Field | Description ||
|| vpc_network_id | **string**

ID of the vpcNetwork that is attached to the routingInstance. ||
|| az_infos[] | **[VpcAzInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo)**

List of the az-related info about vpcNetworks which are attached to routingInstance ||
|#

## VpcAzInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo}

#|
||Field | Description ||
|| manual_info | **[VpcManualInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo)**

VpcInfo which is set by user ||
|#

## VpcManualInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo}

#|
||Field | Description ||
|| az_id | **string**

ID of the AZ ||
|| prefixes[] | **string**

List of prefixes to announce ||
|#

## CicPrivateConnectionInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo}

#|
||Field | Description ||
|| cic_private_connection_id | **string**

ID of the cicPrivateConnection that is attached to the routingInstance. ||
|#