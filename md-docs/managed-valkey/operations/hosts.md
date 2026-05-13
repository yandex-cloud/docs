# Управление хостами кластера Valkey™

Вы можете добавлять и удалять хосты кластера, а также управлять их настройками. О том, как перенести хосты кластера в другую [зону доступности](../../overview/concepts/geo-scope.md), читайте в [инструкции](host-migration.md).

## Получить список хостов в кластере {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  yc managed-redis host list \
    --cluster-name=<имя_кластера>
  ```

  Результат:

  
  ```text
  +---------------------------------+----------------------+------------+---------+--------+-------------------+
  |              NAME               |      CLUSTER ID      | SHARD NAME |  ROLE   | HEALTH |      ZONE ID      |
  +---------------------------------+----------------------+------------+---------+--------+-------------------+
  | rc1a-...caf.mdb.yandexcloud.net | c9qb2q230gg1******** | shard1     | MASTER  | ALIVE  | ru-central1-a     |
  | rc1b-...bgc.mdb.yandexcloud.net | c9qb2q230gg1******** | shard1     | REPLICA | ALIVE  | ru-central1-b     |
  +---------------------------------+----------------------+------------+---------+--------+-------------------+
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
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>/hosts'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.redis.v1.ListClusterHostsResponse).

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>"
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.ListHosts
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.redis.v1.ListClusterHostsResponse).

{% endlist %}

## Создать хост {#add}

Количество хостов в кластерах Yandex Managed Service for Valkey™ ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты](https://console.yandex.cloud/cloud?section=quotas) и найдите блок **Managed Databases**.


{% note info %}

Публичный доступ к хостам можно настроить только для кластеров, созданных с включенной поддержкой TLS.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать хост:
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
  1. Нажмите кнопку **Создать хост**.
  1. Укажите параметры хоста:
     * Зону доступности.

     
     * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).


     * [Приоритет назначения хоста мастером](../concepts/replication.md#master-failover).

     
     * При необходимости настройте публичный доступ к хосту.


     * Если вы добавляете хост в шардированный кластер, выберите шард.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать хост:

  
  1. Запросите список подсетей кластера, чтобы выбрать подсеть для нового хоста:

     ```bash
     yc vpc subnet list
	 ```

	 Результат:

     ```text
     +----------------------+-----------+-----------------------+---------------+------------------+
     |          ID          |   NAME    |       NETWORK ID      |     ZONE      |      RANGE       |
     +----------------------+-----------+-----------------------+---------------+------------------+
     | b0cl69a2b4c6******** | default-d | enp6rq72rndgr******** | ru-central1-d | [172.16.0.0/20]  |
     | e2lkj9qwe762******** | default-b | enp6rq72rndgr******** | ru-central1-b | [10.10.0.0/16]   |
     | e9b0ph42bn96******** | a-2       | enp6rq72rndgr******** | ru-central1-a | [172.16.32.0/20] |
     | e9b9v22r88io******** | default-a | enp6rq72rndgr******** | ru-central1-a | [172.16.16.0/20] |
     +----------------------+-----------+-----------------------+---------------+------------------+
     ```

     Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     yc managed-redis host add --help
     ```

  1. Выполните команду добавления хоста:

     
     ```bash
     yc managed-redis host add \
       --cluster-name=<имя_кластера> \
       --host zone-id=<зона_доступности>,`
         `subnet-id=<идентификатор_подсети>,`
         `assign-public-ip=<публичный_доступ>,`
         `replica-priority=<приоритет_хоста>,`
         `shard-name=<имя_шарда>
     ```


     Где:
     * `--cluster-name` — имя кластера Yandex Managed Service for Valkey™. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     * `--host` — параметры хоста:
       * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
       * `subnet-id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
       * `assign-public-ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.
       * `replica-priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover). Доступен только для нешардированного кластера.
       * `shard-name` — имя шарда, в котором следует создать хост, если кластер шардированный.

