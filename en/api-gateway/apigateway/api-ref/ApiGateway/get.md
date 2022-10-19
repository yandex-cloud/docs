---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/apigateway/api-ref/ApiGateway/get.md
---

# Method get
Returns the specified API gateway. Note that only API gateway basic attributes are returned.
To get associated openapi specification, make a [GetOpenapiSpec](getOpenapiSpec) request.
 
To get the list of all available API gateways, make a [list](/docs/functions/api-gateway/api-ref/ApiGateway/list) request.
 
## HTTP request {#https-request}
```
GET https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways/{apiGatewayId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
apiGatewayId | <p>Required. ID of the API gateway to return.</p> <p>To get a API gateway ID make a <a href="/docs/functions/api-gateway/api-ref/ApiGateway/list">list</a> request.</p> 
 
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
  "status": "string",
  "domain": "string",
  "logGroupId": "string",
  "attachedDomains": [
    {
      "domainId": "string",
      "certificateId": "string",
      "enabled": true,
      "domain": "string"
    }
  ],
  "connectivity": {
    "networkId": "string",
    "subnetId": [
      "string"
    ]
  }
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the API gateway. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the API gateway belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the API-gateway.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the API gateway. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the API gateway.</p> 
labels | **object**<br><p>API gateway labels as ``key:value`` pairs.</p> 
status | **string**<br><p>Status of the API gateway.</p> <ul> <li>CREATING: API gateway is being created.</li> <li>ACTIVE: API gateway is ready for use.</li> <li>DELETING: API gateway is being deleted.</li> <li>ERROR: API gateway failed. The only allowed action is delete.</li> <li>UPDATING: API gateway is being updated.</li> </ul> 
domain | **string**<br><p>Default domain for the API gateway. Generated at creation time.</p> 
logGroupId | **string**<br><p>ID of the log group for the API gateway.</p> 
attachedDomains[] | **object**<br><p>List of domains attached to API gateway.</p> 
attachedDomains[].<br>domainId | **string**<br><p>ID of the domain.</p> 
attachedDomains[].<br>certificateId | **string**<br><p>ID of the domain certificate.</p> 
attachedDomains[].<br>enabled | **boolean** (boolean)<br><p>Enabling flag.</p> 
attachedDomains[].<br>domain | **string**<br><p>Name of the domain.</p> 
connectivity | **object**<br><p>Network access. If specified the gateway will be attached to specified network/subnet(s).</p> <p>Gateway connectivity specification.</p> 
connectivity.<br>networkId | **string**<br><p>Network the gateway will have access to. It's essential to specify network with subnets in all availability zones.</p> 
connectivity.<br>subnetId[] | **string**<br><p>Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones.</p> 