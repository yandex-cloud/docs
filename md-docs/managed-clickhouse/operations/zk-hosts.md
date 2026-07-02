[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление хостами > Управление хостами ZooKeeper

# Управление хостами ZooKeeper


ZooKeeper — это сервис, который обеспечивает координацию и распределение запросов между хостами ClickHouse® для [репликации данных](../concepts/replication.md). Для обеспечения репликации в кластере Managed Service for ClickHouse® должно быть [три или пять хостов ZooKeeper](../qa/cluster-settings.md#zookeeper-hosts-number). Такой кластер будет отказоустойчивым.

Если вы создаете кластер с двумя или более хостами ClickHouse® на шард и включенным [сервисом координации](../concepts/coordination-system.md) ZooKeeper, в кластер автоматически добавятся три хоста ZooKeeper. При создании вы можете настроить только их конфигурацию. Если вы создали кластер из одного хоста или нескольких однохостовых шардов и выключенным сервисом координации, хосты ZooKeeper можно добавить позднее.

Подробнее о работе хостов ZooKeeper читайте в разделе [ZooKeeper](../concepts/coordination-system.md#zk).

Вы можете выполнить следующие действия при управлении хостами ZooKeeper:

* [получить список хостов в кластере](#list-hosts);
* [добавить хосты ZooKeeper](#add-zk);
* [изменить настройки хостов ZooKeeper](#update-zk-settings);
* [перезагрузить хост](#restart);
* [преобразовать нереплицируемые таблицы в реплицируемые](#replicated-tables);
* [удалить хост](#delete-zk-host).

О том, как перенести хосты ZooKeeper в другую [зону доступности](../../overview/concepts/geo-scope.md), читайте в [инструкции](host-migration.md#zookeeper-hosts).

## Получить список хостов в кластере {#list-hosts}

# Получить список хостов в кластере

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  yc managed-clickhouse host list \
     --cluster-name=<имя_кластера>
  ```

  ```text
  +----------------------------+--------------+---------+--------+---------------+
  |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------------+--------------+---------+--------+---------------+
  | rc1b...mdb.yandexcloud.net | c9qp71dk1... | MASTER  | ALIVE  | ru-central1-b |
  | rc1a...mdb.yandexcloud.net | c9qp71dk1... | REPLICA | ALIVE  | ru-central1-a |
  +----------------------------+--------------+---------+--------+---------------+
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>"
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListHosts
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse).

{% endlist %}


## Добавить хосты ZooKeeper {#add-zk}

{% note info %}

В [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-d` недоступно использование платформы Intel Broadwell.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. Справа сверху нажмите **Настроить сервис координации**.
  1. Укажите [класс хостов](../concepts/instance-types.md).
  1. Задайте настройки хранилища.
  1. При необходимости измените настройки хостов ZooKeeper. Чтобы это сделать, наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/console-icons/pencil.svg).
  1. Чтобы преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables), включите настройку **Преобразовать нереплицируемые таблицы**. Нереплицируемые таблицы на движке семейства [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication).

     {% note warning %}

     После включения этой настройки ее нельзя отключить.

     {% endnote %}

  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы добавить в кластер хосты ZooKeeper:
  1. Посмотрите описание команды CLI для добавления хостов ZooKeeper:

     ```bash
     yc managed-clickhouse cluster add-zookeeper --help
     ```

  1. Запустите операцию с характеристиками хостов по умолчанию:

     ```bash
     yc managed-clickhouse cluster add-zookeeper <имя_кластера> \
        --host zone-id=ru-central1-d,subnet-name=default-d \
        --host zone-id=ru-central1-a,subnet-name=default-a \
        --host zone-id=ru-central1-b,subnet-name=default-b
     ```

     Если в сети, в которой расположен кластер, ровно 3 подсети, по одной в каждой зоне доступности, то явно указывать подсети для хостов необязательно: Managed Service for ClickHouse® автоматически распределит хосты по этим подсетям.

     Чтобы преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables), добавьте в команду параметр `--convert-tables-to-replicated`. Нереплицируемые таблицы на движке семейства [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication).

     {% note warning %}

     После включения этой настройки ее нельзя отключить.

     {% endnote %}

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Чтобы добавить в кластер хосты ZooKeeper:

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

  1. Добавьте в конфигурационный файл три подсети в разные зоны доступности:

     ```hcl
     resource "yandex_vpc_network" "<имя_сети>" {
       name = "<имя_сети>"
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_ru-central1-a>" {
       name           = "<имя_подсети_в_зоне_ru-central1-a>"
       zone           = "ru-central1-a"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_ru-central1-a>" ]
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_ru-central1-b>" {
       name           = "<имя_подсети_в_зоне_ru-central1-b>"
       zone           = "ru-central1-b"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_ru-central1-b>" ]
     }

     resource "yandex_vpc_subnet" "<имя_подсети_в_зоне_ru-central1-d>" {
       name           = "<имя_подсети_в_зоне_ru-central1-d>"
       zone           = "ru-central1-d"
       network_id     = yandex_vpc_network.<имя_сети>.id
       v4_cidr_blocks = [ "<диапазон_адресов_подсети_в_зоне_ru-central1-d>" ]
     }
     ```
      
  1. Добавьте к описанию кластера ClickHouse®:
      
     * блок `zookeeper` с конфигурацией ZooKeeper;
     * не менее трех хостов ZooKeeper в блок `hosts`.
      
     Три хоста ZooKeeper должны быть размещены в разных зонах доступности.
      
     Требования к хостам ZooKeeper:

     * Минимальный класс хоста — `b1.medium`.
     * Тип диска — `network-ssd`.
     * Минимальный размер хранилища — 10 гигабайт.

     Пример конфигурационного файла:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
       ...
       zookeeper = {
         resources = {
           resource_preset_id = "<класс_хостов>"
           disk_type_id       = "network-ssd"
           disk_size          = <размер_хранилища_ГБ>
         }
       }
       
       hosts = {
         ...
         <имя_хоста_1> = {
           type      = "ZOOKEEPER"
           zone      = "ru-central1-a"
           subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_ru-central1-a>.id
         }
         <имя_хоста_2> = {
           type      = "ZOOKEEPER"
           zone      = "ru-central1-b"
           subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_ru-central1-b>.id
         }
         <имя_хоста_3> = {
           type      = "ZOOKEEPER"
           zone      = "ru-central1-d"
           subnet_id = yandex_vpc_subnet.<имя_подсети_в_зоне_ru-central1-d>.id
         }
       }
     }
     ```

     Где `resource_preset_id` — класс хоста: `b1.medium` или выше.

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

  Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
  * изменение — 90 минут;
  * удаление — 30 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
    ...
    timeouts = {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
      delete = "30m"   # 30 минут
    }
  }
  ```
  
  {% endcut %}
  
  {% endnote %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Cluster.AddZookeeper](../api-ref/Cluster/addZookeeper.md) и выполните запрос, например с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>:addZookeeper' \
        --data '{
                 "resources": {
                   "resourcePresetId": "<класс_хостов>",
                   "diskSize": "<размер_хранилища_в_байтах>",
                   "diskTypeId": "<тип_диска>"
                 },
                 "hostSpecs": [
                   {
                     "type": "ZOOKEEPER",
                     "zoneId": "<зона_доступности>",
                     "subnetId": "<идентификатор_подсети>"
                   },
                   { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
                   { ... },
                   { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
                 ],
                 "convertTablesToReplicated": true
               }'
      ```
  
      Где:
  
      * `resources` — набор ресурсов для хостов ZooKeeper:
  
        * `resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md);
        * `diskSize` — размер диска в байтах;
        * `diskTypeId` — [тип диска](../concepts/storage.md).
  
      * `hostSpecs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста, в кластере должно быть минимум три хоста ZooKeeper. Элемент массива имеет следующую структуру:
  
        * `type` — тип хоста `ZOOKEEPER`;
        * `zoneId` — зона доступности;
        * `subnetId` — идентификатор подсети.
  
      * `convertTablesToReplicated` — преобразование нереплицируемых таблиц в [реплицируемые](../concepts/replication.md#replicated-tables): `true` или `false`. Нереплицируемые таблицы на движке семейства [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication).
  
        {% note warning %}
  
        После включения этой настройки ее нельзя отключить.
  
        {% endnote %}
  
      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addZookeeper.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [ClusterService.AddZookeeper](../api-ref/grpc/Cluster/addZookeeper.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
               "cluster_id": "<идентификатор_кластера>",
               "resources": {
                 "resource_preset_id": "<класс_хостов>",
                 "disk_size": "<размер_хранилища_в_байтах>",
                 "disk_type_id": "<тип_диска>"
               },
               "host_specs": [
                 {
                   "type": "ZOOKEEPER",
                   "zone_id": "<зона_доступности>",
                   "subnet_id": "<идентификатор_подсети>"
                 },
                 { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
                 { ... },
                 { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
               ],
               "convert_tables_to_replicated": true
             }' \
         mdb.api.cloud.yandex.net:443 \
         yandex.cloud.mdb.clickhouse.v1.ClusterService.AddZookeeper
       ```
  
      Где:
  
      * `resources` — набор ресурсов для хостов ZooKeeper:
  
        * `resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md);
        * `disk_size` — размер диска в байтах;
        * `disk_type_id` — [тип диска](../concepts/storage.md).
  
      * `host_specs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста, в кластере должно быть минимум три хоста ZooKeeper.
  
        Элемент массива имеет следующую структуру:
  
        * `type` — тип хоста `ZOOKEEPER`;
        * `zone_id` — зона доступности;
        * `subnet_id` — идентификатор подсети.
  
      * `convert_tables_to_replicated` — преобразование нереплицируемых таблиц в [реплицируемые](../concepts/replication.md#replicated-tables): `true` или `false`. Нереплицируемые таблицы на движке семейства [MergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication).
  
        {% note warning %}
  
        После включения этой настройки ее нельзя отключить.
  
        {% endnote %}
  
      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addZookeeper.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки хостов ZooKeeper {#update-zk-settings}

После создания хостов ZooKeeper вы можете изменить их [класс](../concepts/instance-types.md), размер хранилища и [тип диска](../concepts/storage.md).

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

Минимальное количество ядер для одного хоста ZooKeeper зависит от суммарного количества ядер хостов ClickHouse®. Подробнее в разделе [Сервисы координации](../concepts/coordination-system.md#zk).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. В блоке **Класс хоста ZooKeeper** выберите платформу, тип виртуальной машины и нужный класс хоста ZooKeeper.
  1. В блоке **Размер хранилища ZooKeeper** задайте размер хранилища и тип диска для хостов ZooKeeper.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить конфигурацию хостов ZooKeeper:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-clickhouse cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     ```bash
     yc managed-clickhouse resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

  1. В команде изменения кластера передайте новый класс хоста ZooKeeper, тип диска и размер хранилища:

     ```bash
     yc managed-clickhouse cluster update <имя_или_идентификатор_кластера> \
        --zookepeer-resource-preset=<класс_хостов> \
        --zookeeper-disk-size=<размер_хранилища_ГБ> \
        --zookeeper-disk-type=<тип_диска>
     ```

     Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Чтобы изменить настройки хостов ZooKeeper:

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

  1. В блоке с конфигурацией ZooKeeper укажите новый класс хоста, тип диска и размер хранилища.

     Требования к хостам ZooKeeper:
     * Минимальный класс хоста — `b1.medium`.
     * Минимальный размер хранилища — 10 гигабайт.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
       ...
       zookeeper = {
         resources = {
           resource_preset_id = "<класс_хостов>"
           disk_type_id       = "<тип_диска>"
           disk_size          = <размер_хранилища_ГБ>
         }
       }
       ...
     }
     ```

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

  Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
  * изменение — 90 минут;
  * удаление — 30 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
    ...
    timeouts = {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
      delete = "30m"   # 30 минут
    }
  }
  ```
  
  {% endcut %}
  
  {% endnote %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Запросите список доступных классов хостов:

      1. Воспользуйтесь методом [ResourcePreset.List](../api-ref/ResourcePreset/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/resourcePresets'
          ```

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#responses).

  1. Измените класс хостов, тип диска и размер хранилища:

      1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

          {% note warning %}
          
          Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
          
          {% endnote %}

          ```bash
          curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
              --data '{
                        "updateMask": "configSpec.zookeeper.resources.resourcePresetId,configSpec.zookeeper.resources.diskTypeId,configSpec.zookeeper.resources.diskSize",
                        "configSpec": {
                          "zookeeper": {
                            "resources": {
                              "resourcePresetId": "<класс_хостов>",
                              "diskTypeId": "<тип_диска>",
                              "diskSize": "<размер_хранилища_ГБ>"
                            }
                          }
                        }
                      }'
          ```

          Где:

          * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

              Укажите нужные параметры:
              * `configSpec.zookeeper.resources.resourcePresetId` — если нужно изменить класс хостов ZooKeeper.
              * `configSpec.zookeeper.resources.diskTypeId` — если нужно изменить тип диска для хостов ZooKeeper.
              * `configSpec.zookeeper.resources.diskSize` — если нужно изменить размер хранилища ZooKeeper.

          * `configSpec.zookeeper.resources.resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md).
          * `configSpec.zookeeper.resources.diskTypeId` — [тип диска](../concepts/storage.md).
          * `configSpec.zookeeper.resources.diskSize` — размер хранилища в гигабайтах.

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Запросите список доступных классов хостов:

      1. Воспользуйтесь вызовом [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/resource_preset_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              mdb.api.cloud.yandex.net:443 \
              yandex.cloud.mdb.clickhouse.v1.ResourcePresetService.List
          ```

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.clickhouse.v1.ListResourcePresetsResponse).

  1. Измените класс хостов, тип диска и размер хранилища:

      1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

          {% note warning %}
          
          Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
          
          {% cut "Формат перечисления настроек" %}
          
          ```yaml
          "update_mask": {
              "paths": [
                  "<настройка_1>",
                  "<настройка_2>",
                  ...
                  "<настройка_N>"
              ]
          }
          ```
          
          {% endcut %}
          
          {% endnote %}

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                      "paths": [
                        "config_spec.zookeeper.resources.resource_preset_id",
                        "config_spec.zookeeper.resources.disk_type_id",
                        "config_spec.zookeeper.resources.disk_size"
                      ]
                    },
                    "config_spec": {
                      "zookeeper": {
                        "resources": {
                          "resource_preset_id": "<класс_хостов>",
                          "disk_type_id": "<тип_диска>",
                          "disk_size": "<размер_хранилища_ГБ>"
                        }
                      }
                    }
                  }' \
              mdb.api.cloud.yandex.net:443 \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
          ```

          Где:

          * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

              Укажите нужные параметры:
              * `config_spec.zookeeper.resources.resource_preset_id` — если нужно изменить класс хостов ZooKeeper.
              * `config_spec.zookeeper.resources.disk_type_id` — если нужно изменить тип диска для хостов ZooKeeper.
              * `config_spec.zookeeper.resources.disk_size` — если нужно изменить размер хранилища ZooKeeper.

          * `config_spec.zookeeper.resources.resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md).
          * `config_spec.zookeeper.resources.disk_type_id` — [тип диска](../concepts/storage.md).
          * `config_spec.zookeeper.resources.disk_size` — размер хранилища в гигабайтах.

          Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Перезагрузить хост ZooKeeper {#restart}

# Перезагрузить хост

Перезагрузка хостов может понадобиться, если нужно экстренно устранить такие проблемы, как:

* перерасход ресурсов;
* утечка памяти;
* взаимоблокировка (deadlock) между запросами;
* зависание операций и внутренних процессов ClickHouse®.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перезагрузить один хост:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
    1. В строке нужного хоста нажмите на значок ![icon](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Перезагрузить**.
    1. В открывшемся окне включите опцию **Я перезагружаю хост** и нажмите кнопку **Подтвердить**.

  Чтобы перезагрузить несколько хостов сразу:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
    1. Выберите хосты, которые хотите перезагрузить, и нажмите **Перезагрузить** в нижней части экрана.
    1. В открывшемся окне нажмите кнопку **Подтвердить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы перезагрузить один или несколько хостов, выполните команду, передав их имена. Используйте пробел в качестве разделителя.

  Команда для перезагрузки одного хоста выглядит так:

  ```bash
  yc managed-clickhouse host restart <имя_хоста> \
     --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со списком хостов в кластере, имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.RestartHosts](../api-ref/Cluster/restartHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:restartHosts' \
            --data '{
                      "hostNames": [
                        <перечень_имен_хостов>
                      ]
                    }'
        ```

        Где `hostNames` — массив строк. Каждая строка — имя хоста, который нужно перезагрузить. Имена хостов можно запросить со [списком хостов в кластере](hosts.md#list-hosts).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/restartHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.RestartHosts](../api-ref/grpc/Cluster/restartHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "host_names": [
                      <перечень_имен_хостов>
                    ]
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.RestartHosts
        ```

        Где `host_names` — массив строк. Каждая строка — имя хоста, который нужно перезагрузить. Имена хостов можно запросить со [списком хостов в кластере](hosts.md#list-hosts).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Преобразовать нереплицируемые таблицы в реплицируемые {#replicated-tables}

Преобразовать нереплицируемые таблицы на движке семейства MergeTree в [реплицируемые](../concepts/replication.md#replicated-tables) на движке ReplicatedMergeTree можно:

* автоматически при включении сервиса координации;
* с помощью SQL после включения сервиса координации.

Подробнее о движках таблиц читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family). 

{% list tabs group=instructions %}

- Автоматически {#auto}

  Чтобы автоматически преобразовать нереплицируемые таблицы в реплицируемые, [добавьте хосты ZooKeeper](#add-zk) с включенным преобразованием таблиц.

- SQL {#sql}

  Чтобы преобразовать нереплицируемую таблицу в реплицируемую:

  1. Сделайте таблицу недоступной для использования:
    
      ```sql
      DETACH TABLE <имя_таблицы>;
      ```

  1. Преобразуйте таблицу в реплицируемую:

      ```sql
      ATTACH TABLE <имя_таблицы> AS REPLICATED;
      ```

  1. Восстановите и синхронизируйте состояние реплики таблицы в ZooKeeper:

      ```sql
      SYSTEM RESTORE REPLICA <имя_таблицы>;
      ```

{% endlist %}

## Удалить хост ZooKeeper {#delete-zk-host}

{% note warning %}

Если в кластере уже созданы хосты ZooKeeper, то удалить их полностью невозможно — в кластере всегда будет минимум три хоста ZooKeeper.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  1. Наведите курсор на строку нужного хоста и нажмите на значок ![image](../../_assets/console-icons/xmark.svg).
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  yc managed-clickhouse hosts delete <имя_хоста> \
    --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](hosts.md#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- Terraform {#tf}

   [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
   
   Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
   
   Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

   Чтобы удалить хост ZooKeeper:

   1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, в разделе [Создание кластера](cluster-create.md).

   1. Удалите хост с типом `ZooKeeper` из блока `hosts`.
   1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

   1. Введите слово `yes` и нажмите **Enter**.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

   Подробнее в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

   {% note warning "Ограничения по времени" %}
   
   Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for ClickHouse®:
   
   * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
   * изменение — 90 минут;
   * удаление — 30 минут.
   
   Операции, длящиеся дольше указанного времени, прерываются.
   
   {% cut "Как изменить эти ограничения?" %}
   
   Добавьте к описанию кластера блок `timeouts`, например:
   
   ```hcl
   resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
     ...
     timeouts = {
       create = "1h30m" # Полтора часа
       update = "2h"    # 2 часа
       delete = "30m"   # 30 минут
     }
   }
   ```
   
   {% endcut %}
   
   {% endnote %}


- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Воспользуйтесь методом [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):
  
      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
          --data '{
                    "hostNames": [
                      <перечень_имен_хостов>
                    ]
                  }'
      ```
  
      Где `hostNames` — массив строк. Каждая строка — имя хоста, который нужно удалить. Имена хостов можно запросить со [списком хостов в кластере](#list-hosts).
  
      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```
  
  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  
  1. Воспользуйтесь вызовом [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "host_names": [
                    <перечень_имен_хостов>
                  ]
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
      ```
  
      Где `host_names` — массив строк. Каждая строка — имя хоста, который нужно удалить. Имена хостов можно запросить со [списком хостов в кластере](#list-hosts).
  
      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._