---
editable: false
apiPlayground:
  - url: https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways/{apiGatewayId}:spec
    method: get
    path:
      type: object
      properties:
        apiGatewayId:
          description: |-
            **string**
            Required field. ID of the API gateway to get specification from.
          type: string
      required:
        - apiGatewayId
      additionalProperties: false
    query:
      type: object
      properties:
        format:
          description: |-
            **enum** (Format)
            Format of returned specification. Default is the original format used in [CreateApiGatewayRequest](/docs/api-gateway/apigateway/api-ref/ApiGateway/create#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest).
            - `FORMAT_UNSPECIFIED`
            - `JSON`
            - `YAML`
          type: string
          enum:
            - FORMAT_UNSPECIFIED
            - JSON
            - YAML
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/apigateway/v1/apigateway/api-ref/ApiGateway/getOpenapiSpec.md
---

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

Format of returned specification. Default is the original format used in [CreateApiGatewayRequest](/docs/api-gateway/apigateway/api-ref/ApiGateway/create#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest).

- `FORMAT_UNSPECIFIED`
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