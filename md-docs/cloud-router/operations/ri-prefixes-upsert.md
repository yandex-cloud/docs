[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Router](../index.md) > [Пошаговые инструкции](index.md) > Управлять сетями и IP-префиксами в виртуальном маршрутизаторе

# Управлять сетями и IP-префиксами в виртуальном маршрутизаторе

## Изменить сети и IP-префиксы в виртуальном маршрутизаторе {#update-networks}

{% note info %}

Чтобы управлять сетями и IP-префиксами в Routing Instance, необходима [роль](../security/index.md#cloudrouter-editor) `cloud-router.editor`.

{% endnote %}

### Добавить новую облачную сеть в виртуальный маршрутизатор {#add-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [виртуальный маршрутизатор](../concepts/routing-instance.md).
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. В строке с виртуальным маршрутизатором нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Маршрутизируемые сети и префиксы** раскройте выпадающий список и выберите сеть, которую нужно добавить. При необходимости воспользуйтесь поиском.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  [Команда](../cli-ref/routing-instance/update-networks.md) Yandex Cloud CLI `yc cloudrouter routing-instance update-networks` позволяет одновременно управлять набором [анонсированных IP-префиксов](../concepts/announces.md) облачных [сетей](../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud, добавленных в [виртуальный маршрутизатор](../concepts/routing-instance.md), а также добавлять новые сети в виртуальный маршрутизатор и удалять имеющиеся.

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Посмотрите описание команды для управления сетями и IP-префиксами в Routing Instance:
     
     ```bash
     yc cloudrouter routing-instance update-networks --help
     ```
  1. Посмотрите список всех Routing Instance, имеющихся в каталоге:
     
     ```bash
     yc cloudrouter routing-instance list \
       --folder-id <идентификатор_каталога>
     ```
     
     Где `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором находится нужный Routing Instance.
     
     Результат:
     
     ```text
     +----------------------+------+----------+--------------------------------+
     |          ID          | NAME |  STATUS  |     PRIVATE CONNECTION ID      |
     +----------------------+------+----------+--------------------------------+
     | c3lgk007olse******** | ri1  | UPDATING | cf3or586ln29********,          |
     |                      |      |          | cf3uj9uph7b6********           |
     +----------------------+------+----------+--------------------------------+
     ```
  1. Посмотрите информацию о Routing Instance, указав его идентификатор:
     
     ```bash
     yc cloudrouter routing-instance get c3lgk007olse******** \
       --folder-id <идентификатор_каталога>
     ```
     
     Результат:
     
     
     ```text
     id: c3lgk007olse********
     name: ri1
     description: Routing instance 1
     folder_id: b1gt6g8ht345********
     region_id: ru-central1
     vpc_info:
       - vpc_network_id: enpcfncr6uld********
         az_infos:
           - manual_info:
               az_id: ru-central1-d
               prefixes:
                 - 192.168.7.0/24
           - manual_info:
               az_id: ru-central1-a
               prefixes:
                 - 192.168.2.0/24
           - manual_info:
               az_id: ru-central1-b
               prefixes:
                 - 192.168.15.0/24
       - vpc_network_id: enpt8ok6snlp********
         az_infos:
           - manual_info:
               az_id: ru-central1-a
               prefixes:
                 - 192.168.45.0/24
                 - 192.168.46.0/24
     cic_private_connection_info:
       - cic_private_connection_id: cf3or586ln29********
       - cic_private_connection_id: cf3uj9uph7b6********
     status: UPDATING
     created_at: "2025-12-23T07:30:19Z"
     ```
  1. Добавьте в виртуальный маршрутизатор новую сеть с анонсированным IP-префиксом, указав [идентификатор](../../vpc/operations/network-get-info.md) этой сети в поле `id` параметра `--add-vpc-net`:

      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <идентификатор_каталога> \
        --id c3lgk007olse******** \
        --add-vpc-net id=enpvt41bh5gk********,zone=ru-central1-a,ipv4-prefixes=192.168.100.0/24,192.168.101.0/24 \
        --async
      ```

      Результат:

      ```text
      id: foku4jbrp07i********
      description: routing instance update prefix mask
      created_at: "2025-12-23T08:35:04.852963002Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-12-23T08:35:04.852963002Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3lgk007olse********
      ```

      Где:
      
      * `id` — идентификатор операции, выполняемой с Routing Instance.
      * `description` — описание выполняемой операции
      * `created_by` — идентификатор субъекта, который выполняет операцию.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуем все операции с изменением ресурсов выполнять в этом режиме.

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация виртуального маршрутизатора изменилась:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
      ```text
      id: c3lgk007olse********
      name: ri1
      description: Routing instance 1
      folder_id: b1gt6g8ht345********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: enpcfncr6uldme5e5929
          az_infos:
            - manual_info:
                az_id: ru-central1-d
                prefixes:
                  - 192.168.7.0/24
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 192.168.2.0/24
            - manual_info:
                az_id: ru-central1-b
                prefixes:
                  - 192.168.15.0/24
        - vpc_network_id: enpt8ok6snlp********
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 192.168.45.0/24
                  - 192.168.46.0/24
        - vpc_network_id: enpvt41bh5gk********
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 192.168.100.0/24
                  - 192.168.101.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3or586ln29********
        - cic_private_connection_id: cf3uj9uph7b6********
      status: ACTIVE
      created_at: "2025-12-23T08:35:07Z"
      ```


      * `id` — идентификатор Routing Instance.
      * `name` — имя Routing Instance.
      * `description` — описание Routing Instance.
      * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан Routing Instance.
      * `region_id` — регион [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), в котором был создан Routing Instance.
      * `vpc_info` — список IP-префиксов, распределенный по [зонам доступности](../../overview/concepts/geo-scope.md). Для каждой зоны доступности префиксы указываются отдельно.
      * `cic_private_connection_info` — список приватных соединений, подключенных к Routing Instance.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. При изменении может находиться в состоянии `UPDATING`.
      * `created_at` — дата и время создания ресурса.

{% endlist %}

### Удалить имеющуюся облачную сеть из виртуального маршрутизатора {#remove-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится виртуальный маршрутизатор.
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. Выберите виртуальный маршрутизатор.
  1. В блоке **Маршрутизируемые сети и префиксы** рядом с облачной сетью нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Посмотрите описание команды для управления сетями и IP-префиксами в Routing Instance:
     
     ```bash
     yc cloudrouter routing-instance update-networks --help
     ```
  1. Посмотрите список всех Routing Instance, имеющихся в каталоге:
     
     ```bash
     yc cloudrouter routing-instance list \
       --folder-id <идентификатор_каталога>
     ```
     
     Где `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором находится нужный Routing Instance.
     
     Результат:
     
     ```text
     +----------------------+------+----------+--------------------------------+
     |          ID          | NAME |  STATUS  |     PRIVATE CONNECTION ID      |
     +----------------------+------+----------+--------------------------------+
     | c3lgk007olse******** | ri1  | UPDATING | cf3or586ln29********,          |
     |                      |      |          | cf3uj9uph7b6********           |
     +----------------------+------+----------+--------------------------------+
     ```
  1. Посмотрите информацию о Routing Instance, указав его идентификатор:
     
     ```bash
     yc cloudrouter routing-instance get c3lgk007olse******** \
       --folder-id <идентификатор_каталога>
     ```
     
     Результат:
     
     
     ```text
     id: c3lgk007olse********
     name: ri1
     description: Routing instance 1
     folder_id: b1gt6g8ht345********
     region_id: ru-central1
     vpc_info:
       - vpc_network_id: enpcfncr6uld********
         az_infos:
           - manual_info:
               az_id: ru-central1-d
               prefixes:
                 - 192.168.7.0/24
           - manual_info:
               az_id: ru-central1-a
               prefixes:
                 - 192.168.2.0/24
           - manual_info:
               az_id: ru-central1-b
               prefixes:
                 - 192.168.15.0/24
       - vpc_network_id: enpt8ok6snlp********
         az_infos:
           - manual_info:
               az_id: ru-central1-a
               prefixes:
                 - 192.168.45.0/24
                 - 192.168.46.0/24
     cic_private_connection_info:
       - cic_private_connection_id: cf3or586ln29********
       - cic_private_connection_id: cf3uj9uph7b6********
     status: UPDATING
     created_at: "2025-12-23T07:30:19Z"
     ```
  1. Удалите из виртуального маршрутизатора имеющуюся сеть:

      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <идентификатор_каталога> \
        --id c3lgk007olse******** \
        --delete-vpc-net-id id=enpt8ok6snlp******** \
        --async
      ```

      Результат:

      ```text
      id: fokg66rcqie1********
      description: routing instance update prefix mask
      created_at: "2025-12-23T08:53:09.626102995Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-12-23T08:53:09.626102995Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3lgk007olse********
      ```

      Где:
      
      * `id` — идентификатор операции, выполняемой с Routing Instance.
      * `description` — описание выполняемой операции
      * `created_by` — идентификатор субъекта, который выполняет операцию.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуем все операции с изменением ресурсов выполнять в этом режиме.

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация виртуального маршрутизатора изменилась:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
      ```text
      id: c3lgk007olse********
      name: ri1
      description: Routing instance 1
      folder_id: b1gt6g8ht345********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: enpcfncr6uldme5e5929
          az_infos:
            - manual_info:
                az_id: ru-central1-d
                prefixes:
                  - 192.168.7.0/24
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 192.168.2.0/24
            - manual_info:
                az_id: ru-central1-b
                prefixes:
                  - 192.168.15.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3or586ln29********
        - cic_private_connection_id: cf3uj9uph7b6********
      status: ACTIVE
      created_at: "2025-12-23T08:35:07Z"
      ```


      * `id` — идентификатор Routing Instance.
      * `name` — имя Routing Instance.
      * `description` — описание Routing Instance.
      * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан Routing Instance.
      * `region_id` — регион [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), в котором был создан Routing Instance.
      * `vpc_info` — список IP-префиксов, распределенный по [зонам доступности](../../overview/concepts/geo-scope.md). Для каждой зоны доступности префиксы указываются отдельно.
      * `cic_private_connection_info` — список приватных соединений, подключенных к Routing Instance.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. При изменении может находиться в состоянии `UPDATING`.
      * `created_at` — дата и время создания ресурса.

{% endlist %}

### Обновить IP-префиксы имеющихся облачных сетей в виртуальном маршрутизаторе {#update-prefixes}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится виртуальный маршрутизатор.
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. Выберите виртуальный маршрутизатор.
  1. В блоке **Маршрутизируемые сети и префиксы** рядом с облачной сетью нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**. В открывшемся окне:

     1. Отметьте подсети, в которых вы хотите изменить IP-префиксы.
     1. Измените необходимые IP-префиксы.
     1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Посмотрите описание команды для управления сетями и IP-префиксами в Routing Instance:
     
     ```bash
     yc cloudrouter routing-instance update-networks --help
     ```
  1. Посмотрите список всех Routing Instance, имеющихся в каталоге:
     
     ```bash
     yc cloudrouter routing-instance list \
       --folder-id <идентификатор_каталога>
     ```
     
     Где `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором находится нужный Routing Instance.
     
     Результат:
     
     ```text
     +----------------------+------+----------+--------------------------------+
     |          ID          | NAME |  STATUS  |     PRIVATE CONNECTION ID      |
     +----------------------+------+----------+--------------------------------+
     | c3lgk007olse******** | ri1  | UPDATING | cf3or586ln29********,          |
     |                      |      |          | cf3uj9uph7b6********           |
     +----------------------+------+----------+--------------------------------+
     ```
  1. Посмотрите информацию о Routing Instance, указав его идентификатор:
     
     ```bash
     yc cloudrouter routing-instance get c3lgk007olse******** \
       --folder-id <идентификатор_каталога>
     ```
     
     Результат:
     
     
     ```text
     id: c3lgk007olse********
     name: ri1
     description: Routing instance 1
     folder_id: b1gt6g8ht345********
     region_id: ru-central1
     vpc_info:
       - vpc_network_id: enpcfncr6uld********
         az_infos:
           - manual_info:
               az_id: ru-central1-d
               prefixes:
                 - 192.168.7.0/24
           - manual_info:
               az_id: ru-central1-a
               prefixes:
                 - 192.168.2.0/24
           - manual_info:
               az_id: ru-central1-b
               prefixes:
                 - 192.168.15.0/24
       - vpc_network_id: enpt8ok6snlp********
         az_infos:
           - manual_info:
               az_id: ru-central1-a
               prefixes:
                 - 192.168.45.0/24
                 - 192.168.46.0/24
     cic_private_connection_info:
       - cic_private_connection_id: cf3or586ln29********
       - cic_private_connection_id: cf3uj9uph7b6********
     status: UPDATING
     created_at: "2025-12-23T07:30:19Z"
     ```
  1. Обновите анонсированные IP-префиксы в виртуальном маршрутизаторе:

      
      ```bash
      yc cloudrouter routing-instance update-networks \
        --folder-id <идентификатор_каталога> \
        --id c3lgk007olse******** \
        --update-vpc-net id=enpcfncr6uld********,zone=ru-central1-a,ipv4-prefixes=192.168.2.0/28 \
        --update-vpc-net id=enpcfncr6uld********,zone=ru-central1-b,ipv4-prefixes=192.168.15.0/24 \
        --update-vpc-net id=enpcfncr6uld********,zone=ru-central1-d,ipv4-prefixes=192.168.7.0/24 \
        --update-vpc-net id=enpt8ok6snlp********,zone=ru-central1-d,ipv4-prefixes=192.168.47.0/28 \
        --async
      ```


      Результат:

      ```text
      id: fokr80vgdskp********
      description: routing instance update prefix mask
      created_at: "2025-12-23T09:56:40.259684884Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-12-23T09:56:40.259684884Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3lgk007olse********
      ```

      Где:
      
      * `id` — идентификатор операции, выполняемой с Routing Instance.
      * `description` — описание выполняемой операции
      * `created_by` — идентификатор субъекта, который выполняет операцию.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуем все операции с изменением ресурсов выполнять в этом режиме.

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация виртуального маршрутизатора изменилась:

      ```bash
      yc cloudrouter routing-instance get c3lgk007olse******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
      ```text
      id: c3lgk007olse********
      name: ri1
      description: Routing instance 1
      folder_id: b1gt6g8ht345********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: enpcfncr6uld********
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 192.168.2.0/28
            - manual_info:
                az_id: ru-central1-b
                prefixes:
                  - 192.168.15.0/24
            - manual_info:
                az_id: ru-central1-d
                prefixes:
                  - 192.168.7.0/24
        - vpc_network_id: enpt8ok6snlp********
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 192.168.47.0/28
      cic_private_connection_info:
        - cic_private_connection_id: cf3or586ln29********
        - cic_private_connection_id: cf3uj9uph7b6********
      status: ACTIVE
      created_at: "2025-12-23T10:46:55Z"
      ```


      * `id` — идентификатор Routing Instance.
      * `name` — имя Routing Instance.
      * `description` — описание Routing Instance.
      * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан Routing Instance.
      * `region_id` — регион [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), в котором был создан Routing Instance.
      * `vpc_info` — список IP-префиксов, распределенный по [зонам доступности](../../overview/concepts/geo-scope.md). Для каждой зоны доступности префиксы указываются отдельно.
      * `cic_private_connection_info` — список приватных соединений, подключенных к Routing Instance.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. При изменении может находиться в состоянии `UPDATING`.
      * `created_at` — дата и время создания ресурса.

{% endlist %}

## Добавить IP-префиксы в виртуальный маршрутизатор {#upsert-prefixes}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится виртуальный маршрутизатор.
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. Выберите виртуальный маршрутизатор.
  1. В блоке **Маршрутизируемые сети и префиксы** рядом с облачной сетью нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**. В открывшемся окне:

     1. Отметьте блоки с подсетями, в которых вы хотите добавить IP-префиксы.
     1. Введите необходимые IP-префиксы.
     1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  [Команда](../cli-ref/routing-instance/upsert-prefixes.md) Yandex Cloud CLI `yc cloudrouter routing-instance upsert-prefixes` позволяет [анонсировать новые IP-префиксы](../concepts/announces.md) в виртуальном маршрутизаторе.
  
  {% note tip %}
  
  Если вам необходимо добавить в виртуальный маршрутизатор новые IP-префиксы с одновременным удалением всех или части имеющихся в нем префиксов, [воспользуйтесь](#update-networks) командой `yc cloudrouter routing-instance update-networks`.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Посмотрите описание команды CLI для изменения списка IP-префиксов в [виртуальном маршрутизаторе](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance upsert-prefixes --help
      ```

  1. Посмотрите конфигурацию виртуального маршрутизатора и состав IP-префиксов:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <идентификатор_каталога>
      ```

      Где `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором находится нужный виртуальный маршрутизатор.

      Результат:

      ```text
      id: c3l871dpin4f********
      name: ri1
      description: Routing instance 1
      folder_id: b1gqfjiz2wda********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: c64ckjtr7b3l********
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 10.128.0.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3td2nufvr5********
      status: ACTIVE
      created_at: "2025-03-19T13:35:56Z"
      ```
  1. Добавьте дополнительные префиксы в список IP-префиксов виртуального маршрутизатора:

      {% note info %}
      
      Чтобы управлять сетями и IP-префиксами в Routing Instance, необходима [роль](../security/index.md#cloudrouter-editor) `cloud-router.editor`.
      
      {% endnote %}

      
      ```bash
      yc cloudrouter routing-instance upsert-prefixes c3l871dpin4f******** \
        --folder-id <идентификатор_каталога> \
        --vpc-net id=c64ckjtr7b3l********,zone=ru-central1-b,ipv4-prefixes=10.129.0.0/24 \
        --vpc-net id=c64ckjtr7b3l********,zone=ru-central1-d,ipv4-prefixes=172.16.1.0/24 \
        --async
      ```


      Результат:

      ```text
      id: al457njn6pj1********
      description: routing instance upsert prefixes
      created_at: "2025-03-24T15:24:15.817401507Z"
      created_by: bfbudv7dfn22********
      modified_at: "2025-03-24T15:24:15.817401507Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l871dpin4f********
      ```

      Где:
      
      * `id` — идентификатор операции, выполняемой с Routing Instance.
      * `description` — описание выполняемой операции
      * `created_by` — идентификатор субъекта, который выполняет операцию.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуем все операции с изменением ресурсов выполнять в этом режиме.

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация виртуального маршрутизатора изменилась:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
      ```
      id: c3l871dpin4f********
      name: ri1
      description: Routing instance 1
      folder_id: b1gqfjiz2wda********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: c64ckjtr7b3l********
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
        - cic_private_connection_id: cf3td2nufvr5********
      status: ACTIVE
      created_at: "2025-03-19T13:35:56Z"
      ```


      Где:

      * `id` — идентификатор Routing Instance.
      * `name` — имя Routing Instance.
      * `description` — описание Routing Instance.
      * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан Routing Instance.
      * `region_id` — регион [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), в котором был создан Routing Instance.
      * `vpc_info` — список IP-префиксов, распределенный по [зонам доступности](../../overview/concepts/geo-scope.md). Для каждой зоны доступности префиксы указываются отдельно.
      * `cic_private_connection_info` — список приватных соединений, подключенных к Routing Instance.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. При изменении может находиться в состоянии `UPDATING`.
      * `created_at` — дата и время создания ресурса.

{% endlist %}

## Удалить IP-префиксы из виртуального маршрутизатора {#remove-prefixes}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится виртуальный маршрутизатор.
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. Выберите виртуальный маршрутизатор.
  1. В блоке **Маршрутизируемые сети и префиксы** рядом с облачной сетью нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**. В открывшемся окне:

     1. Отметьте блоки с подсетями, из которых вы хотите удалить IP-префиксы.
     1. Нажмите значок ![xmark](../../_assets/console-icons/xmark.svg) рядом с префиксами, которые вы хотите удалить.
     1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  [Команда](../cli-ref/routing-instance/remove-prefixes.md) Yandex Cloud CLI `yc cloudrouter routing-instance remove-prefixes` позволяет удалить [анонсированные IP-префиксы](../concepts/announces.md) из виртуального маршрутизатора.
  
  {% note tip %}
  
  Если вам необходимо удалить имеющиеся IP-префиксы из виртуального маршрутизатора с одновременным добавлением в него новых префиксов, [воспользуйтесь](#update-networks) командой `yc cloudrouter routing-instance update-networks`.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Посмотрите описание команды CLI для удаления IP-префиксов из [виртуального маршрутизатора](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance remove-prefixes --help
      ```

  1. Посмотрите конфигурацию виртуального маршрутизатора и состав IP-префиксов:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <идентификатор_каталога>
      ```

      Где `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором находится нужный виртуальный маршрутизатор.

      Результат:

      
      ```text
      id: c3l871dpin4f********
      name: ri1
      description: Routing instance 1
      folder_id: b1gqfjiz2wda********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: c64ckjtr7b3l********
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
        - cic_private_connection_id: cf3td2nufvr5********
      status: ACTIVE
      created_at: "2025-03-19T13:35:56Z"
      ```


  1. Удалите IP-префиксы из виртуального маршрутизатора:

      {% note info %}
      
      Чтобы управлять сетями и IP-префиксами в Routing Instance, необходима [роль](../security/index.md#cloudrouter-editor) `cloud-router.editor`.
      
      {% endnote %}

      
      ```bash
      yc cloudrouter routing-instance remove-prefixes c3l871dpin4f******** \
        --folder-id <идентификатор_каталога> \
        --vpc-net id=c64ckjtr7b3l********,zone=ru-central1-b,ipv4-prefixes=10.128.0.0/24 \
        --vpc-net id=c64ckjtr7b3l********,zone=ru-central1-d,ipv4-prefixes=10.129.0.0/24 \
        --async
      ```


      Результат:

      ```text
      id: al457njn6pj1********
      description: routing instance remove prefixes
      created_at: "2025-03-24T15:24:15.817401507Z"
      created_by: bfbudv7dfn22********
      modified_at: "2025-03-24T15:24:15.817401507Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l871dpin4f********
      ```

      Где:
      
      * `id` — идентификатор операции, выполняемой с Routing Instance.
      * `description` — описание выполняемой операции
      * `created_by` — идентификатор субъекта, который выполняет операцию.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуем все операции с изменением ресурсов выполнять в этом режиме.

  1. Дождитесь [завершения](../../cli/cli-ref/operation/cli-ref/get.md) операции и убедитесь в том, что конфигурация виртуального маршрутизатора изменилась:

      ```bash
      yc cloudrouter routing-instance get c3l871dpin4f******** \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      
      ```text
      id: c3l871dpin4f********
      name: ri1
      description: Routing instance 1
      folder_id: b1gqfjiz2wda********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: c64ckjtr7b3l********
          az_infos:
            - manual_info:
                az_id: ru-central1-d
                prefixes:
                  - 172.16.1.0/24
      cic_private_connection_info:
        - cic_private_connection_id: cf3td2nufvr5********
      status: ACTIVE
      created_at: "2025-03-19T13:35:56Z"
      ```


      Где:

      * `id` — идентификатор Routing Instance.
      * `name` — имя Routing Instance.
      * `description` — описание Routing Instance.
      * `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан Routing Instance.
      * `region_id` — регион [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), в котором был создан Routing Instance.
      * `vpc_info` — список IP-префиксов, распределенный по [зонам доступности](../../overview/concepts/geo-scope.md). Для каждой зоны доступности префиксы указываются отдельно.
      * `cic_private_connection_info` — список приватных соединений, подключенных к Routing Instance.
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`. При изменении может находиться в состоянии `UPDATING`.
      * `created_at` — дата и время создания ресурса.

{% endlist %}