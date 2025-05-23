---
title: Как изменить параметры Routing Instance в {{ cr-name }}
description: Следуя этой инструкции, вы сможете изменить параметры Routing Instance в {{ cr-name }}.
---

# Изменить параметры Routing Instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

В настоящее время доступно изменение следующих параметров Routing Instance:
* Название приватного соединения — `new-name`
* Описание приватного соединения — `description`

{% note info %}

Для изменения анонсов IP-префиксов и добавления (удаления) приватных соединений в RI рекомендуется использовать [отдельные команды](cr-cic-ops.md#ri) и не использовать опции `--vpc-net` и `--cic-prc` команды update.

{% endnote %}

Например, для изменения значения параметра `description` у Routing Instance необходимо выполнить следующие шаги.

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для изменения [Routing Instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance update  --help
      ```

  1. Измените значение параметра `description` для Routing Instance:

      ```bash
      yc cloudrouter routing-instance update c3l87**********1dpin \
        --description "My new RI description" \
        --async
      ```

      Ожидаемый результат:

      ```text
      id: al4r9**********4613n
      description: routing instance update
      created_at: "2025-04-08T21:21:33.106772882Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-08T21:21:33.106772882Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

  1. Проверьте значение изменяемого параметра после завершения выполнения операции:

     ```bash
     yc cloudrouter routing-instance get c3l87**********1dpin
     ```

{% endlist %}

