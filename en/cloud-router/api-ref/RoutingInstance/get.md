---
editable: false
apiPlayground:
  - url: https://cloudrouter.{{ api-host }}/cloudrouter/v1/routingInstances/{routingInstanceId}
    method: get
    path:
      type: object
      properties:
        routingInstanceId:
          description: |-
            **string**
            Required field. ID of the RoutingInstance resource to return.
            To get the routingInstance ID use a [RoutingInstanceService.List](/docs/cloud-router/api-ref/RoutingInstance/list#List) request.
          type: string
      required:
        - routingInstanceId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/cloudrouter/v1/api-ref/RoutingInstance/get.md
---

# Cloud Router API, REST: RoutingInstance.Get

Returns the specified RoutingInstance resource.

To get the list of available RoutingInstance resources, make a [List](/docs/cloud-router/api-ref/RoutingInstance/list#List) request.

## HTTP request

```
GET https://cloudrouter.{{ api-host }}/cloudrouter/v1/routingInstances/{routingInstanceId}
```

## Path parameters

#|
||Field | Description ||
|| routingInstanceId | **string**

Required field. ID of the RoutingInstance resource to return.
To get the routingInstance ID use a [RoutingInstanceService.List](/docs/cloud-router/api-ref/RoutingInstance/list#List) request. ||
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

Optional description of the routingInstance. 0-256 characters long. ||
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

- `STATUS_UNSPECIFIED`
- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
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

ID of the vpcNetwork that is attached to the routingInstance. ||
|| azInfos[] | **[VpcAzInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo)**

List of the az-related info about vpcNetworks which are attached to routingInstance ||
|#

## VpcAzInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo}

#|
||Field | Description ||
|| manualInfo | **[VpcManualInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo)**

VpcInfo which is set by user ||
|#

## VpcManualInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo}

#|
||Field | Description ||
|| azId | **string**

ID of the AZ ||
|| prefixes[] | **string**

List of prefixes to announce ||
|#

## CicPrivateConnectionInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo}

#|
||Field | Description ||
|| cicPrivateConnectionId | **string**

ID of the cicPrivateConnection that is attached to the routingInstance. ||
|#