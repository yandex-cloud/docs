# Расширение x-yc-apigateway-integration:cloud_datasphere

Расширение `x-yc-apigateway-integration:cloud_datasphere` вызывает ноду DataSphere, развернутую в виде отдельного микросервиса. В запросе к API Gateway должен быть JSON-объект, который содержит входные переменные, указанные при создании ноды, и их значения. В ответе от API Gateway будет JSON-объект, который содержит выходные переменные, указанные при создании ноды, и их значения, полученные после ее выполнения.

Добавить расширение в спецификацию можно с помощью [конструктора спецификаций](../../operations/spec-constructor/index.md).

## Поддерживаемые параметры {#parameters}

В таблице ниже перечислены параметры, специфичные для API-шлюза сервиса API Gateway. Описание остальных параметров читайте в [спецификации OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

Параметр | Тип | Описание
----|----|----
`folder_id` | `string` | Идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан проект DataSphere и развернута нода.
`node_id` | `string` | Идентификатор ноды DataSphere.
`service_account_id` | `string` | Идентификатор сервисного аккаунта. Используется для авторизации при вызове ноды DataSphere. Если параметр не указан, используется значение [верхнеуровневого параметра](index.md#top-level) `service_account_id`.

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