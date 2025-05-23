---
title: Как создать Routing Instance в {{ cr-name }}
description: Следуя этой инструкции, вы сможете создать Routing Instance в {{ cr-name }}.
---

# Создать Routing Instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания [Routing Instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance create --help
      ```

  1. Создайте Routing Instance в заданном каталоге:

      {% note info %}

      Для упрощения дальнейшей эксплуатации рекомендуется создавать Routing Instance в том же каталоге, где ранее создавались транковое подключение и приватное соединение.

      {% endnote %}

      ```bash
      yc cloudrouter routing-instance create --name ri1 \
        --description "Routing instance 1" \ 
        --folder-id b1gqf**********jiz2w \
        --async
      ```

      Ожидаемый результат:

      ```text
      id: fokrf**********ml058
      description: routing instance create
      created_at: "2025-04-16T12:43:54.507531644Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-16T12:43:54.507531644Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.CreateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

  1. Проверить результат создания Routing Instance:
     
      ```text
      yc cloudrouter routing-instance get c3l87**********1dpin
      id: c3l87**********1dpin
      name: ri1
      description: Routing instance 1
      folder_id: b1gqf**********jiz2w
      region_id: ru-central1
      status: ACTIVE
      created_at: "2025-04-16T12:43:55Z"
      ```

      где,
      * `id` — идентификатор Routing Instance.
      * `name` — название Routing Instance.
      * `description` — описание Routing Instance.
      * `folder_id` — идентификатор облачного каталога, в котором был создан Routing Instance.
      * `region_id` — регион облака, в котором был создан Routing Instance.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. В процессе создания может находиться в состоянии `CREATING`.
      * `created_at` — дата и время создания ресурса.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуется все операции с изменением ресурсов выполнять в этом режиме.

{% endlist %}

