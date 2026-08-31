[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Router](../index.md) > [Пошаговые инструкции](index.md) > Удалить приватное соединение из виртуального маршрутизатора

# Удалить приватное соединение из виртуального маршрутизатора

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [виртуальный маршрутизатор](../concepts/routing-instance.md).
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. В строке с виртуальным маршрутизатором нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В поле **Приватные соединения** нажмите значок ![xmark](../../_assets/console-icons/xmark.svg) рядом с [приватными соединениями](../../interconnect/concepts/priv-con.md), которые необходимо удалить.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для удаления [приватного соединения](../../interconnect/concepts/priv-con.md) из [виртуального маршрутизатора](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance remove-private-connection --help
      ```

  1. Удалите нужное приватное соединение из виртуального маршрутизатора:

     ```bash
     yc cloudrouter routing-instance remove-private-connection c3l87**********1dpin \
       --cic-prc cf3r5ke20fo0******** \
       --async
     ```

     Ожидаемый результат:

      ```text
      id: kofrd**********dp325
      description: routing instance remove private connection
      created_at: "2025-04-16T12:43:54.507531644Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-16T12:43:54.507531644Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

     Где:

      * `id` — идентификатор операции, выполняемой с виртуальным маршрутизатором.
      * `created_by` — идентификатор субъекта, который выполняет операцию.

  1. Проверьте изменения в конфигурации виртуального маршрутизатора:

     ```bash
     yc cloudrouter routing-instance get c3l87**********1dpin
     ```

     Ожидаемый результат:

     ```
     id: c3l87**********1dpin
     name: ri1-preprod
     description: Routing instance 1
     folder_id: b1gqf**********jiz2w
     region_id: ru-central1
     cic_private_connection_info:
     status: ACTIVE
     created_at: "2025-03-19T13:35:56Z"
     ```

     Где:

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