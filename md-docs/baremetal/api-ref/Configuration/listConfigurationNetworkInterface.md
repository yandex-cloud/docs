[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > [REST (англ.)](../index.md) > [Configuration](index.md) > ListConfigurationNetworkInterface

# BareMetal API, REST: Configuration.ListConfigurationNetworkInterface


ConfigurationNetworkInterface is not a resource. --)
Retrieves the list of ConfigurationNetworkInterface resources.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/configurationNetworkInterfaces
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list ConfigurationNetworkInterface resources in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListConfigurationNetworkInterfaceResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigurationNetworkInterfaceResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceResponse) returned by a previous list request. ||
|| orderBy | **string**

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

## Response {#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceResponse}

**HTTP Code: 200 - OK**

```json
{
  "configurationNetworkInterfaces": [
    {
      "id": "string",
      "name": "string",
      "configurationId": "string",
      "linkSpeedGbps": "string",
      "availableModes": [
        "string"
      ],
      "mcLagOptions": {
        "interfaceCount": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| configurationNetworkInterfaces[] | **[ConfigurationNetworkInterface](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface)**

List of ConfigurationNetworkInterface resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListConfigurationNetworkInterfaceRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceRequest), use `next_page_token` as the value
for the [ListConfigurationNetworkInterfaceRequest.pageToken](#yandex.cloud.baremetal.v1alpha.ListConfigurationNetworkInterfaceRequest) parameter in the next list request.

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
|| configurationId | **string**

Id of the configuration ||
|| linkSpeedGbps | **string** (int64)

Link speed in gigabits per second ||
|| availableModes[] | **enum** (InterfaceMode)

Available modes for the network interface

- `PRIVATE`: Private network interface mode.
- `PUBLIC`: Public network interface mode. ||
|| mcLagOptions | **[MCLagAggregationOptions](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions)**

MC-LAG configuration options for aggregated interfaces ||
|#

## MCLagAggregationOptions {#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions}

MC-LAG aggregation options for the network interface.

#|
||Field | Description ||
|| interfaceCount | **string** (int64)

Number of interfaces in the MC-LAG aggregation. ||
|#