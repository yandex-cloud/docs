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
`service_account_id` | `string` | Идентификатор сервисного аккаунта. Используется для авторизации при обращении к функции. Если параметр не указан, используется значение [верхнеуровнего параметра](./index.md#top-level) `service_account_id`. Если верхнеуровнего параметра нет, функция вызывается без авторизации.
`authorizer_result_ttl_in_seconds` | `int` | Необязательный параметр. Время, в течение которого ответ функции хранится в локальном кеше {{ api-gw-short-name }}. Если параметр не указан, ответ не кешируется.

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
        function_id: b095c95icnvbuf4v755l
        tag: "$latest"
        service_account_id: ajehfe84hhlaq4n59q1
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

Ответ функции сохраняется в локальном кеше {{ api-gw-short-name }}, если в расширении задан параметр `authorizer_result_ttl_in_seconds`. При формировании ключа кеширования для схемы:
* с типами [HTTP Basic](https://swagger.io/docs/specification/authentication/basic-authentication/) и [HTTP Bearer](https://swagger.io/docs/specification/authentication/bearer-authentication/) используются `path`, `operation`(HTTP-метод) и заголовок `Authorization`;
* с типом [API Key](https://swagger.io/docs/specification/authentication/api-keys/) используются `path`, `operation`(HTTP-метод) и API-ключ.

Если в течение времени, указанного в параметре `authorizer_result_ttl_in_seconds`, повторно придет HTTP-запрос с аналогичными `path`, `operation` и авторизационными данными, {{ api-gw-short-name }} использует ответ, сохраненный в кеше, и не будет вызывать функцию.

## Контекст авторизации {#context}

Если авторизация прошла успешно, при вызове другой пользовательской функции контекст авторизации будет передан в [запросе](../../../functions/concepts/function-invoke.md#request) внутри поля `requestContext.authorizer`. Контекст авторизации может содержать данные, идентифицирующие пользователя, от которого пришел HTTP-запрос.

## Возможные ошибки {#errors}

* `401 Unauthorized` — клиент не передал в HTTP-запросе авторизационные данные, которые определены схемой (например, заголовок `Authorization` для схемы с типом [HTTP Basic](https://swagger.io/docs/specification/authentication/basic-authentication/)).
* `403 Forbidden` — {{ api-gw-short-name }} неуспешно вызвал функцию (`"isAuthorized": false`).
* `500 Internal Server Error` — {{ api-gw-short-name }} не смог вызвать функцию или получил от нее ответ с некорректной структурой.
