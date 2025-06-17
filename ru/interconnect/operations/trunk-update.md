---
title: Как изменить транковое подключение в {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете изменить параметры в транковом подключении в {{ interconnect-name }}.
---

# Изменить параметры транкового подключения

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

В настоящее время пользователь самостоятельно может выполнить только ряд операций по изменению транкового подключения:
* Изменить название транка — `new-name`.
* Изменить описание транка — `description`.
* Установить или снять флаг защиты транка от удаления `deletion-protection`.

Все остальные действия по изменению параметров транкового подключения, в том числе [изменение емкости транкового подключения](../tutorials/trunk-capacity-change.md), по-прежнему выполняются только через обращение в техническую поддержку.

Например, для изменения названия транкового подключения необходимо выполнить следующие шаги.

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для изменения параметров [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection update  --help
      ```

  1. Измените название транкового подключения:

      ```bash
      yc cic trunk-connection update cf3td**********nufvr \
        --new-name my-new-trunk-name \
        --async
      ```

      Результат:

      
      ```text
      id: cf3td**********nufvr
      description: Trunk via M9
      created_at: "2025-03-27T09:43:00.880696489Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-03-27T09:43:00.969837738Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.UpdateTrunkConnectionMetadata
        trunk_connection_id: cf3td**********nufvr
      response:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.TrunkConnection
        id: cf3td**********nufvr
        name: my-new-trunk-name
        description: Trunk via M9
        folder_id: b1gqf**********jiz2w 
        region_id: {{ region-id }}
        single_port_direct_joint:
          transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
          port_name: 25GE1/0/12
        point_of_presence_id: ru-msk-m9-0
        capacity: CAPACITY_10_GBPS
        status: ACTIVE
      ```



{% endlist %}

