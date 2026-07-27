[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Router](../index.md) > [Пошаговые инструкции](index.md) > Создать виртуальный маршрутизатор

# Создать виртуальный маршрутизатор

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [виртуальный маршрутизатор](../concepts/routing-instance.md).
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. Нажмите кнопку **Создать виртуальный маршрутизатор**.
  1. Введите имя и описание виртуального маршрутизатора.
  1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md):

      1. Нажмите **Добавить метку**.
      1. Введите метку в формате `ключ: значение`.
      1. Нажмите **Enter**.

  1. (Опционально) Включите опцию **Защита от удаления**, чтобы защитить виртуальный маршрутизатор от непреднамеренного удаления.
  1. В поле **Приватные соединения** выберите необходимые [приватные соединения](../../interconnect/concepts/priv-con.md) или укажите их идентификаторы.
  1. В поле **Сети** выберите необходимые [сети](../../vpc/concepts/network.md).
  1. В появившемся блоке с сетью и ее подсетями добавьте IP-префиксы.
  1. Нажмите **Создать**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания [виртуального маршрутизатора](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance create --help
      ```

  1. Создайте виртуальный маршрутизатор в заданном каталоге:

      {% note info %}

      Для упрощения дальнейшей эксплуатации рекомендуется создавать виртуальный маршрутизатор в том же каталоге, где ранее создавались транковое подключение и приватное соединение.

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

  1. Проверить результат создания виртуального маршрутизатора:

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
      * `id` — идентификатор виртуального маршрутизатора.
      * `name` — название виртуального маршрутизатора.
      * `description` — описание виртуального маршрутизатора.
      * `folder_id` — идентификатор облачного каталога, в котором был создан виртуальный маршрутизатор.
      * `region_id` — регион облака, в котором был создан виртуальный маршрутизатор.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. В процессе создания может находиться в состоянии `CREATING`.
      * `created_at` — дата и время создания ресурса.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуется все операции с изменением ресурсов выполнять в этом режиме.

{% endlist %}