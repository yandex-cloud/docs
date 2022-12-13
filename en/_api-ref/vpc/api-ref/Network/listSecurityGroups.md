---
editable: false
---

# Virtual Private Cloud API, REST: Network.listSecurityGroups
Lists security groups from the specified network.
 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/networks/{networkId}/security_groups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkId | <p>Required. ID of the Network resource to list security groups for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than <a href="/docs/vpc/api-ref/Network/listSecurityGroups#query_params">pageSize</a>, the service returns a <a href="/docs/vpc/api-ref/Network/listSecurityGroups#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. Set <a href="/docs/vpc/api-ref/Network/listSecurityGroups#query_params">pageToken</a> to the <a href="/docs/vpc/api-ref/Network/listSecurityGroups#responses">nextPageToken</a> returned by a previous list request to get the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
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
securityGroups[] | **object**<br><p>List of security groups that belong to the network which is specified in the request.</p> 
securityGroups[].<br>id | **string**
securityGroups[].<br>folderId | **string**
securityGroups[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
securityGroups[].<br>name | **string**
securityGroups[].<br>description | **string**
securityGroups[].<br>labels | **object**
securityGroups[].<br>networkId | **string**
securityGroups[].<br>status | **string**<br><ul> <li>UPDATING: updating is a long operation because we must update all instances in SG</li> </ul> 
securityGroups[].<br>rules[] | **object**
securityGroups[].<br>rules[].<br>id | **string**
securityGroups[].<br>rules[].<br>description | **string**
securityGroups[].<br>rules[].<br>labels | **object**
securityGroups[].<br>rules[].<br>direction | **string**<br>Required.
securityGroups[].<br>rules[].<br>ports | **object**
securityGroups[].<br>rules[].<br>ports.<br>fromPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
securityGroups[].<br>rules[].<br>ports.<br>toPort | **string** (int64)<br><p>Acceptable values are 0 to 65535, inclusive.</p> 
securityGroups[].<br>rules[].<br>protocolName | **string**<br><p>null value means any protocol values from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml</p> 
securityGroups[].<br>rules[].<br>protocolNumber | **string** (int64)
securityGroups[].<br>rules[].<br>cidrBlocks | **object** <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
securityGroups[].<br>rules[].<br>cidrBlocks.<br>v4CidrBlocks[] | **string**
securityGroups[].<br>rules[].<br>cidrBlocks.<br>v6CidrBlocks[] | **string**
securityGroups[].<br>rules[].<br>securityGroupId | **string** <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
securityGroups[].<br>rules[].<br>predefinedTarget | **string** <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
securityGroups[].<br>defaultForNetwork | **boolean** (boolean)
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/vpc/api-ref/Network/listSecurityGroups#query_params">pageSize</a>, use the <a href="/docs/vpc/api-ref/Network/listSecurityGroups#responses">nextPageToken</a> as the value for the <a href="/docs/vpc/api-ref/Network/listSecurityGroups#query_params">pageToken</a> query parameter in the next list request. Subsequent list requests will have their own <a href="/docs/vpc/api-ref/Network/listSecurityGroups#responses">nextPageToken</a> to continue paging through the results.</p> 