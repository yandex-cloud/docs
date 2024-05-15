---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Network/listSecurityGroups.md
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
securityGroups[].<br>id | **string**<br><p>ID of the security group.</p> 
securityGroups[].<br>folderId | **string**<br><p>ID of the folder that the security group belongs to.</p> 
securityGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
securityGroups[].<br>name | **string**<br><p>Name of the security group. 1-63 characters long.</p> 
securityGroups[].<br>description | **string**<br><p>Description of the security group. 0-256 characters long.</p> 
securityGroups[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
securityGroups[].<br>networkId | **string**<br><p>ID of the network that the security group belongs to.</p> 
securityGroups[].<br>status | **string**<br><p>Security group status.</p> <ul> <li>CREATING: Security group is being created.</li> <li>ACTIVE: Security is active and it's rules are applied to the network interfaces.</li> <li>UPDATING: Security group is updating. Updating is a long operation because we must update all instances in SG.</li> <li>DELETING: Instance is being deleted.</li> </ul> 
securityGroups[].<br>rules[] | **object**<br><p>List of the security group rules.</p> 
securityGroups[].<br>rules[].<br>id | **string**<br><p>ID of the rule.</p> 
securityGroups[].<br>rules[].<br>description | **string**<br><p>Description of the rule. 0-256 characters long.</p> 
securityGroups[].<br>rules[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
securityGroups[].<br>rules[].<br>direction | **string**<br>Required. The direction of network traffic allowed by this rule.<br><ul> <li>INGRESS: Allows ingress traffic.</li> <li>EGRESS: Allows egress traffic.</li> </ul> 
securityGroups[].<br>rules[].<br>ports | **object**<br>The range of ports that allow traffic to pass through. Null value means any.
securityGroups[].<br>rules[].<br>ports.<br>fromPort | **string** (int64)<br><p>The lowest port in the range.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
securityGroups[].<br>rules[].<br>ports.<br>toPort | **string** (int64)<br><p>The highest port in the range.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
securityGroups[].<br>rules[].<br>protocolName | **string**<br><p>Protocol name. Null value means any protocol. Values from <a href="https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml">IANA</a>.</p> 
securityGroups[].<br>rules[].<br>protocolNumber | **string** (int64)<br><p>Protocol number from <a href="https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml">IANA protocol numbers</a>.</p> 
securityGroups[].<br>rules[].<br>cidrBlocks | **object**<br>CIDR blocks to allow to recieve or send traffic. <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br>
securityGroups[].<br>rules[].<br>cidrBlocks.<br>v4CidrBlocks[] | **string**<br><p>IPv4 CIDR blocks to allow traffic to.</p> 
securityGroups[].<br>rules[].<br>cidrBlocks.<br>v6CidrBlocks[] | **string**<br><p>IPv6 CIDR blocks to allow traffic to.</p> 
securityGroups[].<br>rules[].<br>securityGroupId | **string** <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br><p>ID of the security group to add rule to.</p> 
securityGroups[].<br>rules[].<br>predefinedTarget | **string** <br>`securityGroups[].rules[]` includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`<br><br><p>Predefined target. See <a href="/docs/vpc/concepts/security-groups#security-groups-rules">security groups rules</a> for more information.</p> 
securityGroups[].<br>defaultForNetwork | **boolean** (boolean)<br><p>Flag that indicates that the security group is the default for the network.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/vpc/api-ref/Network/listSecurityGroups#query_params">pageSize</a>, use the <a href="/docs/vpc/api-ref/Network/listSecurityGroups#responses">nextPageToken</a> as the value for the <a href="/docs/vpc/api-ref/Network/listSecurityGroups#query_params">pageToken</a> query parameter in the next list request. Subsequent list requests will have their own <a href="/docs/vpc/api-ref/Network/listSecurityGroups#responses">nextPageToken</a> to continue paging through the results.</p> 