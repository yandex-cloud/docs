---
title: Как удалить IP-префиксы из Routing Instance в {{ cr-name }}
description: Следуя этой инструкции, вы сможете удалить IP-префиксы из Routing Instance в {{ cr-name }}.
---

# Удалить IP-префиксы из Routing Instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для удаления IP-префиксов из [Routing Instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance remove-prefixes --help
      ```

  1. Проверить конфигурацию Routing Instance и состав IP-префиксов:

     ```bash
     yc cloudrouter routing-instance upsert-prefixes c3l87**********1dpin
     ```

     Ожидаемый результат:

     
     ```
     id: c3l87**********1dpin
     name: ri1
     description: Routing instance 1
     folder_id: b1gqf**********jiz2w
     region_id: {{ region-id }}
     vpc_info:
       - vpc_network_id: c64ck**********jtr7b
         az_infos:
           - manual_info:
               az_id: ru-central1-a
               prefixes:
                 - 10.128.0.0/24
          - manual_info:
               az_id: ru-central1-b
               prefixes:
                 - 10.129.0.0/24
           - manual_info:
               az_id: ru-central1-d
               prefixes:
                 - 172.16.1.0/24
     cic_private_connection_info:
       - cic_private_connection_id: cf3td**********nufvr
     status: ACTIVE
     created_at: "2025-03-19T13:35:56Z"
     ```




  1. Удалить IP-префиксы из Routing Instance:

     
     ```bash
     yc cloudrouter routing-instance remove-prefixes c3l87**********1dpin \
       --vpc-net id=c64ck**********jtr7b,zone={{ region-id }}-b,ipv4-prefixes=10.128.0.0/24 \
       --vpc-net id=c64ck**********jtr7b,zone={{ region-id }}-d,ipv4-prefixes=10.129.0.0/24 \
       --async
     ```




     Ожидаемый результат:

     ```text
      id: al457**********njn6p
      description: routing instance remove prefixes
      created_at: "2025-03-24T15:24:15.817401507Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-03-24T15:24:15.817401507Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

     где,
      * `id` — идентификатор операции, выполняемой с Routing Instance.
      * `description` — описание выполняемой операции
      * `created_by` — идентификатор субъекта, который выполняет операцию.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуется все операции с изменением ресурсов выполнять в этом режиме.


  1. Проверить изменения в конфигурации Routing Instance после выполненных изменений:

     ```bash
     yc cloudrouter routing-instance get c3l87**********1dpin
     ```

     Ожидаемый результат:

     
     ```
     id: c3l87**********1dpin
     name: ri1
     description: Routing instance 1
     folder_id: b1gqf**********jiz2w
     region_id: {{ region-id }}
     vpc_info:
       - vpc_network_id: c64ck**********jtr7b
         az_infos:
           - manual_info:
               az_id: {{ region-id }}-d
               prefixes:
                 - 172.16.1.0/24
     cic_private_connection_info:
       - cic_private_connection_id: cf3td**********nufvr
     status: ACTIVE
     created_at: "2025-03-19T13:35:56Z"
     ```




     где,
      * `id` — идентификатор Routing Instance.
      * `name` — название Routing Instance.
      * `description` — описание Routing Instance.
      * `folder_id` — идентификатор облачного каталога, в котором был создан Routing Instance.
      * `region_id` — регион облака, в котором был создан Routing Instance.
      * `vpc_info` — список IP-префиксов, распределенный по зонам доступности. Для каждой зоны префиксы указываются отдельно.
      * `cic_private_connection_info` — список приватных соединений, подключенных к Routing Instance.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. При изменении может находиться в состоянии `UPDATING`.
      * `created_at` — дата и время создания ресурса.

{% endlist %}

