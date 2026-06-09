# API Gateway Service, REST: ApiGateway.GetOpenapiSpec

Returns the OpenAPI specification of specified API gateway.

## HTTP request

```
GET https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways/{apiGatewayId}:spec
```

## Path parameters

#|
||Field | Description ||
|| apiGatewayId | **string**

Required field. ID of the API gateway to get specification from. ||
|#

## Query parameters {#yandex.cloud.serverless.apigateway.v1.GetOpenapiSpecRequest}

#|
||Field | Description ||
|| format | **enum** (Format)

Format of returned specification. Default is the original format used in [CreateApiGatewayRequest](create.md#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest).

- `JSON`
- `YAML` ||
|#

## Response {#yandex.cloud.serverless.apigateway.v1.GetOpenapiSpecResponse}

**HTTP Code: 200 - OK**

```json
{
  "apiGatewayId": "string",
  "openapiSpec": "string"
}
```

#|
||Field | Description ||
|| apiGatewayId | **string**

ID of the API gateway. ||
|| openapiSpec | **string**

The text of specification, JSON or YAML. ||
|#