- Terraform {#tf}

  Чтобы создать хост:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера Yandex Managed Service for Valkey™ новый хост в блоке `hosts`:

     
     ```hcl
     resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
       ...
       hosts = {
         ...
         "<имя_хоста>" = {
           zone             = "<зона_доступности>"
           subnet_id        = "<идентификатор_подсети>"
           assign_public_ip = <публичный_доступ>
           replica_priority = <приоритет_хоста>
           shard_name       = "<имя_шарда>"
         }
       }
     }
     ```


     Где:

     * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

     
     * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
     * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.


     * `replica_priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
     * `shard_name` — имя шарда, в котором будет расположен хост.

     Имя хоста должно быть уникальным в кластере.

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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_redis_cluster_v2.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex Managed Service for Valkey™:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 15 минут;
  * изменение — 60 минут;
  * удаление — 15 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
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
    
    1. Воспользуйтесь методом [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):
    
        
        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
            --data '{
                      "hostSpecs": [
                        {
                          "zoneId": "<зона_доступности>",
                          "subnetId": "<идентификатор_подсети>",
                          "shardName": "<имя_шарда>",
                          "replicaPriority": "<приоритет_хоста>",
                          "assignPublicIp": <разрешить_публичный_доступ_к_хосту>
                        }
                      ]
                    }'
        ```
    
    
        Где `hostSpecs` — параметры хоста:
    
        * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
        * `shardName` — имя шарда для хоста. Этот параметр используется, только если включено [шардирование кластера](../concepts/sharding.md).
        * `replicaPriority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
        * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Включить публичный доступ можно, только если в кластере включена поддержка TLS.
    
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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "host_specs": [
                    {
                      "zone_id": "<зона_доступности>",
                      "subnet_id": "<идентификатор_подсети>",
                      "shard_name": "<имя_шарда>",
                      "replica_priority": "<приоритет_хоста>",
                      "assign_public_ip": <разрешить_публичный_доступ_к_хосту>
                    }
                  ] 
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.AddHosts
        ```
    
    
        Где `host_specs` — параметры хоста:
    
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
        * `shard_name` — имя шарда для хоста. Этот параметр используется, только если включено [шардирование кластера](../concepts/sharding.md).
        * `replica_priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
        * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Включить публичный доступ можно, только если в кластере включена поддержка TLS.
    
        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    
    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Изменить хост {#update}


{% note info %}

Доступ к хостам из интернета через публичные IP-адреса возможен только в том случае, если кластер был [создан](cluster-create.md#create-cluster) с включенной поддержкой TLS.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить параметры хоста в кластере:
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **Редактировать**.

  
  1. Задайте новые настройки для хоста:

      1. Включите опцию **Публичный доступ**, если хост должен быть доступен извне Yandex Cloud.
      1. Укажите [приоритет назначения хоста мастером](../concepts/replication.md#master-failover).


  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить параметры хоста, выполните команду:

  
  ```bash
  yc managed-redis host update <имя_хоста> \
    --cluster-name=<имя_кластера> \
    --assign-public-ip=<публичный_доступ> \
    --replica-priority=<приоритет_хоста>
  ```


  Где `--assign-public-ip` — публичный доступ к хосту: `true` или `false`.

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

  Чтобы изменить параметры хоста в кластере:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Измените в описании кластера Yandex Managed Service for Valkey™ параметры нужного хоста в блоке `hosts`:

     
     ```hcl
     resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
       ...
       hosts = {
         ...
         "<имя_хоста>" = {
           zone             = "<зона_доступности>"
           subnet_id        = "<идентификатор_подсети>"
           assign_public_ip = <публичный_доступ>
           replica_priority = <приоритет_хоста>
           shard_name       = "<имя_шарда>"
         }
       }
     }
     ```


     Где:

     * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

     
     * `subnet_id` — идентификатор подсети в выбранной зоне доступности.
     * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.


     * `replica_priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
     * `shard_name` — имя шарда, в котором расположен хост.

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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_redis_cluster_v2.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex Managed Service for Valkey™:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 15 минут;
  * изменение — 60 минут;
  * удаление — 15 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
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

    1. Воспользуйтесь методом [Cluster.UpdateHosts](../api-ref/Cluster/updateHosts.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        
        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>/hosts:batchUpdate' \
            --data '{
                      "updateHostSpecs": [
                        {
                          "hostName": "<имя_хоста>",
                          "replicaPriority": "<приоритет_хоста>",
                          "assignPublicIp": <публичный_доступ_к_хосту_кластера>,
                          "updateMask": "replicaPriority,assignPublicIp"
                        }
                      ]
                    }'
        ```


        Где `updateHostSpecs` — параметры хоста:

        * `hostName` — имя хоста, который нужно изменить. Чтобы узнать имя, [получите список хостов в кластере](#list).
        * `replicaPriority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
        * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Включить публичный доступ можно, только если в кластере включена поддержка TLS.
        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

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

    1. Воспользуйтесь вызовом [ClusterService.UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_host_specs": [
                    {
                      "host_name": "<имя_хоста>",
                      "replica_priority": "<приоритет_хоста>",
                      "assign_public_ip": <публичный_доступ_к_хосту_кластера>,
                      "update_mask": {
                        "paths": ["replica_priority", "assign_public_ip"]
                      }
                    }
                  ] 
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.UpdateHosts
        ```


        Где `update_host_specs` — параметры хоста:

        * `host_name` — имя хоста, который нужно изменить. Чтобы узнать имя, [получите список хостов в кластере](#list).
        * `replica_priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../concepts/replication.md#master-failover).
        * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Включить публичный доступ можно, только если в кластере включена поддержка TLS.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Удалить хост {#remove}

Вы можете удалить хост из кластера Valkey™, если он не является единственным хостом. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

Если хост является мастером в момент удаления, Yandex Managed Service for Valkey™ автоматически назначит мастером другую реплику.

Если количество хостов в кластере или в шарде кластера равно минимально допустимому, удалить хост нельзя. См. подробнее в разделе [Квоты и лимиты](../concepts/limits.md#mrd-limits).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить хост из кластера:
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex Managed Service for&nbsp;Valkey™**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. В строке с нужным хостом нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. В открывшемся окне включите опцию **Я удаляю хост** и нажмите кнопку **Подтвердить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  yc managed-redis host delete <имя_хоста> \
    --cluster-name=<имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

  Чтобы удалить хост из кластера:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера Yandex Managed Service for Valkey™ нужный хост в блоке `hosts`.
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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_redis_cluster_v2.md).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex Managed Service for Valkey™:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 15 минут;
  * изменение — 60 минут;
  * удаление — 15 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
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
            --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
            --data '{
                      "hostNames": [ "<имя_хоста>" ]
                    }'
        ```
    
        Где `hostNames` — имя удаляемого хоста. Чтобы узнать имя, [получите список хостов в кластере](hosts.md#list).
    
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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "host_names": [ "<имя_хоста>" ]
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.redis.v1.ClusterService.DeleteHosts
        ```
    
        Где `host_names` — имя удаляемого хоста. Чтобы узнать имя, [получите список хостов в кластере](hosts.md#list).
    
        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    
    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

{% endlist %}