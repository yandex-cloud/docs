# Расширение x-yc-apigateway-integration:cloud_datasphere

Расширение `x-yc-apigateway-integration:cloud_datasphere` вызывает ноду {{ ml-platform-name }}, развернутую в виде отдельного микросервиса. В запросе к {{ api-gw-short-name }} должен быть JSON-объект, который содержит входные переменные, указанные при создании ноды, и их значения. В ответе от {{ api-gw-short-name }} будет JSON-объект, который содержит выходные переменные, указанные при создании ноды, и их значения, полученные после ее выполнения.

## Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание
----|----|----
`folder_id` | `string` | Идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан проект {{ ml-platform-name }} и развернута нода.
`node_id` | `string` | Идентификатор ноды {{ ml-platform-name }}.
`service_account_id` | `string` | Идентификатор сервисного аккаунта. Используется для авторизации при вызове ноды {{ ml-platform-name }}. Если параметр не указан, используется значение [верхнеуровнего параметра](./index.md#top-level) `service_account_id`.

## Спецификация расширения {#spec}

Пример спецификации:

```yaml
/node/call:
    post:
      summary: Call DataSphere Node
      operationId: callDatasphereNode
      tags:
        - datasphere
      x-yc-apigateway-integration:
        type: cloud_datasphere
        folder_id: b095c95icnvb********
        node_id: 244e0c20-74a7-4147-83ad-7fd7********
        service_account_id: ajehfe78asl********
```
