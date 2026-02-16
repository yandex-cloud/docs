---
editable: false
sourcePath: en/_api-ref-grpc/cloudrouter/v1/api-ref/grpc/RoutingInstance/list.md
---

# Cloud Router API, gRPC: RoutingInstanceService.List

Retrieves the list of RoutingInstance resources in the specified folder.

## gRPC request

**rpc List ([ListRoutingInstancesRequest](#yandex.cloud.cloudrouter.v1.ListRoutingInstancesRequest)) returns ([ListRoutingInstancesResponse](#yandex.cloud.cloudrouter.v1.ListRoutingInstancesResponse))**

## ListRoutingInstancesRequest {#yandex.cloud.cloudrouter.v1.ListRoutingInstancesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list RoutingInstance resources.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListRoutingInstancesResponse.next_page_token](#yandex.cloud.cloudrouter.v1.ListRoutingInstancesResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListRoutingInstanceResponse.next_page_token] returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [RoutingInstance.name](#yandex.cloud.cloudrouter.v1.RoutingInstance) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListRoutingInstancesResponse {#yandex.cloud.cloudrouter.v1.ListRoutingInstancesResponse}

```json
{
  "routing_instances": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| routing_instances[] | **[RoutingInstance](#yandex.cloud.cloudrouter.v1.RoutingInstance)**

List of RoutingInstance resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRoutingInstancesResponse.page_size], use
the `next_page_token` as the value
for the [ListRoutingInstanceResponses.page_token] query parameter
in the next list request. Subsequent list requests will have their own
`next_page_token` to continue paging through the results. ||
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