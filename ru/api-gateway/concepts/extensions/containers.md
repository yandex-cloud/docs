# Расширение x-yc-apigateway-integration:serverless_containers

Расширение `x-yc-apigateway-integration:serverless_containers` перенаправляет запрос в указанный [контейнер](../../../serverless-containers/concepts/container.md).

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание
----|----|----
`container_id` | `string` | Идентификатор контейнера.
`service_account_id` | `string` | Идентификатор сервисного аккаунта для авторизации при обращении к контейнеру. Если параметр не указан, используется значение [верхнеуровнего](./index.md#top-level) параметра `service_account_id`.
`context` | `object` | Необязательный параметр. Контекст операции — произвольный объект в формате `YAML` или `JSON`. Кодируется в `Base64` и передается в контейнер в заголовке `X-Yc-ApiGateway-Operation-Context`. В `context` осуществляется подстановка параметров.

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
        type: serverless_containers
        container_id: b095c95icnvbuf4v755l
        service_account_id: ajehfe12hhlas4n56q1
```
