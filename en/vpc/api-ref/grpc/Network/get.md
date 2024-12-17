---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Network/get.md
---

# Virtual Private Cloud API, gRPC: NetworkService.Get

Returns the specified Network resource.

Get the list of available Network resources by making a [List](/docs/vpc/api-ref/grpc/Network/list#List) request.

## gRPC request

**rpc Get ([GetNetworkRequest](#yandex.cloud.vpc.v1.GetNetworkRequest)) returns ([Network](#yandex.cloud.vpc.v1.Network))**

## GetNetworkRequest {#yandex.cloud.vpc.v1.GetNetworkRequest}

```json
{
  "network_id": "string"
}
```

#|
||Field | Description ||
|| network_id | **string**

Required field. ID of the Network resource to return.
To get the network ID, use a [NetworkService.List](/docs/vpc/api-ref/grpc/Network/list#List) request. ||
|#

## Network {#yandex.cloud.vpc.v1.Network}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "default_security_group_id": "string"
}
```

A Network resource. For more information, see [Networks](/docs/vpc/concepts/network).

#|
||Field | Description ||
|| id | **string**

ID of the network. ||
|| folder_id | **string**

ID of the folder that the network belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the network.
The name is unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the network. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| default_security_group_id | **string**

ID of default security group for network. ||
|#