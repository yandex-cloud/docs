---
editable: false
---

# Метод getOpenapiSpec
Возвращает спецификацию OpenAPI указанного API-шлюза.
 

 
## HTTP-запрос {#https-request}
```
GET https://serverless-apigateway.api.cloud.yandex.net/apigateways/v1/apigateways/{apiGatewayId}:spec
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
apiGatewayId | Обязательное поле. Идентификатор API-шлюза для получения спецификации.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
format | Формат возвращаемой спецификации. По умолчанию используется исходный формат, используемый в `CreateApiGatewayRequest`.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "apiGatewayId": "string",
  "openapiSpec": "string"
}
```

 
Поле | Описание
--- | ---
apiGatewayId | **string**<br><p>Идентификатор API-шлюза.</p> 
openapiSpec | **string**<br><p>Текст спецификации, JSON или YAML.</p> 