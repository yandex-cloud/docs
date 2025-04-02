# Расширение x-yc-apigateway-any-method

Расширение `x-yc-apigateway-any-method` определяет операции, которые выполняют все HTTP-методы, не определенные в спецификации.

## Поддерживаемые параметры {#parameters}

В таблице ниже перечислены параметры, специфичные для API-шлюза сервиса API Gateway. Описание остальных параметров читайте в [спецификации OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

Параметр | Тип | Описание
----|----|----
`x-yc-apigateway-integration`|[x-yc-apigateway-integration](./index.md#integration)| Точка входа для интеграции API-шлюза с другими сервисами.


## Спецификация расширения {#spec}

Пример спецификации:

```yaml
/example/{ID}:
    x-yc-apigateway-any-method:
      summary: Operating with examples
      operationId: example
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

## Примеры использования {#examples}

* [{#T}](../../tutorials/deploy-app-container.md)