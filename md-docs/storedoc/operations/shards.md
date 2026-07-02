[Документация Yandex Cloud](../../index.md) > [Yandex StoreDoc](../index.md) > [Пошаговые инструкции](index.md) > Шардирование и репликация > Управление шардами

# Управление шардами Yandex StoreDoc

Кластер можно [создать шардированным](cluster-create.md#creating-a-sharded-cluster) либо [включить шардирование](#enable) позже. Затем можно [добавлять и настраивать шарды](#add-shard).

Для повышения доступности шарды должны состоять как минимум из трех хостов `MONGOD`. Небольшие коллекции обычно нет смысла шардировать: скорость обработки запросов будет выше в обычном кластере реплик.

{% note alert %}

После того как [шардирование кластера](../concepts/sharding.md) включено:
* Выключить шардирование невозможно. В кластере всегда будет поддерживаться минимальное количество хостов `MONGOS`, `MONGOCFG` или `MONGOINFRA` в зависимости от [типа шардирования](../concepts/sharding.md#shard-management).
* Обращаться к базам данных следует только через хосты `MONGOS` или `MONGOINFRA`, которые маршрутизируют запросы к шардам. Измените адреса хостов в коде ваших приложений соответствующим образом.

{% endnote %}

## Включить шардирование {#enable}

Через интерфейс Yandex StoreDoc вы можете быстро создать [инфраструктуру шардирования Yandex StoreDoc](../concepts/sharding.md#shard-management).

О том, как непосредственно шардировать базу и коллекции Yandex StoreDoc, читайте в разделе [Шардирование коллекций](../tutorials/sharding.md).

Для включения шардирования необходимо:
* Не менее трех хостов `MONGOINFRA` при стандартном шардировании.
* Не менее двух хостов `MONGOS` и не менее трех хостов `MONGOCFG` при расширенном шардировании.

{% note info %}

Шардирование [не поддерживается](../concepts/sharding.md#shard-management) для хостов с классами **b1.medium** и **b2.medium**. Если у вас нет вкладки **Шарды**, [повысьте класс хостов кластера](update.md#change-resource-preset) до поддерживаемого.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.
  1. Нажмите кнопку **Включить**.
  1. Выберите один из типов шардирования:
     * **Стандартное** — с использованием хостов `MONGOINFRA`.
     * **Расширенное** — с использованием хостов `MONGOS` и `MONGOCFG`.

       Подробнее читайте в разделе [Шардирование](../concepts/sharding.md).

     {% note warning %}

     После включения шардирования будет невозможно поменять его тип.

     {% endnote %}

  1. Задайте параметры хостов, которые будут обеспечивать доступ к шардированным данным.
  1. Нажмите кнопку **Включить шардирование**.

  Кластер начнет обновляться, при этом будут созданы запрошенные хосты, а также первый шард кластера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  * Чтобы включить стандартное шардирование кластера с использованием хостов `MONGOINFRA`, выполните команду (в примере приведены не все доступные параметры):

    ```bash
    yc managed-mongodb cluster enable-sharding \
      --cluster-name=<имя_кластера> \
      --host type=mongoinfra,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongoinfra,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongoinfra,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --mongoinfra resource-preset=<класс_хоста>,`
        `disk-size=<размер_хранилища_ГБ>,`
        `disk-type=<тип_диска>
    ```

    Где:
    * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list).
    * `--host` — параметры хоста:
      * `type` — тип (`MONGOINFRA`).
      * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
      * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).
    * `--mongoinfra` — параметры хостов `MONGOINFRA`:
      * `resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `disk-size` — размер хранилища в гигабайтах.
      * `disk-type` — [тип диска](../concepts/storage.md).

  * Чтобы включить расширенное шардирование кластера с использованием хостов `MONGOS` и `MONGOCFG`, выполните команду (в примере приведены не все доступные параметры):

    ```bash
    yc managed-mongodb cluster enable-sharding \
      --cluster-name=<имя_кластера> \
      --host type=mongos,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongos,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --mongos resource-preset=<класс_хоста>,`
        `disk-size=<размер_хранилища_ГБ>,`
        `disk-type=<тип_диска> \
      --host type=mongocfg,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongocfg,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --host type=mongocfg,`
        `zone-id=<зона_доступности>,`
        `subnet-name=<имя_подсети> \
      --mongocfg resource-preset=<класс_хоста>,`
        `disk-size=<размер_хранилища_ГБ>,`
        `disk-type=<тип_диска>
    ```

    Где:
    * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list).
    * `--host` — параметры хоста:
      * `type` — тип (`MONGOS` или `MONGOCFG`).
      * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
      * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).
    * `--mongos` — параметры хостов `MONGOS`:
      * `resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `disk-size` — размер хранилища в гигабайтах.
      * `disk-type` — [тип диска](../concepts/storage.md).
    * `--mongocfg` — параметры хостов `MONGOCFG`:
      * `resource-preset` — [класс хоста](../concepts/instance-types.md).
      * `disk-size` — размер хранилища в гигабайтах.
      * `disk-type` — [тип диска](../concepts/storage.md).

- Terraform {#tf}

  1. Убедитесь, что установленная версия провайдера — 0.90 или выше:
     
     ```bash
     terraform version
     ```
     
     Пример результата:
     
     ```text
     Terraform v1.4.6
     on darwin_arm64
     + provider registry.terraform.io/yandex-cloud/yandex v0.91.0
     ```
     
     {% cut "Если версия ниже" %}
     
     Обновите версию провайдера:
     
     1. В каталоге с конфигурационным файлом `.tf` [добавьте аутентификационные данные](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) в переменные окружения.
     
     1. В этом же каталоге инициализируйте провайдера с новой версией, указанного в конфигурационном файле:
     
        ```bash
        terraform init -upgrade
        ```
     
     1. Проверьте версию провайдера:
     
        ```bash
        terraform version
        ```
     
     {% endcut %}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О создании такого файла читайте в разделе [Создание кластера](cluster-create.md).

  1. Добавьте дополнительные ресурсы в конфигурационный файл.

     {% cut "Для стандартного шардирования кластера с использованием хостов `MONGOINFRA`" %}

        ```hcl
        resources_mongoinfra {
          resource_preset_id = "<класс_хоста>"
          disk_type_id       = "<тип_диска>"
          disk_size          = <размер_хранилища_ГБ>
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongoinfra"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongoinfra"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongoinfra"
        }
        ```

     {% endcut %}

     {% cut "Для расширенного шардирования кластера с использованием хостов `MONGOS` и `MONGOCFG`" %}

        ```hcl
        resources_mongos {
          resource_preset_id = "<класс_хоста>"
          disk_type_id       = "<тип_диска>"
          disk_size          = <размер_хранилища_ГБ>
        }

        resources_mongocfg {
          resource_preset_id = "<класс_хоста>"
          disk_type_id       = "<тип_диска>"
          disk_size          = <размер_хранилища_ГБ>
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongos"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongos"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongocfg"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongocfg"
        }

        host {
          zone_id   = "<зона_доступности>"
          subnet_id = "<идентификатор_подсети>"
          type      = "mongocfg"
        }
        ```

     {% endcut %}

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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.EnableSharding](../api-ref/Cluster/enableSharding.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:enableSharding' \
            --data '{
                      "<тип_хоста_Yandex_StoreDoc>": {
                        "resources": {
                          "resourcePresetId": "<класс_хоста>",
                          "diskSize": "<размер_хранилища_в_байтах>",
                          "diskTypeId": "<тип_диска>"
                        }
                      },
                      "hostSpecs": [
                        {
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_подсети>",
                          "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
                          "type": "<тип_хоста>",
                          "shardName": "<имя_шарда>",
                          "hidden": <скрыть_хост>,
                          "secondaryDelaySecs": "<задержка_в_секундах>",
                          "priority": "<приоритет_назначения_хоста_мастером>",
                          "tags": "<метки_хоста>"
                        },
                        { <аналогичный_набор_настроек_для_хоста_2> },
                        { ... },
                        { <аналогичный_набор_настроек_для_хоста_N> }
                      ]
                    }'
        ```

        Где:

        * Тип хоста Yandex StoreDoc — зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongocfg`, `mongos`, `mongoinfra`.
        
        * `hostSpecs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста. Количество хостов зависит от [типа шардирования](../concepts/sharding.md#shard-management). 

          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `type`— тип хоста (`MONGOINFRA`, `MONGOS` или `MONGOCFG`).
          * `shardName` — имя шарда.
          * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
          * `secondaryDelaySecs` — время отставания хоста от мастера.
          * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/enableSharding.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.EnableSharding](../api-ref/grpc/Cluster/enableSharding.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "<тип_хоста_Yandex_StoreDoc>": {
                  "resources": {
                    "resource_preset_id": "<класс_хоста>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                  }
                },
                "host_specs": [
                  {
                    "zone_id": "<зона_доступности>",
                    "subnet_id": "<идентификатор_подсети>",
                    "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
                    "type": "<тип_хоста>",
                    "shard_name": "<имя_шарда>",
                    "hidden": <скрыть_хост>,
                    "secondary_delay_secs": "<задержка_в_секундах>",
                    "priority": "<приоритет_назначения_хоста_мастером>",
                    "tags": "<метки_хоста>"
                  },
                  { <аналогичный_набор_настроек_для_хоста_2> },
                  { ... },
                  { <аналогичный_набор_настроек_для_хоста_N> }
                ]
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.EnableSharding
      ```

      Где:
      
      * Тип хоста Yandex StoreDoc — зависит от [типа шардирования](../concepts/sharding.md). Доступные значения: `mongocfg`, `mongos`, `mongoinfra`.
        
      * `host_specs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста. Количество хостов зависит от [типа шардирования](../concepts/sharding.md#shard-management). 

        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
        * `type`— тип хоста (`MONGOINFRA`, `MONGOS` или `MONGOCFG`).
        * `shard_name` — имя шарда.
        * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
        * `secondary_delay_secs` — время отставания хоста от мастера.
        * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
        * `tags`— метки хоста.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/enableSharding.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить список шардов в кластере {#list-shards}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список шардов в кластере, выполните команду:

  ```bash
  yc managed-mongodb shards list --cluster-name <имя_кластера>
  ```

  Результат:

  ```text
  +------+
  | NAME |
  +------+
  | rs01 |
  | rs02 |
  +------+
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.ListShards](../api-ref/Cluster/listShards.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>/shards'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listShards.md#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse).

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

    1. Воспользуйтесь вызовом [ClusterService.ListShards](../api-ref/grpc/Cluster/listShards.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            yandex.cloud.mdb.mongodb.v1.ClusterService.ListShards
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listShards.md#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse).

{% endlist %}

## Создать шард {#add-shard}

Количество шардов в кластерах Yandex StoreDoc ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты](https://console.yandex.cloud/cloud?section=quotas) и найдите блок **Yandex StoreDoc**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.
  1. Нажмите кнопку **Создать шард**.
  1. Укажите имя шарда и добавьте нужное количество хостов.
  1. Нажмите кнопку **Создать шард**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать шард, выполните команду (в примере приведены не все доступные параметры):

  ```bash
  yc managed-mongodb shards add <имя_нового_шарда> \
    --cluster-name=<имя_кластера> \
    --host zone-id=<зона_доступности>,`
      `subnet-name=<имя_подсети>
  ```

  Где:
  * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  * `--host` — параметры хоста:
    * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
    * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).

- Terraform {#tf}

  1. Убедитесь, что установленная версия провайдера — 0.90 или выше:
     
     ```bash
     terraform version
     ```
     
     Пример результата:
     
     ```text
     Terraform v1.4.6
     on darwin_arm64
     + provider registry.terraform.io/yandex-cloud/yandex v0.91.0
     ```
     
     {% cut "Если версия ниже" %}
     
     Обновите версию провайдера:
     
     1. В каталоге с конфигурационным файлом `.tf` [добавьте аутентификационные данные](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) в переменные окружения.
     
     1. В этом же каталоге инициализируйте провайдера с новой версией, указанного в конфигурационном файле:
     
        ```bash
        terraform init -upgrade
        ```
     
     1. Проверьте версию провайдера:
     
        ```bash
        terraform version
        ```
     
     {% endcut %}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О создании такого файла читайте в разделе [Создание кластера](cluster-create.md).

  1. Добавьте к описанию кластера Yandex StoreDoc нужное количество блоков `host` с типом `MONGOD` в параметре `type` и именем шарда в параметре `shard_name`:

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
       ...
       host {
         zone_id    = "<зона_доступности>"
         subnet_id  = "<идентификатор_подсети>"
         type       = "mongod"
         shard_name = "<имя_шарда>"
       }
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

  Подробнее читайте в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.AddShard](../api-ref/Cluster/addShard.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>/shards' \
            --data '{
                      "shardName": "<имя_шарда>",
                      "hostSpecs": [
                        {
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_подсети>",
                          "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
                          "type": "<тип_хоста>",
                          "shardName": "<имя_шарда>",
                          "hidden": <скрыть_хост>,
                          "secondaryDelaySecs": "<время_в_секундах>",
                          "priority": "<приоритет_назначения_хоста_мастером>",
                          "tags": "<метки>"
                        },
                        { <аналогичный_набор_настроек_для_хоста_2> },
                        { ... },
                        { <аналогичный_набор_настроек_для_хоста_N> }
                      ]
                    }'

        ```

        Где:

        * `shardName` — имя создаваемого шарда.
        * `hostSpecs` — параметры хоста:

          * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `type`— тип хоста. Укажите `MONGOD`.
          * `shardName` — имя шарда.
          * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
          * `secondaryDelaySecs` — время отставания хоста от мастера.
          * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "shard_name": "<имя_шарда>",
                  "host_specs": [
                    {
                      "zone_id": "<зона_доступности>",
                      "subnet_id": "<идентификатор_подсети>",
                      "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
                      "type": "<тип_хоста>",
                      "shard_name": "<имя_шарда>",
                      "hidden": <скрыть_хост>,
                      "secondary_delay_secs": "<время_в_секундах>",
                      "priority": "<приоритет_назначения_хоста_мастером>",
                      "tags": "<метки>"
                    },
                    { <аналогичный_набор_настроек_для_хоста_2> },
                    { ... },
                    { <аналогичный_набор_настроек_для_хоста_N> }
                  ]
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.AddShard    
        ```

        Где:

        * `shard_name` — имя создаваемого шарда.
        * `host_specs` — параметры хоста:

          * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
          * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
          * `type`— тип хоста. Укажите `MONGOD`.
          * `shard_name` — имя шарда.
          * `hidden`— будет ли хост виден (`false`) или скрыт (`true`).
          * `secondary_delay_secs` — время отставания хоста от мастера.
          * `priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
          * `tags`— метки хоста.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addShard.md#yandex.cloud.operation.Operation).    

{% endlist %}

## Удалить шард {#delete-shard}

Вы можете удалить шард из кластера Yandex StoreDoc, если это не единственный шард. Чтобы заменить единственный шард, сначала создайте новый шард, а затем удалите старый.

{% note info %}

Для удаляемого шарда будет вызвана операция `removeShard`, которая безопасно переносит данные на оставшиеся шарды.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex StoreDoc**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного шарда и выберите пункт **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить шард из кластера, выполните команду:

  ```bash
  yc managed-mongodb shards delete <имя_шарда> \
    --cluster-name=<имя_кластера>
  ```

  Имя шарда можно запросить со [списком шардов в кластере](#list-shards), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О создании такого файла читайте в разделе [Создание кластера](cluster-create.md).

  1. Удалите из описания кластера Yandex StoreDoc все блоки `host`, которые относятся к шарду.
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

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>/shards/<имя_шарда>'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя шарда — со [списком шардов в кластере](#list-shards).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ClusterService.DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "shard_name": "<имя_шарда>" 
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.mongodb.v1.ClusterService.DeleteShard
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя шарда — со [списком шардов в кластере](#list-shards).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

{% endlist %}