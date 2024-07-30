# Расширение x-yc-status-mapping

Расширение `x-yc-status-mapping` позволяет заменить код ответа в интеграции. Например, если в [интеграции с {{ objstorage-name }}](object-storage.md) вернулся код ответа 404, можно заменить его на 200.

Расширение предназначено для объекта `ResponseBody` из OpenAPI-спецификации. Значение расширения — новое значение кода ответа.

## Спецификация расширения {#spec}

Пример спецификации:

```json
paths:
  /:
    get:
      responses:
        200:
          description: ""
          content:
            ...
          x-yc-status-mapping: 201
      ...

```
