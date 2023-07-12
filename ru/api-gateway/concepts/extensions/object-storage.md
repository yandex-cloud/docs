# Расширение x-yc-apigateway-integration:object_storage

Расширение `x-yc-apigateway-integration:object_storage` передает управление обработки запроса в {{ objstorage-short-name }} с целью раздачи статических файлов.

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`bucket` | `string` | Имя [бакета](../../../storage/concepts/bucket.md).
`object` |`string` | Имя [объекта](../../../storage/concepts/object.md). Поддерживается шаблонизация параметрами из пути исходного запроса. <br>В `object` осуществляется подстановка параметров.
`error_object` |`string` | Необязательный параметр. Имя [объекта](../../../storage/concepts/object.md), который возвращается, если вместо `object` получена ошибка с HTTP-кодом 4xx.
`service_account_id` | `string` | Идентификатор сервисного аккаунта для авторизации при обращении к {{ objstorage-short-name }}. Если параметр не указан, используется значение [верхнеуровнего](./index.md#top-level) параметра `service_account_id`. Если верхнеуровнего параметра тоже нет, объект доступен без авторизации.


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
