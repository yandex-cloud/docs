---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/publicSubnets
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to list public subnets in.
            To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListPublicSubnetResponse.nextPageToken](/docs/baremetal/api-ref/PublicSubnet/list#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListPublicSubnetResponse.nextPageToken](/docs/baremetal/api-ref/PublicSubnet/list#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse) returned by a previous list request.
          type: string
        orderBy:
          description: |-
            **string**
            By which column the listing should be ordered and in which direction,
            format is "createdAt desc". "id asc" if omitted.
            Supported fields: ["id", "name", "createdAt"].
            Both snake_case and camelCase are supported for fields.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.
            Each condition has the form `<field> <operator> <value>`, where:
            1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
            2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring), `@>` (contains).
            3. `<value>` represents a value.
            String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
            Example: "key1='value' AND key2='value'"
            Supported operators: ["AND"].
            Supported fields: ["id", "name", "zoneId", "hardwarePoolIds"].
            Deprecated fields: ["hardwarePoolId"].
            Both snake_case and camelCase are supported for fields.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/PublicSubnet/list.md
---

# BareMetal API, REST: PublicSubnet.List

Retrieves the list of PublicSubnet resources in the specified folder.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/publicSubnets
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListPublicSubnetRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list public subnets in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPublicSubnetResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicSubnetResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse) returned by a previous list request. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "name", "createdAt"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring), `@>` (contains).
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["id", "name", "zoneId", "hardwarePoolIds"].
Deprecated fields: ["hardwarePoolId"].
Both snake_case and camelCase are supported for fields. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse}

**HTTP Code: 200 - OK**

```json
{
  "publicSubnets": [
    {
      "id": "string",
      "cloudId": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "zoneId": "string",
      "hardwarePoolIds": [
        "string"
      ],
      "type": "string",
      "prefixLength": "string",
      "cidr": "string",
      "dhcpOptions": {
        "startIp": "string",
        "endIp": "string"
      },
      "gatewayIp": "string",
      "createdAt": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| publicSubnets[] | **[PublicSubnet](#yandex.cloud.baremetal.v1alpha.PublicSubnet)**

List of PublicSubnet resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPublicSubnetRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetRequest), use `next_page_token` as the value
for the [ListPublicSubnetRequest.pageToken](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PublicSubnet {#yandex.cloud.baremetal.v1alpha.PublicSubnet}

A PublicSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the public subnet. ||
|| cloudId | **string**

ID of the cloud that the public subnet belongs to. ||
|| folderId | **string**

ID of the folder that the public subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the public subnet. ||
|| zoneId | **string**

ID of the availability zone where the server resides. ||
|| hardwarePoolIds[] | **string**

IDs of the hardware pool that the public subnet belongs to. ||
|| type | **enum** (PublicSubnetType)

Type of the public subnet (static or ephemeral).

- `PUBLIC_SUBNET_TYPE_UNSPECIFIED`: Unspecified public subnet type.
- `DEDICATED`: Dedicated public subnet.
- `EPHEMERAL`: Ephemeral public subnet. ||
|| prefixLength | **string** (int64)

Prefix length of the public subnet CIDR block. ||
|| cidr | **string**

CIDR block for the public subnet. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the public subnet. ||
|| gatewayIp | **string**

Gateway IP address for the public subnet. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v1alpha.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| startIp | **string**

Start IP address of the DHCP range (inclusive). ||
|| endIp | **string**

End IP address of the DHCP range (inclusive). ||
|#