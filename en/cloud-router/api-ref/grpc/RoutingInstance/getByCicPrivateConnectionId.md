---
editable: false
sourcePath: en/_api-ref-grpc/cloudrouter/v1/api-ref/grpc/RoutingInstance/getByCicPrivateConnectionId.md
---

# Cloud Router API, gRPC: RoutingInstanceService.GetByCicPrivateConnectionId

Returns the RoutingInstance resource by cicPrivateConnectionId

To get the list of available RoutingInstance resources, make a [List](/docs/cloud-router/api-ref/grpc/RoutingInstance/list#List) request.

## gRPC request

**rpc GetByCicPrivateConnectionId ([GetRoutingInstanceByCicPrivateConnectionIdRequest](#yandex.cloud.cloudrouter.v1.GetRoutingInstanceByCicPrivateConnectionIdRequest)) returns ([RoutingInstance](#yandex.cloud.cloudrouter.v1.RoutingInstance))**

## GetRoutingInstanceByCicPrivateConnectionIdRequest {#yandex.cloud.cloudrouter.v1.GetRoutingInstanceByCicPrivateConnectionIdRequest}

```json
{
  "cic_private_connection_id": "string"
}
```

#|
||Field | Description ||
|| cic_private_connection_id | **string**

Required field. ID of the PrivateConnection resource to return by.
To get the routingInstance ID use a [RoutingInstanceService.List](/docs/cloud-router/api-ref/grpc/RoutingInstance/list#List) request. ||
|#

## RoutingInstance {#yandex.cloud.cloudrouter.v1.RoutingInstance}

```json
{
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
```

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