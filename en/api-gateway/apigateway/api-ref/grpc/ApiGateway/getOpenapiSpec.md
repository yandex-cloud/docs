---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/v1/apigateway/api-ref/grpc/ApiGateway/getOpenapiSpec.md
---

# API Gateway Service, gRPC: ApiGatewayService.GetOpenapiSpec

Returns the OpenAPI specification of specified API gateway.

## gRPC request

**rpc GetOpenapiSpec ([GetOpenapiSpecRequest](#yandex.cloud.serverless.apigateway.v1.GetOpenapiSpecRequest)) returns ([GetOpenapiSpecResponse](#yandex.cloud.serverless.apigateway.v1.GetOpenapiSpecResponse))**

## GetOpenapiSpecRequest {#yandex.cloud.serverless.apigateway.v1.GetOpenapiSpecRequest}

```json
{
  "api_gateway_id": "string",
  "format": "Format"
}
```

#|
||Field | Description ||
|| api_gateway_id | **string**

Required field. ID of the API gateway to get specification from. ||
|| format | enum **Format**

Format of returned specification. Default is the original format used in [CreateApiGatewayRequest](/docs/functions/api-gateway/api-ref/grpc/ApiGateway/create#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest).

- `FORMAT_UNSPECIFIED`
- `JSON`
- `YAML` ||
|#

## GetOpenapiSpecResponse {#yandex.cloud.serverless.apigateway.v1.GetOpenapiSpecResponse}

```json
{
  "api_gateway_id": "string",
  "openapi_spec": "string"
}
```

#|
||Field | Description ||
|| api_gateway_id | **string**

ID of the API gateway. ||
|| openapi_spec | **string**

The text of specification, JSON or YAML. ||
|#