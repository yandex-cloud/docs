---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/securityGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required.</p> 
pageSize | 
pageToken | 
filter | 
 
## Response {#responses}
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

          // `securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`
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
          // end of the list of possible fields`securityGroups[].rules[]`

        }
      ],
      "defaultForNetwork": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
securityGroups[] | **object**<br>
securityGroups[].<br>id | **string**<br>
securityGroups[].<br>folderId | **string**<br>
securityGroups[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
securityGroups[].<br>name | **string**<br>
securityGroups[].<br>description | **string**<br>
securityGroups[].<br>labels | **object**<br>
securityGroups[].<br>networkId | **string**<br>
securityGroups[].<br>status | **string**<br><ul> <li>UPDATING: updating is a long operation because we must update all instances in SG</li> </ul> 
securityGroups[].<br>rules[] | **object**<br>
securityGroups[].<br>rules[].<br>id | **string**<br>
securityGroups[].<br>rules[].<br>description | **string**<br>
securityGroups[].<br>rules[].<br>labels | **object**<br>
securityGroups[].<br>rules[].<br>direction | **string**<br>Required.<br>
securityGroups[].<br>rules[].<br>ports | **object**<br>
securityGroups[].<br>rules[].<br>ports.<br>fromPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
securityGroups[].<br>rules[].<br>ports.<br>toPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
securityGroups[].<br>rules[].<br>protocolName | **string**<br><p>null value means any protocol values from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml</p> 
securityGroups[].<br>rules[].<br>protocolNumber | **string** (int64)<br>
securityGroups[].<br>rules[].<br>cidrBlocks | **object** <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br>
securityGroups[].<br>rules[].<br>cidrBlocks.<br>v4CidrBlocks[] | **string**<br>
securityGroups[].<br>rules[].<br>cidrBlocks.<br>v6CidrBlocks[] | **string**<br>
securityGroups[].<br>rules[].<br>securityGroupId | **string** <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br>
securityGroups[].<br>rules[].<br>predefinedTarget | **string** <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br>
securityGroups[].<br>defaultForNetwork | **boolean** (boolean)<br>
nextPageToken | **string**<br>