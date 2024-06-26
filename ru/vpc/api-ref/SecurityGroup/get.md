---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/SecurityGroup/get.md
---

# Virtual Private Cloud API, REST: SecurityGroup.get
Returns the specified SecurityGroup resource.
 
To get the list of all available SecurityGroup resources, make a [list](/docs/vpc/api-ref/SecurityGroup/list) request.
 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/securityGroups/{securityGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
securityGroupId | <p>Required. ID of the Security Group resource to return. To get the security group ID, use a [SecurityGroup.List] request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "status": "string",
  "rules": [
    {
      "id": "string",
      "description": "string",
      "labels": "object",
      "direction": "string",
      "ports": {
        "fromPort": "string",
        "toPort": "string"
      },
      "protocolName": "string",
      "protocolNumber": "string",

      // `rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`
      "cidrBlocks": {
        "v4CidrBlocks": [
          "string"
        ],
        "v6CidrBlocks": [
          "string"
        ]
      },
      "securityGroupId": "string",
      "predefinedTarget": "string",
      // end of the list of possible fields`rules[]`

    }
  ],
  "defaultForNetwork": true
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the security group.</p> 
folderId | **string**<br><p>ID of the folder that the security group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the security group. The name must be unique within the folder. Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``.</p> 
description | **string**<br><p>Description of the security group. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\\@0-9a-z]*``. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\\@0-9a-z]*``.</p> 
networkId | **string**<br><p>ID of the network that the security group belongs to.</p> 
status | **string**<br><p>Security group status.</p> <ul> <li>CREATING: Security group is being created.</li> <li>ACTIVE: Security is active and it's rules are applied to the network interfaces.</li> <li>UPDATING: Security group is updating. Updating is a long operation because we must update all instances in SG.</li> <li>DELETING: Instance is being deleted.</li> </ul> 
rules[] | **object**<br><p>List of the security group rules.</p> 
rules[].<br>id | **string**<br><p>ID of the rule.</p> 
rules[].<br>description | **string**<br><p>Description of the rule. 0-256 characters long.</p> 
rules[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
rules[].<br>direction | **string**<br>Required. The direction of network traffic allowed by this rule.<br><ul> <li>INGRESS: Allows ingress traffic.</li> <li>EGRESS: Allows egress traffic.</li> </ul> 
rules[].<br>ports | **object**<br>The range of ports that allow traffic to pass through. Null value means any.
rules[].<br>ports.<br>fromPort | **string** (int64)<br><p>The lowest port in the range.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
rules[].<br>ports.<br>toPort | **string** (int64)<br><p>The highest port in the range.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
rules[].<br>protocolName | **string**<br><p>Protocol name. Null value means any protocol. Values from <a href="https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml">IANA</a>.</p> 
rules[].<br>protocolNumber | **string** (int64)<br><p>Protocol number from <a href="https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml">IANA protocol numbers</a>.</p> 
rules[].<br>cidrBlocks | **object**<br>CIDR blocks to allow to recieve or send traffic. <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
rules[].<br>cidrBlocks.<br>v4CidrBlocks[] | **string**<br><p>IPv4 CIDR blocks to allow traffic to.</p> 
rules[].<br>cidrBlocks.<br>v6CidrBlocks[] | **string**<br><p>IPv6 CIDR blocks to allow traffic to.</p> 
rules[].<br>securityGroupId | **string** <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br><p>ID of the security group to add rule to.</p> 
rules[].<br>predefinedTarget | **string** <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br><p>Predefined target. See <a href="/docs/vpc/concepts/security-groups#security-groups-rules">security groups rules</a> for more information.</p> 
defaultForNetwork | **boolean** (boolean)<br><p>Flag that indicates that the security group is the default for the network.</p> 