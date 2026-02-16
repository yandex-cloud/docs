# Расширение x-yc-apigateway-integration:object_storage

Расширение `x-yc-apigateway-integration:object_storage` передает управление обработки запроса в {{ objstorage-short-name }} с целью раздачи статических файлов.

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`bucket` | `string` | Имя [бакета](../../../storage/concepts/bucket.md).
`object` | `string` | Имя [объекта](../../../storage/concepts/object.md). Поддерживается шаблонизация параметрами из пути исходного запроса. <br>В `object` осуществляется подстановка параметров.
`error_object` | `string \| ErrorObjectSettings` | Необязательный параметр. Имя [объекта](../../../storage/concepts/object.md) и опциональный код ответа, которые возвращаются, если `object` не существует в указанном `bucket`. В `error_object` осуществляется подстановка параметров.
`service_account_id` | `string` | Идентификатор сервисного аккаунта для авторизации при обращении к {{ objstorage-short-name }}. Если параметр не указан, используется значение [верхнеуровневого](./index.md#top-level) параметра `service_account_id`. Если верхнеуровневого параметра тоже нет, объект доступен без авторизации.

Объект `ErrorObjectSettings` может содержать следующие параметры:

Параметр | Тип | Описание
----|----|----
`object` | `string` | Имя [объекта](../../../storage/concepts/object.md). В `object` осуществляется подстановка параметров.
`statusCode` | `number` |  Возвращаемый код ответа.


## Спецификация расширения {#spec}

Пример спецификации: 

```yaml
  /static/{file}:
    get:
      summary: Serve static file from Yandex Cloud Object Storage
      parameters:
        - name: file
          in: path
          required: true
          schema:
            type: string
      x-yc-apigateway-integration:
        type: object_storage
        bucket: <имя_бакета>
        object: '{file}'
        error_object: error.html
        service_account_id: ajehfe65fhl********
```

## Примеры использования {#examples}

* [{#T}](../../tutorials/java-servlet-todo-list.md)
* [{#T}](../../tutorials/serverless-url-shortener.md)
* [{#T}](../../tutorials/telegram-bot-serverless.md)
