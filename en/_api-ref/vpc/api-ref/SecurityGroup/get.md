---
editable: false
---

# Method get

 

 
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
id | **string**<br>
folderId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>
labels | **object**<br>
networkId | **string**<br>
status | **string**<br><ul> <li>UPDATING: updating is a long operation because we must update all instances in SG</li> </ul> 
rules[] | **object**<br>
rules[].<br>id | **string**<br>
rules[].<br>description | **string**<br>
rules[].<br>labels | **object**<br>
rules[].<br>direction | **string**<br>Required.<br>
rules[].<br>ports | **object**<br>
rules[].<br>ports.<br>fromPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
rules[].<br>ports.<br>toPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
rules[].<br>protocolName | **string**<br><p>null value means any protocol values from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml</p> 
rules[].<br>protocolNumber | **string** (int64)<br>
rules[].<br>cidrBlocks | **object** <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br>
rules[].<br>cidrBlocks.<br>v4CidrBlocks[] | **string**<br>
rules[].<br>cidrBlocks.<br>v6CidrBlocks[] | **string**<br>
rules[].<br>securityGroupId | **string** <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br>
rules[].<br>predefinedTarget | **string** <br>`rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br>
defaultForNetwork | **boolean** (boolean)<br>