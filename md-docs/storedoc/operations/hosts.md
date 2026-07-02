[Документация Yandex Cloud](../../index.md) > [Yandex StoreDoc](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление хостами кластера

# Управление хостами кластера Yandex StoreDoc

Вы можете добавлять и удалять [хосты кластера](../concepts/index.md), запускать повторную синхронизацию хостов, а также [управлять настройками Yandex StoreDoc](update.md) для отдельных кластеров. О том, как перенести хосты кластера в другую зону доступности, читайте в [инструкции](host-migration.md).

## Получить список хостов в кластере {#list-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера Yandex StoreDoc.
  1. Выберите вкладку **Хосты**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список хостов в кластере Yandex StoreDoc, выполните команду:

  ```bash
  yc managed-mongodb host list \
    --cluster-name <имя_кластера>
  ```

  Результат:

  
  ```text
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  |           NAME             |      CLUSTER ID      |  TYPE  | SHARD NAME |     ROLE     |  HEALTH  |    ZONE ID    | PUBLIC IP |
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  | rc1b...mdb.yandexcloud.net | c9qp71dk1q1w******** | MONGOD | rs01       | PRIMARY      | ALIVE    | ru-central1-b | false     |
  | rc1a...mdb.yandexcloud.net | c9qp71dk1q1w******** | MONGOD | rs01       | SECONDARY    | ALIVE    | ru-central1-a | false     |
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  ```


  Имя кластера Yandex StoreDoc можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>/hosts'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse).

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
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.mongodb.v1.ClusterService.ListHosts
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse).    

{% endlist %}

## Добавить хост {#add-host}

