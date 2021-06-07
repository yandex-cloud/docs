---
editable: false
---

# Метод get
Возвращает указанный API-шлюз. Обратите внимание, что возвращаются только базовые параметры API-шлюза. Чтобы получить соответствующую спецификацию OpenAPI,
сделайте [getOpenapiSpec](/docs/api-gateway/api-ref/ApiGateway/getOpenapiSpec) запрос.
 
Чтобы получить список всех доступных API-шлюзов, сделайте [list](/docs/api-gateway/api-ref/ApiGateway/list) запрос.
 
## HTTP-запрос {#https-request}
```
GET https://serverless-apigateway.api.cloud.yandex.net/apigateways/v1/apigateways/{apiGatewayId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
apiGatewayId | Обязательное поле. Идентификатор возвращаемого API-шлюза.  Чтобы получить идентификатор API-шлюза, сделайте [list](/docs/api-gateway/api-ref/ApiGateway/list) запрос.
 
## Ответ {#responses}
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
  "logGroupId": "string"
}
```

 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор API-шлюза. Генерируется при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит API-шлюз.</p> 
createdAt | **string** (date-time)<br><p>Время создания API-шлюза.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя API-шлюза. Имя уникально в рамках каталога.</p> 
description | **string**<br><p>Описание API-шлюза.</p> 
labels | **object**<br><p>Метки API-шлюза в формате ``key:value`` .</p> 
status | **string**<br><p>Состояние API-шлюза.</p> <ul> <li>CREATING: API-шлюз создается.</li> <li>ACTIVE: API-шлюз готов к использованию.</li> <li>DELETING: API-шлюз удаляется.</li> <li>ERROR: Сбой API-шлюза. Единственное разрешенное действие c API-шлюзом — удаление.</li> </ul> 
domain | **string**<br><p>Домен по умолчанию для API-шлюза. Генерируется при создании.</p> 
logGroupId | **string**<br><p>Идентификатор группы журналов выполнения для API-шлюза.</p> 