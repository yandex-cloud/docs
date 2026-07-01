---
editable: false
---

# BareMetal API, gRPC: ConfigurationService.ListConfigurationNetworkInterface


ConfigurationNetworkInterface is not a resource. --)
Retrieves the list of ConfigurationNetworkInterface resources.

## gRPC request

**rpc ListConfigurationNetworkInterface ([ListConfigurationNetworkInterfaceRequest](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceRequest)) returns ([ListConfigurationNetworkInterfaceResponse](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceResponse))**

## ListConfigurationNetworkInterfaceRequest {#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list ConfigurationNetworkInterface resources in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListConfigurationNetworkInterfaceResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigurationNetworkInterfaceResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceResponse) returned by a previous list request. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "name"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` (or `and`) operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.
Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring).
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["id", "name", "configurationId"].
Both snake_case and camelCase are supported for fields. ||
|#

## ListConfigurationNetworkInterfaceResponse {#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceResponse}

```json
{
  "configuration_network_interfaces": [
    {
      "id": "string",
      "name": "string",
      "configuration_id": "string",
      "link_speed_gbps": "int64",
      "available_modes": [
        "InterfaceMode"
      ],
      "mc_lag_options": {
        "interface_count": "int64"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| configuration_network_interfaces[] | **[ConfigurationNetworkInterface](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface)**

List of ConfigurationNetworkInterface resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListConfigurationNetworkInterfaceRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceRequest), use `next_page_token` as the value
for the [ListConfigurationNetworkInterfaceRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## ConfigurationNetworkInterface {#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface}

#|
||Field | Description ||
|| id | **string**

Id of the network interface
Not used while creating interfaces ||
|| name | **string**

Name of the network interface ||
|| configuration_id | **string**

Id of the configuration ||
|| link_speed_gbps | **int64**

Link speed in gigabits per second ||
|| available_modes[] | enum **InterfaceMode**

Available modes for the network interface

- `PRIVATE`: Private network interface mode.
- `PUBLIC`: Public network interface mode. ||
|| mc_lag_options | **[MCLagAggregationOptions](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions)**

MC-LAG configuration options for aggregated interfaces ||
|#

## MCLagAggregationOptions {#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions}

MC-LAG aggregation options for the network interface.

#|
||Field | Description ||
|| interface_count | **int64**

Number of interfaces in the MC-LAG aggregation. ||
|#