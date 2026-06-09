# Расширение x-yc-apigateway-integration:object_storage

Расширение `x-yc-apigateway-integration:object_storage` передает управление обработки запроса в Object Storage с целью раздачи статических файлов.

Добавить расширение в спецификацию можно с помощью [конструктора спецификаций](../../operations/spec-constructor/index.md).

## Поддерживаемые параметры {#parameters}

В таблице ниже перечислены параметры, специфичные для API-шлюза сервиса API Gateway. Описание остальных параметров читайте в [спецификации OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

Параметр | Тип | Описание 
----|----|----
`bucket` | `string` | Имя [бакета](../../../storage/concepts/bucket.md).
`object` | `string` | Имя [объекта](../../../storage/concepts/object.md). Поддерживается шаблонизация параметрами из пути исходного запроса. <br>В `object` осуществляется подстановка параметров.
`error_object` | `string \| ErrorObjectSettings` | Необязательный параметр. Имя [объекта](../../../storage/concepts/object.md) и опциональный код ответа, которые возвращаются, если `object` не существует в указанном `bucket`. В `error_object` осуществляется подстановка параметров.
`service_account_id` | `string` | Идентификатор сервисного аккаунта для авторизации при обращении к Object Storage. Если параметр не указан, используется значение [верхнеуровневого](index.md#top-level) параметра `service_account_id`. Если верхнеуровневого параметра тоже нет, объект доступен без авторизации.

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

* [Развертывание веб-приложения с использованием Java Servlet API](../../tutorials/java-servlet-todo-list.md)
* [Сокращатель ссылок](../../tutorials/serverless-url-shortener/index.md)
* [Как создать бота в Telegram](../../tutorials/telegram-bot-serverless/index.md)