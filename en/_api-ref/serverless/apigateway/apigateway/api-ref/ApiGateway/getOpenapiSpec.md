---
editable: false
---

# Method getOpenapiSpec
Returns the Openapi specification of specified api-gateway.
 

 
## HTTP request {#https-request}
```
GET https://serverless-apigateway.api.cloud.yandex.net/apigateways/v1/apigateways/{apiGatewayId}:spec
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
apiGatewayId | Required. ID of the api-gateway to get specification from.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
format | Format of returned specification. Default is the original format used in `CreateApiGatewayRequest`
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "apiGatewayId": "string",
  "openapiSpec": "string"
}
```

 
Field | Description
--- | ---
apiGatewayId | **string**<br><p>ID of the api-gateway.</p> 
openapiSpec | **string**<br><p>text of the specification, json or yaml</p> 