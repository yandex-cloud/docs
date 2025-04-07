# Расширение x-yc-apigateway-integration:cloud_functions

Расширение `x-yc-apigateway-integration:cloud_functions` вызывает указанную функцию. В качестве входных данных функция получает информацию о HTTP-запросе и значения параметров, указанных в спецификации, на выходе клиенту возвращается результат выполнения функции.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`function_id` | `string` | Идентификатор [функции](../../../functions/concepts/function.md).
`tag` | `string` | Необязательный параметр. [Тег версии](../../../functions/concepts/function.md#tag) функции. Значение по умолчанию — `$latest`. <br>В `tag` осуществляется подстановка параметров.
`service_account_id` | `string` | Идентификатор сервисного аккаунта для авторизации при обращении к функции. Сервисный аккаунт необходим для [вызова](../../../functions/operations/function/auth.md) приватной функции — для этого он должен иметь [роль](../../../functions/security/index.md#functions-functionInvoker) `{{ roles-functions-invoker }}` или выше на эту функцию. Если параметр не указан, используется значение [верхнеуровневого](./index.md#top-level) параметра `service_account_id`. Если верхнеуровневого параметра тоже нет, функция вызывается без авторизации.
`payload_format_version` | `string` | Версия формата запроса к функции. Возможные значения — [`0.1`](#request_v0) и [`1.0`](#request_v1). Версия по умолчанию — [`0.1`](#request_v0).
`context` | `object` | Необязательный параметр. Контекст операции — произвольный объект в формате `YAML` или `JSON`. Передается в функцию внутри [запроса](../../../functions/concepts/function-invoke.md#request) в поле `requestContext.apiGateway.operationContext`. В `context` осуществляется подстановка параметров.

## Спецификация расширения {#spec}

Пример спецификации: 

```yaml
/example/{ID}:
    get:
      summary: Get ID
      operationId: getID
      tags:
        - example
      parameters:
        - name: ID
          in: path
          description: Return ID
          required: true
          schema:
            type: string
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95icnvb********
        tag: "$latest"
        service_account_id: ajehfe56hhl********
```

Пример функции:

```js
exports.handler= async function (data, context) {
    return {
        'statusCode': 200,
        'isBase64Encoded': false,
        'body': JSON.stringify({
            'petId': data.params.ID
        }),
    }
};
```

## Структура запроса v0.1 {#request_v0}

JSON-структура запроса версии `0.1` повторяет [структуру запроса](../../../functions/concepts/function-invoke.md#request) к функции с некоторыми дополнительными полями:

```json
{
    "url": <фактический путь запроса>,
    "path": <путь, соответствующий запросу в спецификации>,
    "httpMethod": <название HTTP-метода>,
    "headers": <словарь со строковыми значениями HTTP-заголовков>,
    "multiValueHeaders": <словарь со списками значений HTTP-заголовков>,
    "queryStringParameters": <словарь queryString-параметров>,
    "multiValueQueryStringParameters": <словарь списков значений queryString-параметров>,
    "requestContext": <словарь с контекстом запроса>,
    "body": <содержимое запроса>,
    "isBase64Encoded": <true или false>,
    "pathParams": <словарь значений параметров пути запроса>,
    "params": <словарь значений параметров запроса, описанных в спецификации OpenAPI>,
    "multiValueParams": <словарь со списками значений параметров запроса, описанных в спецификации OpenAPI>
}
```

## Структура запроса v1.0 {#request_v1}

JSON-структура запроса версии `1.0` совместима с форматом запроса [AWS API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html#http-api-develop-integrations-lambda.proxy-format) версии `1.0` и содержит дополнительные поля:

```json
{
    "version": <версия формата запроса>,
    "resource": <ресурс, соответствующий запросу в спецификации>,
    "path": <фактический путь запроса>,
    "httpMethod": <название HTTP-метода>,
    "headers": <словарь со строковыми значениями HTTP-заголовков>,
    "multiValueHeaders": <словарь со списками значений HTTP-заголовков>,
    "queryStringParameters": <словарь queryString-параметров>,
    "multiValueQueryStringParameters": <словарь списков значений queryString-параметров>,
    "requestContext": <словарь с контекстом запроса>,
    "pathParameters": <словарь значений параметров пути запроса>,
    "body": <содержимое запроса>,
    "isBase64Encoded": <true или false>,
    // дополнительные поля:    
    "parameters": <словарь значений параметров запроса, описанных в спецификации OpenAPI>,
    "multiValueParameters": <словарь со списками значений параметров запроса, описанных в спецификации OpenAPI>,
    "operationId": <operationId, соответствующий запросу в спецификации OpenAPI>
}
```

Структура элемента `requestContext`:

```json
    {
        "identity": <набор пар ключ:значение для аутентификации пользователя>,
        "httpMethod": <DELETE, GET, HEAD, OPTIONS, PATCH, POST или PUT>,
        "requestId": <идентификатор запроса, который генерируется в роутере>,
        "requestTime": <время запроса в формате CLF>,
        "requestTimeEpoch": <время запроса в формате Unix>,
        "authorizer": <словарь с контекстом авторизации>,
        "apiGateway": <словарь со специфичными данными, передаваемыми API-шлюзом при вызове функции>,
        "connectionId": <идентификатор веб-сокетного соединения>",
        "connectedAt": <время подключения веб-сокетного соединения>,
        "eventType": <тип события или операции с веб-сокетом: CONNECT, MESSAGE, DISCONNECT>,
        "messageId": <идентификатор сообщения, полученного из веб-сокета>,
        "disconnectStatusCode": <статус-код закрытия веб-сокета>,
        "disconnectReason": <текстовое описание причины закрытия веб-сокета>
    }
```

Структура элемента `authorizer`:
```json
    {
        "jwt": { // Поле, которое заполняет JWT-авторайзер API Gateway. Содержит данные из токена о пользователе и его правах'
          "claims": <словарь полей тела JWT>,
          "scopes": <список прав владельца JWT>
        }
        // Другие поля контекста авторизации, возвращаемые из функции-авторайзера
    }
```

## Примеры использования {#examples}

* [{#T}](../../tutorials/api-gw-integration.md)
* [{#T}](../../tutorials/canary-release.md)
* [{#T}](../../tutorials/recognizer-bot.md)
* [{#T}](../../tutorials/java-servlet-todo-list.md)
