---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/v1/apigateway/api-ref/ApiGateway/getOpenapiSpec.md
---

# API Gateway Service, REST: ApiGateway.getOpenapiSpec
Returns the OpenAPI specification of specified API gateway.
 

 
## HTTP request {#https-request}
```
GET https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways/{apiGatewayId}:spec
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
apiGatewayId | <p>Required. ID of the API gateway to get specification from.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
format | <p>Format of returned specification. Default is the original format used in ``CreateApiGatewayRequest``.</p> 
 
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
apiGatewayId | **string**<br><p>ID of the API gateway.</p> 
openapiSpec | **string**<br><p>The text of specification, JSON or YAML.</p> 