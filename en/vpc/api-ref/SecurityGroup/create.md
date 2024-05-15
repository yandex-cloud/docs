---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/SecurityGroup/create.md
---

# Virtual Private Cloud API, REST: SecurityGroup.create
Creates a security group in the specified folder and network.
 

 
## HTTP request {#https-request}
```
POST https://vpc.{{ api-host }}/vpc/v1/securityGroups
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "ruleSpecs": [
    {
      "description": "string",
      "labels": "object",
      "direction": "string",
      "ports": {
        "fromPort": "string",
        "toPort": "string"
      },

      // `ruleSpecs[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`
      "protocolName": "string",
      "protocolNumber": "string",
      // end of the list of possible fields`ruleSpecs[]`

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
    }
  ]
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder for this request to create a security group in. To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the security group. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``.</p> 
description | **string**<br><p>Description of the security group.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
networkId | **string**<br><p>Required. ID of the Network to create security group for.</p> 
ruleSpecs[] | **object**<br><p>Security rules specifications.</p> 
ruleSpecs[].<br>description | **string**<br><p>Description of the security rule.</p> <p>The maximum string length in characters is 256.</p> 
ruleSpecs[].<br>labels | **object**<br><p>Rule labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
ruleSpecs[].<br>direction | **string**<br>Required. The direction of network traffic allowed by this rule.<br><ul> <li>INGRESS: Allows ingress traffic.</li> <li>EGRESS: Allows egress traffic.</li> </ul> 
ruleSpecs[].<br>ports | **object**<br>The range of ports that allow traffic to pass through. Null value means any port.
ruleSpecs[].<br>ports.<br>fromPort | **string** (int64)<br><p>The lowest port in the range.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
ruleSpecs[].<br>ports.<br>toPort | **string** (int64)<br><p>The highest port in the range.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
ruleSpecs[].<br>protocolName | **string** <br>`ruleSpecs[]` includes only one of the fields `protocolName`, `protocolNumber`<br><br><p>Protocol name.</p> 
ruleSpecs[].<br>protocolNumber | **string** (int64) <br>`ruleSpecs[]` includes only one of the fields `protocolName`, `protocolNumber`<br><br><p>Protocol number from <a href="https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml">IANA protocol numbers</a>.</p> 
ruleSpecs[].<br>cidrBlocks | **object**<br>CIDR blocks to allow to recieve or send traffic. <br>`ruleSpecs[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
ruleSpecs[].<br>cidrBlocks.<br>v4CidrBlocks[] | **string**<br><p>IPv4 CIDR blocks to allow traffic to.</p> 
ruleSpecs[].<br>cidrBlocks.<br>v6CidrBlocks[] | **string**<br><p>IPv6 CIDR blocks to allow traffic to.</p> 
ruleSpecs[].<br>securityGroupId | **string** <br>`ruleSpecs[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br><p>ID of the security group to add rule to.</p> 
ruleSpecs[].<br>predefinedTarget | **string** <br>`ruleSpecs[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br><p>Predefined target. See <a href="/docs/vpc/concepts/security-groups#security-groups-rules">security groups rules</a> for more information.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 