Количество хостов в кластерах Yandex StoreDoc ограничено квотами на количество CPU и объем памяти, которые доступны кластерам базы данных в вашем [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud). Чтобы проверить используемые ресурсы, откройте страницу [Квоты](https://console.yandex.cloud/cloud?section=quotas) и найдите блок **Yandex StoreDoc**.

Вы можете добавлять в кластер Yandex StoreDoc хосты разных типов. Их количество зависит от [типа шардирования](../concepts/sharding.md#shard-management):

{#hosts-table}

Тип шардирования | MONGOD | MONGOINFRA | MONGOS | MONGOCFG
--- | --- | --- | --- | ---
Без шардирования | ⩾ 1 | — | — | —
Стандартный | ⩾ 1 | ⩾ 3 | — | —
Расширенный | ⩾ 1 | — | ⩾ 2 | ⩾ 3

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы добавить хост в кластере Yandex StoreDoc:
  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера Yandex StoreDoc и перейдите на вкладку **Хосты**.
  1. Нажмите кнопку **Создать хост**.
  1. Укажите параметры хоста:
     * [Зону доступности](../../overview/concepts/geo-scope.md).

     
     * [Подсеть](../../vpc/concepts/network.md#subnet) (если нужной подсети в списке нет, создайте ее).     

     * Выберите опцию **Публичный доступ**, если хост должен быть доступен извне Yandex Cloud.


     * Тип хоста и название шарда, если в кластере Yandex StoreDoc включено шардирование.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы добавить хост в кластере Yandex StoreDoc:

  
  1. Запросите список подсетей кластера Yandex StoreDoc, чтобы выбрать [подсеть](../../vpc/concepts/network.md#subnet) для нового хоста:

     ```bash
     yc vpc subnet list
     ```

     Результат:

     ```text
     +----------------------+-----------+-----------------------+---------------+------------------+
     |          ID          |   NAME    |       NETWORK ID      |       ZONE    |      RANGE       |
     +----------------------+-----------+-----------------------+---------------+------------------+
     | b0cl69a2b4c6******** | default-d | enp6rq72rndgr******** | ru-central1-d | [172.16.0.0/20]  |
     | e2lkj9qwe762******** | default-b | enp6rq72rndgr******** | ru-central1-b | [10.10.0.0/16]   |
     | e9b0ph42bn96******** | a-2       | enp6rq72rndgr******** | ru-central1-a | [172.16.32.0/20] |
     | e9b9v22r88io******** | default-a | enp6rq72rndgr******** | ru-central1-a | [172.16.16.0/20] |
     +----------------------+-----------+-----------------------+---------------+------------------+
     ```

     Если нужной подсети в списке нет, создайте ее.


  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     yc managed-mongodb host add --help
     ```

  1. Выполните команду добавления хоста:

      
      ```bash
      yc managed-mongodb host add \
        --cluster-name <имя_кластера> \
        --host zone-id=<зона_доступности>,`
              `subnet-id=<идентификатор_подсети>,`
              `assign-public-ip=<публичный_доступ>,`
              `hidden=<скрытие_хоста>,`
              `secondary-delay-secs=<отставание_реплики_в_секундах>,`
              `priority=<приоритет_хоста>
      ```


      Где:

      * `--cluster-name` — имя кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `--host` — параметры хоста:
          * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).

          
          * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Его необходимо указать, если в [зоне доступности](../../overview/concepts/geo-scope.md) больше одной подсети, в противном случае Yandex StoreDoc автоматически выберет единственную подсеть.
          * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


          * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
          * `secondary-delay-secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
          * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

      Yandex StoreDoc запустит операцию добавления хоста.


- Terraform {#tf}

  Чтобы добавить хост в кластере Yandex StoreDoc:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера Yandex StoreDoc:
     * Ресурсы, соответствующие типу шардирования, если вы добавляете хост в шардированный кластер:
       * `resources_mongoinfra` — для стандартного шардирования.
       * `resources_mongos` и `resources_mongocfg` — для расширенного шардирования.
     * Блок `host`.

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       ...
       resources_mongod {
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       resources_mongoinfra { # Добавьте для стандартного шардирования.
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       resources_mongos { # Добавьте для расширенного шардирования.
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       resources_mongocfg { # Добавьте для расширенного шардирования.
         resource_preset_id = "<класс_хоста>"
         disk_type_id       = "<тип_диска>"
         disk_size          = <размер_хранилища_ГБ>
       }

       host {
         role             = "<тип_реплики>"
         zone_id          = "<зона_доступности>"
         subnet_id        = "<идентификатор_подсети>"
         assign_public_ip = <публичный_доступ>
         shard_name       = "<имя_шарда>"
         type             = "<тип_хоста>"
         host_parameters {
           hidden               = <скрытие_хоста>
           secondary_delay_secs = <отставание_реплики_в_секундах>
           priority             = <приоритет_хоста>
         }
         ...
       }
     }
     ```

     Где:

     * `host` — параметры хоста:
       * `role` — тип реплики: `PRIMARY` или `SECONDARY`.
       * `zone_id` — зона доступности.
       * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
       * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
       * `shard_name` — имя шарда в шардированном кластере.
       * `type` — тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`.
       * `host_parameters` — дополнительные параметры хоста:
           * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
           * `secondary_delay_secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
           * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

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

  Подробнее читайте в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
  * изменение — 60 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
    ...
    timeouts {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
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

  1. Воспользуйтесь методом [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      
      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
          --data '{
                    "hostSpecs": [
                      {
                        "zoneId": "<зона_доступности>",
                        "subnetId": "<идентификатор_подсети>",
                        "assignPublicIp": <публичный_доступ_к_хосту>,
                        "type": "<тип_хоста>",
                        "shardName": "<имя_шарда>",
                        "hidden": <скрытие_хоста>,
                        "secondaryDelaySecs": "<отставание_реплики_в_секундах>",
                        "priority": "<приоритет_хоста>",
                        "tags": "<метки_хоста>"
                      }
                    ]
                  }'
      ```


      Где `hostSpecs` — параметры хоста:

      * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).

      
      * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
      * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


      * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`. Если кластер нешардированный, укажите `MONGOD`.
      * `shardName` — имя шарда в шардированном кластере.
      * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
      * `secondaryDelaySecs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
      * `priority` — * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
      * `secondaryDelaySecs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
      * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).
      * `tags`— метки хоста.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      
      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "host_specs": [
                  {
                    "zone_id": "<зона_доступности>",
                    "subnet_id": "<идентификатор_подсети>",
                    "assign_public_ip": <публичный_доступ_к_хосту>,
                    "type": "<тип_хоста>",
                    "shard_name": "<имя_шарда>",
                    "hidden": <скрытие_хоста>,
                    "secondary_delay_secs": "<отставание_реплики_в_секундах>",
                    "priority": "<приоритет_хоста>",
                    "tags": "<метки_хоста>"
                  }
                ]
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.AddHosts
      ```


      Где `host_specs` — параметры хоста:

      * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

      
      * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
      * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


      * `type`— тип хоста в шардированном кластере: `MONGOD`, `MONGOINFRA`, `MONGOS` или `MONGOCFG`. Если кластер нешардированный, укажите `MONGOD`.
      * `shard_name` — имя шарда в шардированном кластере.
      * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
      * `secondaryDelaySecs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
      * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).
      * `tags`— метки хоста.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера Yandex StoreDoc настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Изменить хост {#update}

{% list tabs group=instructions %}

* CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить параметры хоста в кластере, выполните команду:

    
    ```bash
    yc managed-mongodb host update \
      --cluster-name <имя_кластера> \
      --host hostname=<имя_хоста>,`
            `assign-public-ip=<публичный_доступ_к_хосту>,`
            `hidden=<скрытие_хоста>,`
            `secondary-delay-secs=<отставание_реплики_в_секундах>,`
            `priority=<приоритет_хоста>
    ```


    Где:

    * `--cluster-name` — имя кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    * `--host` — параметры хоста:
        * `hostname` — имя изменяемого хоста. Его можно запросить со [списком хостов в кластере](#list).

        
        * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


        * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
        * `secondary-delay-secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
        * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).


* Terraform {#tf}

    Чтобы изменить параметры хоста в кластере:

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL приведен в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

    1. Измените в описании кластера Managed Service for PostgreSQL атрибуты блока `host`, соответствующего изменяемому хосту.

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          host {
            assign_public_ip = <публичный_доступ_к_хосту>
            host_parameters {
              hidden               = <скрытие_хоста>
              secondary_delay_secs = <отставание_реплики_в_секундах>
              priority             = <приоритет_хоста>
            }
          }
        }
        ```

    Где:

    * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
    * `host_parameters` — дополнительные параметры хоста:
        * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
        * `secondary_delay_secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
        * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
        
        * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
        * изменение — 60 минут.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          timeouts {
            create = "1h30m" # Полтора часа
            update = "2h"    # 2 часа
          }
        }
        ```
        
        {% endcut %}
        
        {% endnote %}


* REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        
        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>/hosts:batchUpdate' \
          --data '{
                    "updateHostSpecs": [
                      {
                        "updateMask": "hostName,assignPublicIp,hidden,secondaryDelaySecs,priority",
                        "hostName": "<имя_хоста>",
                        "assignPublicIp": <публичный_доступ_к_хосту>,
                        "hidden": <скрытие_хоста>,
                        "secondaryDelaySecs": "<отставание_реплики_в_секундах>",
                        "priority": "<приоритет_хоста>"
                      }
                    ]
                  }'
        ```


        Где `updateHostSpecs` — параметры хоста:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
        * `hostName` — имя изменяемого хоста. Его можно запросить со [списком хостов в кластере](#list-hosts).

        
        * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


        * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
        * `secondaryDelaySecs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
        * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

* gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_host_specs": [
                  {
                    "update_mask": {
                        "paths": [
                          "assign_public_ip",
                          "hidden",
                          "secondary_delay_secs",
                          "priority"
                        ]
                    },
                    "host_name": "<имя_хоста>",
                    "assign_public_ip": <публичный_доступ_к_хосту>,
                    "hidden": <скрытие_хоста>,
                    "secondary_delay_secs": "<отставание_реплики_в_секундах>",
                    "priority": "<приоритет_хоста>"
                  }
                ]
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.UpdateHosts
        ```


        Где `update_host_specs` — параметры хоста:

        * `update_mask` — перечень изменяемых параметров в одну строку через запятую.
        * `host_name` — имя изменяемого хоста. Его можно запросить со [списком хостов в кластере](#list-hosts).

        
        * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


        * `hidden` — скрытие хоста: `true` или `false`. Если хост скрыт, он будет доступен для чтения только для прямых подключений (например, чтобы делать с него резервные копии, не добавляя нагрузки на кластер).
        * `secondary_delay_secs` — отставание реплики от мастера в секундах. Может быть полезно для восстановления данных в случае ошибочных операций.
        * `priority` — [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить хост {#remove-host}

Вы можете удалить хост `MONGOD` из кластера Yandex StoreDoc, если он не является единственным хостом. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

Если хост является первичным в момент удаления, Yandex StoreDoc автоматически выберет новую первичную реплику.

Также в кластере Yandex StoreDoc с [включенным шардированием](shards.md#enable) допустимо удалить хосты `MONGOS`, `MONGOCFG` или `MONGOINFRA`, если их в кластере больше, чем [минимальное количество](#hosts-table), которое требуется для обеспечения работы шардирования.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить хост из кластера Yandex StoreDoc:
  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера Yandex StoreDoc и выберите вкладку **Хосты**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **Удалить**.
  1. В открывшемся окне отметьте опцию **Я удаляю хост** и нажмите кнопку **Подтвердить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить хост из кластера Yandex StoreDoc, выполните команду:

  ```bash
  yc managed-mongodb host delete <имя_хоста>
       --cluster-name <имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере Yandex StoreDoc](#list-hosts), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

  Чтобы удалить хост из кластера Yandex StoreDoc:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера Yandex StoreDoc блок `host`, соответствующий удаляемому хосту.
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

  Подробнее читайте в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
  * изменение — 60 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
    ...
    timeouts {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
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
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
          --data '{
                    "hostNames": [
                      "<имя_хоста>"
                    ]
                  }'
      ```

      Где `hostNames` — массив с именами удаляемых хостов. Чтобы узнать имя нужного хоста, [получите список хостов в кластере](#list-hosts).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "host_names": [
                  "<имя_хоста>"
                ]
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.DeleteHosts
      ```

      Где `host_names` — массив с именами удаляемых хостов. Чтобы узнать имя нужного хоста, [получите список хостов в кластере](#list-hosts).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

## Запустить ресинхронизацию хоста {#resetup}

Чтобы повторно синхронизировать хост с остальными репликами в кластере или шарде Yandex StoreDoc, выполните операцию принудительной синхронизации. Операция применяется только к одному хосту `MONGOD` за раз и только для кластеров Yandex StoreDoc с более чем двумя репликами, независимо от класса и типа хостов. Ресинхронизация также позволяет освободить хранилище хоста от коллекций и документов, которые помечены как удаленные.

При выполнении этой операции:
1. Хост перестает принимать запросы на запись. Если хост был первичной репликой (`PRIMARY`), Yandex StoreDoc попытается сделать его вторичной репликой (`SECONDARY`). В случае неудачи операция прерывается.
1. Инстанс Yandex StoreDoc на хосте останавливается, и все данные удаляются.
1. Инстанс Yandex StoreDoc снова запускается и заново скачивает данные с хостов-реплик.
1. После синхронизации с другими репликами в кластере Yandex StoreDoc хост становится вторичной репликой.

   {% note info %}

   * Во время синхронизации хост не сможет полноценно отвечать на запросы, так как на нем будет находиться только часть данных кластера Yandex StoreDoc.
   * Оценочная скорость синхронизации: от 300 ГБ в сутки.

   {% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы запустить принудительную ресинхронизацию хоста:
  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера Yandex StoreDoc и выберите вкладку **Хосты**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **Ресинхронизировать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы запустить принудительную ресинхронизацию хоста, выполните команду:

  ```bash
  yc managed-mongodb hosts resetup <имя_хоста>
     --cluster-name <имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в каталоге](hosts.md#list-hosts). Имя кластера Yandex StoreDoc можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [Cluster.ResetupHosts](../api-ref/Cluster/resetupHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:resetupHosts' \
          --data '{
                    "hostNames": [
                      "<имя_хоста>"
                    ]
                  }'
      ```

      Где `hostNames` — массив с именами хостов, которые будут синхронизированы повторно. Чтобы узнать имя нужного хоста, [получите список хостов в кластере](#list-hosts).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/resetupHosts.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.ResetupHosts](../api-ref/grpc/Cluster/resetupHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "host_names": [
                  "<имя_хоста>"
                ]
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.ResetupHosts
      ```

      Где `host_names` — массив с именами хостов, которые будут синхронизированы повторно. Чтобы узнать имя нужного хоста, [получите список хостов в кластере](#list-hosts).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/resetupHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

## Перезагрузить хост {#restart}

Вы можете вручную перезагрузить хост кластера Yandex StoreDoc.

Перезагрузка может привести к временной недоступности кластера или [шарда](../concepts/sharding.md) Yandex StoreDoc:
* Если в кластере только один хост.
* Если хост является [первичной репликой](../concepts/replication.md).

При перезагрузке первичной реплики не происходит ее автоматического переключения. Чтобы избежать недоступности кластера Yandex StoreDoc, [переключите первичную реплику](stepdown.md) кластера до ее перезагрузки.

{% note info %}

Вы можете перезагрузить только один хост за раз.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы перезагрузить хост:
  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера Yandex StoreDoc и выберите вкладку **Хосты**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **Перезагрузить**.
  1. Подтвердите перезагрузку хоста.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы перезагрузить хост, выполните команду:

  ```bash
  yc managed-mongodb hosts restart <имя_хоста> \
    --cluster-name <имя_кластера>
  ```

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
          --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:restartHosts' \
          --data '{
                    "hostNames": [
                      "<имя_хоста>"
                    ]
                  }'
      ```

      Где `hostNames` — массив с именами хостов, которые будут перезапущены. Чтобы узнать имя нужного хоста, [получите список хостов в кластере](#list-hosts).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "host_names": [
                  "<имя_хоста>"
                ]
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.RestartHosts
      ```

      Где `host_names` — массив с именами хостов, который будут перезапущены. Чтобы узнать имя нужного хоста, [получите список хостов в кластере](#list-hosts).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/restartHosts.md#yandex.cloud.operation.Operation).

{% endlist %}