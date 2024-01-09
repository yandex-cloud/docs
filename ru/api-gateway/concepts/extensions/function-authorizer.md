---
title: "Расширение x-yc-apigateway-authorizer:function для {{ api-gw-full-name }}"
description: "Узнайте, для чего используется расширение x-yc-apigateway-authorizer:function, его спецификацию, а также ознакомьтесь с примером функции, которую вызывается с помощью расширения." 
---

# Расширение x-yc-apigateway-authorizer:function

Расширение `x-yc-apigateway-authorizer:function` используется внутри схем компонента [securityScheme](https://swagger.io/docs/specification/authentication/) с типами:

* [HTTP Basic](https://swagger.io/docs/specification/authentication/basic-authentication/);
* [HTTP Bearer](https://swagger.io/docs/specification/authentication/bearer-authentication/);
* [API Key](https://swagger.io/docs/specification/authentication/api-keys/).

Для авторизации HTTP-запроса {{ api-gw-short-name }} вызывает указанную в расширении функцию. Подробнее о структуре [запроса](#request) и [ответа](#response).

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание
----|----|----
`function_id` | `string` | Идентификатор [функции](../../../functions/concepts/function.md).
`tag` | `string` | Необязательный параметр. [Тег версии](../../../functions/concepts/function.md#tag) функции. Значение по умолчанию — `$latest`.<br>В `tag` осуществляется подстановка параметров.
`service_account_id` | `string` | Идентификатор сервисного аккаунта. Используется для авторизации при обращении к функции. Если параметр не указан, используется значение [верхнеуровневого параметра](./index.md#top-level) `service_account_id`. Если верхнеуровневого параметра нет, функция вызывается без авторизации.
`authorizer_result_ttl_in_seconds` | `int` | Необязательный параметр. Время, в течение которого ответ функции хранится в локальном кеше {{ api-gw-short-name }}. Если параметр не указан, ответ не кешируется.
`authorizer_result_caching_mode` | `string` | Необязательный параметр. Режим кеширования результата авторизации. Для использования необходимо также указать параметр `authorizer_result_ttl_in_seconds`. Возможные значения: `path`, `uri`.

## Спецификация расширения {#spec}

Пример спецификации для схемы с типом HTTP Basic:

```yaml
paths:
  /http/basic/authorize:
    get:
      summary: Authorized operation with http basic security scheme
      operationId: httpBasicAuthorize
      security:
        - httpBasicAuth: [ ]
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': "Authorized!"
        http_code: 200
        http_headers:
          'Content-Type': "text/plain"
components:
  securitySchemes:
    httpBasicAuth:
      type: http
      scheme: basic
      x-yc-apigateway-authorizer:
        type: function
        function_id: b095c95icnvb********
        tag: "$latest"
        service_account_id: ajehfe84hhl********
        authorizer_result_ttl_in_seconds: 300
```

## Структура запроса {#request}

JSON-структура запроса к функции:

```json
{
    "resource": <ресурс, соответствующий запросу в спецификации>,
    "path": <фактический путь запроса>,
    "httpMethod": <название HTTP-метода>,
    "headers": <словарь со строковыми значениями HTTP-заголовков>,
    "queryStringParameters": <словарь queryString-параметров>,
    "pathParameters": <словарь значений параметров пути запроса>,
    "requestContext": <словарь с контекстом запроса>,
    "cookies": <словарь, содержащий cookies запроса>
}
```

## Структура ответа {#response}

JSON-структура ответа:

```json
{
    "isAuthorized": <результат авторизации — true или false>,
    "context": <словарь с контекстом авторизации>
}
```

## Пример функции {#function}

Пример функции, в которой используется структура ответа с [контекстом авторизации](#context):

{% list tabs %}

- JavaScript

  ```js
  exports.handler = async function (event, context) {
      let response = {
          "isAuthorized": false
      };

      if (event.headers.Authorization === "secretToken") {
          response = {
              "isAuthorized": true,
              "context": {
                  "stringKey": "value",
                  "numberKey": 1,
                  "booleanKey": true,
                  "arrayKey": ["value1", "value2"],
                  "mapKey": {"value1": "value2"}
              }
          };
      }

      return response;
  };
  ```

{% endlist %}

`secretToken` — это авторизационные данные зарегистрированного пользователя или доверенного клиента, например `Basic <base64(логин:пароль)>` или `Bearer <JWT-токен>`.

## Кеширование {#caching}

Ответ функции сохраняется в локальном кеше {{ api-gw-short-name }}, если в расширении задан параметр `authorizer_result_ttl_in_seconds`.

Состав ключа кеширования зависит от типа авторизации и значения параметра `authorizer_result_caching_mode`.

Тип авторизации | Режим кеширования `path` | Режим кеширования `uri` | Режим кеширования не указан
----------------|--------------------------|-------------------------|----------------------------
[HTTP Basic](https://swagger.io/docs/specification/authentication/basic-authentication/)| `path`, `operation` (HTTP-метод) и заголовок `Authorization` | `uri`, `operation` (HTTP-метод) и заголовок `Authorization` | `path`, `operation` (HTTP-метод) и заголовок `Authorization`
[HTTP Bearer](https://swagger.io/docs/specification/authentication/bearer-authentication/)| `path`, `operation` (HTTP-метод) и заголовок `Authorization` | `uri`, `operation` (HTTP-метод) и заголовок `Authorization` | `path`, `operation` (HTTP-метод) и заголовок `Authorization`
[API Key](https://swagger.io/docs/specification/authentication/api-keys/)| `path`, `operation` (HTTP-метод) и API-ключ | `uri`, `operation` (HTTP-метод) и API-ключ                  | `path`, `operation` (HTTP-метод) и API-ключ

Например, для следующей спецификации при выполнении запроса `/user/123` ключ кеширования сформируется из значения `/user/{id}`, `GET` и значения заголовка `Authorization`. Если изменить значение параметра `authorizer_result_caching_mode` на `uri`, ключа кеширования сформируется из `/user/123`, `GET` и значения заголовка `Authorization`.

```yaml
paths:
  /user/{id}:
    get:
      summary: Authorized operation with http basic security scheme
      operationId: httpBasicAuthorize
      parameters:
        - in: path
          name: id
          schema:
            type: integer
          required: true
          description: Numeric ID of the user to get
      security:
        - httpBasicAuth: [ ]
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': "Authorized!"
        http_code: 200
        http_headers:
          'Content-Type': "text/plain"
components:
  securitySchemes:
    httpBasicAuth:
      type: http
      scheme: basic
      x-yc-apigateway-authorizer:
        type: function
        function_id: b095c95icnvb********
        tag: "$latest"
        service_account_id: ajehfe84hhl********
        authorizer_result_ttl_in_seconds: 300
        authorizer_result_caching_mode: path
```

Если в течение времени, указанного в параметре `authorizer_result_ttl_in_seconds`, повторно придет HTTP-запрос с аналогичными составляющими ключа кеширования, {{ api-gw-short-name }} использует ответ, сохраненный в кеше, и не будет вызывать функцию.

## Контекст авторизации {#context}

Если авторизация прошла успешно, при вызове другой пользовательской функции контекст авторизации будет передан в [запросе](../../../functions/concepts/function-invoke.md#request) внутри поля `requestContext.authorizer`. Контекст авторизации может содержать данные, идентифицирующие пользователя, от которого пришел HTTP-запрос.

## Возможные ошибки {#errors}

* `401 Unauthorized` — клиент не передал в HTTP-запросе авторизационные данные, которые определены схемой (например, заголовок `Authorization` для схемы с типом [HTTP Basic](https://swagger.io/docs/specification/authentication/basic-authentication/)).
* `403 Forbidden` — {{ api-gw-short-name }} неуспешно вызвал функцию (`"isAuthorized": false`).
* `500 Internal Server Error` — {{ api-gw-short-name }} не смог вызвать функцию или получил от нее ответ с некорректной структурой.
