# Расширение x-yc-apigateway-integration:object_storage

Расширение `x-yc-apigateway-integration:object_storage` передает управление обработки запроса в {{ objstorage-short-name }} с целью раздачи статических файлов. Позволяет управлять ключом для доступа к объекту и реализует возможность раздавать статические данные напрямую из {{ objstorage-short-name }}, используя перенаправление на подписанный URL.

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`bucket` | `string` | Имя [бакета](../../../storage/concepts/bucket.md).
`object` |`string` | Имя [объекта](../../../storage/concepts/object.md). Поддерживается шаблонизация параметрами из пути исходного запроса. <br>В `object` осуществляется подстановка параметров.
`presigned_redirect` | `bool` | Если значение — `true`, генерирует [подписанный (pre-signed) URL](../../../storage/concepts/pre-signed-urls.md) и возвращает перенаправление клиенту.
`service_account_id` | `string` | Идентификатор сервисного аккаунта для авторизации при обращении к {{ objstorage-short-name }}. Если параметр не указан, используется значение [верхнеуровнего](./index.md#top-level) параметра `service_account_id`. Если верхнеуровнего параметра тоже нет, функция вызывается без авторизации. 


## Спецификация расширения {#spec}

Пример спецификации: 

```(json)
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
        bucket: my-example-bucket
        object: '{file}'
        presigned_redirect: true
        service_account_id: ajehfe41hhliq4n93q1g
```
