# Расширение x-yc-apigateway-integration:serverless_containers

Расширение `x-yc-apigateway-integration:serverless_containers` вызывает указанный [контейнер](../../../serverless-containers/concepts/container.md) и передает в него HTTP-запрос, адресованный к API-шлюзу. В заголовке `Host` при этом указывается хост, по которому пользователь обратился к API-шлюзу, а не хост контейнера.

{% include [ip](../../../_includes/serverless-containers/ip.md) %}

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание
----|----|----
`container_id` | `string` | Идентификатор контейнера.
`service_account_id` | `string` | Идентификатор сервисного аккаунта для авторизации при обращении к контейнеру. Сервисный аккаунт необходим для [вызова](../../../serverless-containers/operations/auth.md) приватного контейнера — для этого он должен иметь [роль](../../../serverless-containers/security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker` или выше на этот контейнер. Если параметр не указан, используется значение [верхнеуровневого](./index.md#top-level) параметра `service_account_id`.
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
        container_id: b095c95icnvb********
        service_account_id: ajehfe12hhl********
```

Пример проксирования всех запросов в контейнер:

```yaml
paths:
  /{proxy+}:
    x-yc-apigateway-any-method:
      x-yc-apigateway-integration:
        type: serverless_containers
        container_id: bba0hocqr8rl********
        service_account_id: ajegj8fnpmkm********
      parameters:
      - explode: false
        in: path
        name: proxy
        required: false
        schema:
          default: '-'
          type: string
        style: simple
```

## Примеры использования {#examples}

* [{#T}](../../tutorials/deploy-app-container.md)