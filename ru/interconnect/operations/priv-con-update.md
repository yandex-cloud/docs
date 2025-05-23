---
title: Как изменить параметры приватного соединения в {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете изменить параметры в приватном соединении в {{ interconnect-name }}.
---

# Изменить параметры приватного соединения

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

В настоящее время доступно изменение следующих параметров приватного соединения:
* Название приватного соединения — `new-name`
* Описание приватного соединения — `description`
* Параметр `trunk-id`
* Параметр `vlan-id`
* Группа параметров IP/BGP связности `ipv4-peering`

Например, для изменения значения параметра `vlan-id` у приватного соединения необходимо выполнить следующие шаги.

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для изменения [приватного соединения](../concepts/priv-con.md):

      ```bash
      yc cic private-connection update  --help
      ```

  1. Измените значение параметра `vlan-id` для приватного соединения:

      ```bash
      yc cic private-connection update cca59**********dvjir \
        --vlan-id 201 \
        --async
      ```

      Ожидаемый результат:

      ```text
      id: al4r9**********4613n
      description: private connection update
      created_at: "2025-04-08T21:21:33.106772882Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-08T21:21:33.106772882Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.UpdatePrivateConnectionMetadata
        private_connection_id: cca59**********dvjir
      ```

  1. Проверьте значение изменяемого параметра после завершения выполнения операции:

     ```bash
     yc cic private-connection get cca59**********dvjir
     ```

{% endlist %}

