---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Network/listSecurityGroups.md
---

# Virtual Private Cloud API, REST: Network.ListSecurityGroups {#ListSecurityGroups}

Lists security groups from the specified network.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/networks/{networkId}/security_groups
```

## Path parameters

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the Network resource to list security groups for. ||
|#

## Query parameters {#yandex.cloud.vpc.v1.ListNetworkSecurityGroupsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`,
the service returns a [ListNetworkSecurityGroupsResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkSecurityGroupsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListNetworkSecurityGroupsResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkSecurityGroupsResponse)
returned by a previous list request to get the next page of results. ||
|#

## Response {#yandex.cloud.vpc.v1.ListNetworkSecurityGroupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "securityGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "networkId": "string",
      "status": "string",
      "rules": [
        {
          "id": "string",
          "description": "string",
          "labels": "string",
          "direction": "string",
          "ports": {
            "fromPort": "string",
            "toPort": "string"
          },
          "protocolName": "string",
          "protocolNumber": "string",
          // Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`
          "cidrBlocks": {
            "v4CidrBlocks": [
              "string"
            ],
            "v6CidrBlocks": [
              "string"
            ]
          },
          "securityGroupId": "string",
          "predefinedTarget": "string"
          // end of the list of possible fields
        }
      ],
      "defaultForNetwork": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| securityGroups[] | **[SecurityGroup](#yandex.cloud.vpc.v1.SecurityGroup)**

List of security groups that belong to the network which is specified in the request. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListNetworkSecurityGroupsRequest.pageSize](#yandex.cloud.vpc.v1.ListNetworkSecurityGroupsRequest), use
the `nextPageToken` as the value
for the [ListNetworkSecurityGroupsRequest.pageToken](#yandex.cloud.vpc.v1.ListNetworkSecurityGroupsRequest) query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
|#

## SecurityGroup {#yandex.cloud.vpc.v1.SecurityGroup}

#|
||Field | Description ||
|| id | **string**

ID of the security group. ||
|| folderId | **string**

ID of the folder that the security group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the security group.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Description of the security group. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_./\\@0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_./\\@0-9a-z]*`. ||
|| networkId | **string**

ID of the network that the security group belongs to. ||
|| status | **enum** (Status)

Security group status.

- `STATUS_UNSPECIFIED`
- `CREATING`: Security group is being created.
- `ACTIVE`: Security is active and it's rules are applied to the network interfaces.
- `UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.
- `DELETING`: Instance is being deleted. ||
|| rules[] | **[SecurityGroupRule](#yandex.cloud.vpc.v1.SecurityGroupRule)**

List of the security group rules. ||
|| defaultForNetwork | **boolean**

Flag that indicates that the security group is the default for the network. ||
|#

## SecurityGroupRule {#yandex.cloud.vpc.v1.SecurityGroupRule}

#|
||Field | Description ||
|| id | **string**

ID of the rule. ||
|| description | **string**

Description of the rule. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| direction | **enum** (Direction)

Required field. The direction of network traffic allowed by this rule.

- `DIRECTION_UNSPECIFIED`
- `INGRESS`: Allows ingress traffic.
- `EGRESS`: Allows egress traffic. ||
|| ports | **[PortRange](#yandex.cloud.vpc.v1.PortRange)**

The range of ports that allow traffic to pass through. Null value means any. ||
|| protocolName | **string**

Protocol name. Null value means any protocol.
Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| protocolNumber | **string** (int64)

Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| cidrBlocks | **[CidrBlocks](#yandex.cloud.vpc.v1.CidrBlocks)**

CIDR blocks to allow to recieve or send traffic.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|| securityGroupId | **string**

ID of the security group to add rule to.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|| predefinedTarget | **string**

Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|#

## PortRange {#yandex.cloud.vpc.v1.PortRange}

#|
||Field | Description ||
|| fromPort | **string** (int64)

The lowest port in the range. ||
|| toPort | **string** (int64)

The highest port in the range. ||
|#

## CidrBlocks {#yandex.cloud.vpc.v1.CidrBlocks}

#|
||Field | Description ||
|| v4CidrBlocks[] | **string**

IPv4 CIDR blocks to allow traffic to. ||
|| v6CidrBlocks[] | **string**

IPv6 CIDR blocks to allow traffic to. ||
|#