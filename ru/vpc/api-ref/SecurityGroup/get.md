---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/SecurityGroup/get.md
---

# Virtual Private Cloud API, REST: SecurityGroup.get

 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/securityGroups/{securityGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
securityGroupId | <p>Required.</p> 
 
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
id | **string**
folderId | **string**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**
description | **string**
labels | **object**
networkId | **string**
status | **string**<br><ul> <li>UPDATING: updating is a long operation because we must update all instances in SG</li> </ul> 
rules[] | **object**
rules[].<br>id | **string**
rules[].<br>description | **string**
rules[].<br>labels | **object**
rules[].<br>direction | **string**<br>Required.
rules[].<br>ports | **object**
rules[].<br>ports.<br>fromPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
rules[].<br>ports.<br>toPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
rules[].<br>protocolName | **string**<br><p>null value means any protocol values from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml</p> 
rules[].<br>protocolNumber | **string** (int64)
rules[].<br>cidrBlocks | **object** <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
rules[].<br>cidrBlocks.<br>v4CidrBlocks[] | **string**
rules[].<br>cidrBlocks.<br>v6CidrBlocks[] | **string**
rules[].<br>securityGroupId | **string** <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
rules[].<br>predefinedTarget | **string** <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
defaultForNetwork | **boolean** (boolean)