# Cloud Router API, REST: RoutingInstance.GetByCicPrivateConnectionId

Returns the RoutingInstance resource by cicPrivateConnectionId
To get the list of available RoutingInstance resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://cloudrouter.api.cloud.yandex.net/cloudrouter/v1/routingInstances/getByCicPrivateConnectionId/{cicPrivateConnectionId}
```

## Path parameters

#|
||Field | Description ||
|| cicPrivateConnectionId | **string**

Required field. ID of the PrivateConnection resource to return by.
To get the routingInstance ID use a [RoutingInstanceService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.cloudrouter.v1.RoutingInstance}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folderId": "string",
  "regionId": "string",
  "vpcInfo": [
    {
      "vpcNetworkId": "string",
      "azInfos": [
        {
          "manualInfo": {
            "azId": "string",
            "prefixes": [
              "string"
            ]
          }
        }
      ]
    }
  ],
  "cicPrivateConnectionInfo": [
    {
      "cicPrivateConnectionId": "string"
    }
  ],
  "status": "string",
  "deletionProtection": "boolean",
  "createdAt": "string",
  "labels": "object"
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

Description of the routingInstance. 0-256 characters long. ||
|| folderId | **string**

ID of the folder that the routingInstance belongs to. ||
|| regionId | **string**

ID of the region that the routingInstance belongs to. ||
|| vpcInfo[] | **[VpcInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo)**

List of the info about vpcNetworks which are attached to routingInstance. ||
|| cicPrivateConnectionInfo[] | **[CicPrivateConnectionInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo)**

List of the info about privateConnections which are attached to routingInstance. ||
|| status | **enum** (Status)

Status of the routingInstance.

- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| deletionProtection | **boolean** ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| vpcNetworkId | **string**

Required field. ID of the vpcNetwork that is attached to the routingInstance.

The maximum string length in characters is 50. ||
|| azInfos[] | **[VpcAzInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo)**

List of the az-related info about vpcNetworks which are attached to routingInstance

The number of elements must be in the range 0-50. ||
|#

## VpcAzInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo}

#|
||Field | Description ||
|| manualInfo | **[VpcManualInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo)**

Required field. VpcInfo which is set by user ||
|#

## VpcManualInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo}

#|
||Field | Description ||
|| azId | **string**

Required field. ID of the AZ

The maximum string length in characters is 50. ||
|| prefixes[] | **string**

List of prefixes to announce

The number of elements must be in the range 0-10000. ||
|#

## CicPrivateConnectionInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo}

#|
||Field | Description ||
|| cicPrivateConnectionId | **string**

Required field. ID of the cicPrivateConnection that is attached to the routingInstance.

The maximum string length in characters is 50. ||
|#