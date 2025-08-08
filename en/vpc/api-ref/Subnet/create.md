---
editable: false
apiPlayground:
  - url: https://vpc.{{ api-host }}/vpc/v1/subnets
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a subnet in.
            To get folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the subnet.
            The name must be unique within the folder.
          pattern: '|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the subnet.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels, `` key:value `` pairs.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        networkId:
          description: |-
            **string**
            Required field. ID of the network to create subnet in.
          type: string
        zoneId:
          description: |-
            **string**
            Required field. ID of the availability zone where the subnet resides.
            To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
          type: string
        v4CidrBlocks:
          description: "**string**\nRequired field. CIDR block.\nThe range of internal addresses that are defined for this subnet.\nFor example,\_10.0.0.0/22\_or\_192.168.0.0/24.\nMinimum subnet size is /28, maximum subnet size is /16."
          type: array
          items:
            type: string
        routeTableId:
          description: |-
            **string**
            ID of route table the subnet is linked to.
          type: string
        dhcpOptions:
          description: '**[DhcpOptions](/docs/vpc/api-ref/Network/listSubnets#yandex.cloud.vpc.v1.DhcpOptions)**'
          $ref: '#/definitions/DhcpOptions'
      required:
        - folderId
        - networkId
        - zoneId
        - v4CidrBlocks
      additionalProperties: false
    definitions:
      DhcpOptions:
        type: object
        properties:
          domainNameServers:
            description: |-
              **string**
              A list of DHCP servers for this subnet.
            type: array
            items:
              type: string
          domainName:
            description: |-
              **string**
              A domain name to us as a suffix when resolving host names in this subnet.
            type: string
          ntpServers:
            description: |-
              **string**
              List of NTP servers for this subnet.
            type: array
            items:
              type: string
sourcePath: en/_api-ref/vpc/v1/api-ref/Subnet/create.md
---

# Virtual Private Cloud API, REST: Subnet.Create

Creates a subnet in the specified folder and network.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
POST https://vpc.{{ api-host }}/vpc/v1/subnets
```

## Body parameters {#yandex.cloud.vpc.v1.CreateSubnetRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "zoneId": "string",
  "v4CidrBlocks": [
    "string"
  ],
  "routeTableId": "string",
  "dhcpOptions": {
    "domainNameServers": [
      "string"
    ],
    "domainName": "string",
    "ntpServers": [
      "string"
    ]
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a subnet in.
To get folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the subnet.
The name must be unique within the folder. ||
|| description | **string**

Description of the subnet. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `` key:value `` pairs. ||
|| networkId | **string**

Required field. ID of the network to create subnet in. ||
|| zoneId | **string**

Required field. ID of the availability zone where the subnet resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| v4CidrBlocks[] | **string**

Required field. CIDR block.
The range of internal addresses that are defined for this subnet.
For example, 10.0.0.0/22 or 192.168.0.0/24.
Minimum subnet size is /28, maximum subnet size is /16. ||
|| routeTableId | **string**

ID of route table the subnet is linked to. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.vpc.v1.DhcpOptions)** ||
|#

## DhcpOptions {#yandex.cloud.vpc.v1.DhcpOptions}

#|
||Field | Description ||
|| domainNameServers[] | **string**

A list of DHCP servers for this subnet. ||
|| domainName | **string**

A domain name to us as a suffix when resolving host names in this subnet. ||
|| ntpServers[] | **string**

List of NTP servers for this subnet. ||
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
    "subnetId": "string"
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
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "networkId": "string",
    "zoneId": "string",
    "v4CidrBlocks": [
      "string"
    ],
    "v6CidrBlocks": [
      "string"
    ],
    "routeTableId": "string",
    "dhcpOptions": {
      "domainNameServers": [
        "string"
      ],
      "domainName": "string",
      "ntpServers": [
        "string"
      ]
    }
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
|| metadata | **[CreateSubnetMetadata](#yandex.cloud.vpc.v1.CreateSubnetMetadata)**

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
|| response | **[Subnet](#yandex.cloud.vpc.v1.Subnet)**

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

## CreateSubnetMetadata {#yandex.cloud.vpc.v1.CreateSubnetMetadata}

#|
||Field | Description ||
|| subnetId | **string**

ID of the subnet that is being created. ||
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

## Subnet {#yandex.cloud.vpc.v1.Subnet}

A Subnet resource. For more information, see [Subnets](/docs/vpc/concepts/network#subnet).

#|
||Field | Description ||
|| id | **string**

ID of the subnet. ||
|| folderId | **string**

ID of the folder that the subnet belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the subnet.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the subnet. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| networkId | **string**

ID of the network the subnet belongs to. ||
|| zoneId | **string**

ID of the availability zone where the subnet resides. ||
|| v4CidrBlocks[] | **string**

CIDR block.
The range of internal addresses that are defined for this subnet.
This field can be set only at Subnet resource creation time and cannot be changed.
For example, 10.0.0.0/22 or 192.168.0.0/24.
Minimum subnet size is /28, maximum subnet size is /16. ||
|| v6CidrBlocks[] | **string**

IPv6 not available yet. ||
|| routeTableId | **string**

ID of route table the subnet is linked to. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.vpc.v1.DhcpOptions2)**

DHCP options for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.vpc.v1.DhcpOptions2}

#|
||Field | Description ||
|| domainNameServers[] | **string**

A list of DHCP servers for this subnet. ||
|| domainName | **string**

A domain name to us as a suffix when resolving host names in this subnet. ||
|| ntpServers[] | **string**

List of NTP servers for this subnet. ||
|#