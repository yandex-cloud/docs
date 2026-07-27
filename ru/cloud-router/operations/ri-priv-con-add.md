---
title: Как добавить приватное соединение в виртуальный маршрутизатор в {{ cr-name }}
description: Следуя этой инструкции, вы сможете добавить приватное соединение в виртуальный маршрутизатор в {{ cr-name }}.
---

# Добавить приватное соединение в виртуальный маршрутизатор

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [виртуальный маршрутизатор](../concepts/routing-instance.md).
  1. [Перейдите]({{ link-console-main }}/link/cloud-router) в сервис **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. В строке с виртуальным маршрутизатором нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **Приватные соединения** выберите [приватные соединения](../../interconnect/concepts/priv-con.md), которые необходимо добавить, или укажите их идентификаторы.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для добавления [приватного соединения](../../interconnect/concepts/priv-con.md) в [виртуальный маршрутизатор](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance add-private-connection --help
      ```

  1. Добавить нужное приватное соединение в виртуальный маршрутизатор:

     ```bash
     yc cloudrouter routing-instance add-private-connection c3l87**********1dpin \
       --cic-prc b1gqf**********jiz2w \ 
       --async
     ```

     Ожидаемый результат:

     ```text
      id: fokrf**********ml058
      description: routing instance add private connection
      created_at: "2025-04-16T12:43:54.507531644Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-16T12:43:54.507531644Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

     где,
      * `id` — идентификатор операции, выполняемой с виртуальным маршрутизатором.
      * `created_by` — идентификатор субъекта, который выполняет операцию.


  1. Проверить изменения в конфигурации виртуального маршрутизатора:

     ```bash
     yc cloudrouter routing-instance get c3l87**********1dpin
     ```

     Ожидаемый результат:

     ```
     id: c3l87**********1dpin
     name: ri1-preprod
     description: Routing instance 1
     folder_id: b1gqf**********jiz2w
     region_id: {{ region-id }}
     cic_private_connection_info:
       - cic_private_connection_id: cf3td**********nufvr
     status: ACTIVE
     created_at: "2025-03-19T13:35:56Z"
     ```

     где,
      * `id` — идентификатор виртуального маршрутизатора.
      * `name` — название виртуального маршрутизатора.
      * `description` — описание виртуального маршрутизатора.
      * `folder_id` — идентификатор облачного каталога, в котором был создан виртуальный маршрутизатор.
      * `region_id` — регион облака, в котором был создан виртуальный маршрутизатор.
      * `cic_private_connection_info` — список приватных соединений в данном виртуальном маршрутизаторе.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. При изменении может находиться в состоянии `UPDATING`.
      * `created_at` — дата и время создания ресурса.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуется все операции с изменением ресурсов выполнять в этом режиме.

{% endlist %}
