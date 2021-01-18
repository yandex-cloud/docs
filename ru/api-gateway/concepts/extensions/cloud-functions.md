# Расширение x-yc-apigateway-integration:cloud_functions

Расширение `x-yc-apigateway-integration:cloud_functions` вызывает указанную функцию. В качестве входных данных функция получает информацию о HTTP-запросе и значения параметров, указанных в спецификации, на выходе клиенту возвращается результат выполнения функции. Информация о запросе передается в том же формате, что и в текущей версии [HTTP-интеграции](../../../functions/concepts/function-invoke.md#http) при вызове функции с указанием параметра строки запроса `integration=raw`, который по большей части совместим с форматом AWS API Gateway. Значения параметров, указанных в спецификации, передаются в поле `params` параметра `data`.

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`function_id` | `string` | Идентификатор [функции](../../../functions/concepts/function.md).
`tag` | `string` | Необязательный параметр. [Тег версии](../../../functions/concepts/function.md#tag) функции. Значение по умолчанию — `$latest`. <br>В `tag` осуществляется подстановка параметров.
`service_account_id` | `string` | Идентификатор сервисного аккаунта для авторизации при обращении к функции. Если параметр не указан, используется значение [верхнеуровнего](./index.md#top-level) параметра `service_account_id`. Если верхнеуровнего параметра тоже нет, функция вызывается без авторизации. 

## Спецификация расширения {#spec}

Пример спецификации: 

```
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
        function_id: b095c95icnvbuf4v755l
        tag: "$latest"
        service_account_id: ajehfe41hhliq4n93q1g
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
