# Управление хостами кластера PostgreSQL

Вы можете добавлять и удалять хосты кластера, а также управлять их настройками. О том, как перенести хосты кластера в другую [зону доступности](../../overview/concepts/geo-scope.md), читайте в [инструкции](host-migration.md).

## Получить список хостов в кластере {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список хостов в кластере, выполните команду:

  ```bash
  yc managed-postgresql host list \
    --cluster-name <имя_кластера>
  ```

  Результат:

  
  ```text
  +----------------------------+----------------------+---------+--------+--------------------+
  |            NAME            |      CLUSTER ID      |  ROLE   | HEALTH |      ZONE ID       |
  +----------------------------+----------------------+---------+--------+--------------------+
  | rc1b***mdb.yandexcloud.net | c9qp71dk1dfg******** | MASTER  | ALIVE  | ru-central1-b      |
  | rc1a***mdb.yandexcloud.net | c9qp71dk1dfg******** | REPLICA | ALIVE  | ru-central1-a      |
  +----------------------------+----------------------+---------+--------+--------------------+
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.ListHosts
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse).

{% endlist %}

## Создать хост {#add}

Количество хостов в кластерах Managed Service for PostgreSQL ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты](https://console.yandex.cloud/cloud?section=quotas) и найдите блок **Managed Databases**.

{% note info %}

Если в кластере включен балансировщик DB Proxy, новый хост автоматически будет добавлен в балансировку.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать хост:
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
  1. Нажмите кнопку **Создать хост**.

  
  1. Укажите параметры хоста:
     * Зону доступности.
     * Подсеть (если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md)).
     * Источник репликации (если вы используете [каскадную репликацию](../concepts/replication.md#replication-manual)).
     * Выберите опцию **Публичный доступ**, если хост должен быть доступен извне Yandex Cloud.


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
     +----------------------+-----------+----------------------+---------------+-------------------+
     |          ID          |   NAME    |      NETWORK ID      |      ZONE     |      RANGE        |
     +----------------------+-----------+----------------------+---------------+-------------------+
     | b0cl69q1w2e3******** | default-d | enp6rq71w2e3******** | ru-central1-d | [172.16.**.**/20] |
     | e2lkj9q1w2e3******** | default-b | enp6rq71w2e3******** | ru-central1-b | [10.10.**.**/16]  |
     | e9b0phq1w2e3******** | a-2       | enp6rq71w2e3******** | ru-central1-a | [172.16.**.**/20] |
     | e9b9v2q1w2e3******** | default-a | enp6rq71w2e3******** | ru-central1-a | [172.16.**.**/20] |
     +----------------------+-----------+----------------------+---------------+-------------------+
     ```

     Если нужной подсети в списке нет, [создайте ее](../../vpc/operations/subnet-create.md).


  1. Посмотрите описание команды CLI для добавления хостов:

     ```bash
     yc managed-postgresql host add --help
     ```

  1. Выполните команду добавления хоста:

     
     ```bash
     yc managed-postgresql host add \
       --cluster-name <имя_кластера> \
       --host zone-id=<зона_доступности>,subnet-id=<идентификатор_подсети>
     ```


     
     Идентификатор подсети необходимо указать, если в зоне доступности больше одной подсети, в противном случае Managed Service for PostgreSQL автоматически выберет единственную подсеть. Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     Также вы можете указать несколько дополнительных опций в параметре `--host` для управления публичным доступом к хосту и репликацией в кластере:
     * Источник репликации для хоста в опции `replication-source` для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).
     * Доступность хоста извне Yandex Cloud в опции `assign-public-ip`:
       * `true` — публичный доступ включен.
       * `false` — публичный доступ выключен.


  Managed Service for PostgreSQL запустит операцию добавления хоста.


- Terraform {#tf}

  Чтобы создать хост:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL вы найдете в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).
  1. Добавьте к описанию кластера Managed Service for PostgreSQL блок `host`.

     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       host {
         name                    = "<имя_хоста>"
         zone                    = "<зона_доступности>"
         subnet_id               = "<идентификатор_подсети>"
         replication_source_name = "<источник_репликации>"
         assign_public_ip        = <публичный_доступ_к_хосту>
       }
     }
     ```

     Где:

     * `name` — имя хоста.
     * `zone` — зона доступности.
     * `subnet_id` — идентификатор подсети.
     * `replication_source_name` — источник репликации: атрибут `name` соответствующего блока `host`.
     * `assign_public_ip` — [публичный доступ к хосту](../concepts/network.md#public-access-to-a-host): `true` или `false`.

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
     
     Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
     
     * создание, в том числе путем восстановления из резервной копии, — 30 минут;
     * изменение — 60 минут;
     * удаление — 15 минут.
     
     Операции, длящиеся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       timeouts {
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
       --data '{
                 "hostSpecs": [
                   {
                     "zoneId": "<зона_доступности>",
                     "subnetId": "<идентификатор_подсети>",
                     "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
                     "replicationSource": "<FQDN_хоста>",
                     "priority": "<приоритет_хоста>",
                     "configSpec": {
                       "postgresqlConfig_<версия_PostgreSQL>": {
                         <настройки_PostgreSQL>
                       }
                     }
                   },
                   { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
                   { ... },
                   { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
                 ]
               }'
     ```


     Где `hostSpecs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `zoneId` — зона доступности.

     
     * `subnetId` — идентификатор подсети.
     * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


     * `replicationSource` — источник репликации для хоста для [ручного управления потоками репликации](../concepts/replication.md#replication-manual). В параметре укажите [FQDN хоста](connect/fqdn.md#special-fqdns), который будет источником репликации.
     * `priority` — приоритет хоста среди всех хостов.
     * `configSpec.postgresqlConfig_<версия_PostgreSQL>` — набор настроек PostgreSQL. Укажите каждую настройку на отдельной строке через запятую.

       Список версий PostgreSQL, доступных для параметра, вы найдете в [описании метода](../api-ref/Cluster/addHosts.md#yandex.cloud.mdb.postgresql.v1.AddClusterHostsRequest). Описание и возможные значения настроек в разделе [Настройки PostgreSQL](../concepts/settings-list.md).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_specs": [
               {
                 "zone_id": "<зона_доступности>",
                 "subnet_id": "<идентификатор_подсети>",
                 "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
                 "replication_source": "<FQDN_хоста>",
                 "priority": "<приоритет_хоста>",
                 "config_spec": {
                   "postgresql_config_<версия_PostgreSQL>": {
                     <настройки_PostgreSQL>
                   }
                 }
               },
               { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
               { ... },
               { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
             ]
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.AddHosts
     ```


     Где `host_specs` — массив новых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `zone_id` — зона доступности.

     
     * `subnet_id` — идентификатор подсети.
     * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


     * `replication_source` — источник репликации для хоста для [ручного управления потоками репликации](../concepts/replication.md#replication-manual). В параметре укажите [FQDN хоста](connect/fqdn.md#special-fqdns), который будет источником репликации.
     * `priority` — приоритет хоста среди всех хостов.
     * `config_spec.postgresql_config_<версия_PostgreSQL>` — набор настроек PostgreSQL. Укажите каждую настройку на отдельной строке через запятую.

       Список версий PostgreSQL, доступных для параметра, вы найдете в [описании метода](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec). Описание и возможные значения настроек в разделе [Настройки PostgreSQL](../concepts/settings-list.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если после добавления хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Изменить хост {#update}

Для каждого хоста в кластере Managed Service for PostgreSQL можно указать источник [репликации](../concepts/replication.md) и управлять [публичным доступом](../concepts/network.md#public-access-to-a-host) к хосту.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить параметры хоста в кластере:
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **Редактировать**.
  1. Задайте новые настройки для хоста:
     1. Выберите источник репликации для хоста для того, чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual).

     
     1. Включите опцию **Публичный доступ**, если хост должен быть доступен извне Yandex Cloud.


  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить параметры хоста в кластере, выполните команду:

  
  ```bash
  yc managed-postgresql host update <имя_хоста> \
    --cluster-name <имя_кластера> \
    --replication-source <имя_хоста-источника> \
    --assign-public-ip=<публичный_доступ_к_хосту>
  ```


  Где:

  * `cluster-name` — имя кластера.
  * `replication-source` — имя хоста-источника.

  
  * `assign-public-ip` — [публичный доступ к хосту](../concepts/network.md#public-access-to-a-host): `true` или `false`.


  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Чтобы [вручную управлять потоками репликации](../concepts/replication.md#replication-manual) в кластере, измените источник репликации для хоста в параметре `--replication-source`.


- Terraform {#tf}

  Чтобы изменить параметры хоста в кластере:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL вы найдете в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).
  1. Измените в описании кластера Managed Service for PostgreSQL атрибуты блока `host`, соответствующего изменяемому хосту.

     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       host {
         replication_source_name = "<источник_репликации>"
         assign_public_ip        = <публичный_доступ_к_хосту>
       }
     }
     ```

  Где:

  * `replication_source_name` — источник репликации: атрибут `name` соответствующего блока `host`.
  * `assign_public_ip` — [публичный доступ к хосту](../concepts/network.md#public-access-to-a-host): `true` или `false`.

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
     
     Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
     
     * создание, в том числе путем восстановления из резервной копии, — 30 минут;
     * изменение — 60 минут;
     * удаление — 15 минут.
     
     Операции, длящиеся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       timeouts {
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts:batchUpdate' \
       --data '{
                 "updateHostSpecs": [
                   {
                     "updateMask": "assignPublicIp,replicationSource,priority,configSpec.postgresqlConfig_<версия_PostgreSQL>",
                     "hostName": "<FQDN_хоста>",
                     "assignPublicIp": <разрешить_публичный_доступ_к_хосту>,
                     "replicationSource": "<FQDN_хоста>",
                     "priority": "<приоритет_хоста>",
                     "configSpec": {
                       "postgresqlConfig_<версия_PostgreSQL>": {
                         <настройки_PostgreSQL>
                       }
                     }
                   },
                   { <аналогичный_набор_настроек_для_изменяемого_хоста_2> },
                   { ... },
                   { <аналогичный_набор_настроек_для_изменяемого_хоста_N> }
                 ]
               }'
     ```


     Где `updateHostSpecs` — массив изменяемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `hostName` — [FQDN изменяемого хоста](connect/fqdn.md).

     
     * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


     * `replicationSource` — источник репликации для хоста для [ручного управления потоками репликации](../concepts/replication.md#replication-manual). В параметре укажите FQDN хоста, который будет источником репликации.
     * `priority` — приоритет хоста среди всех хостов.
     * `configSpec.postgresqlConfig_<версия_PostgreSQL>` — набор настроек PostgreSQL. Укажите каждую настройку на отдельной строке через запятую.

       Список версий PostgreSQL, доступных для параметра, вы найдете в [описании метода](../api-ref/Cluster/updateHosts.md#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsRequest). Описание и возможные значения настроек в разделе [Настройки PostgreSQL](../concepts/settings-list.md).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_host_specs": [
               {
                 "update_mask": {
                     "paths": [
                       "assign_public_ip",
                       "replication_source",
                       "priority",
                       "config_spec.postgresql_config_16"
                     ]
                 },
                 "host_name": "<FQDN_хоста>",
                 "assign_public_ip": <разрешить_публичный_доступ_к_хосту>,
                 "replication_source": "<FQDN_хоста>",
                 "priority": "<приоритет_хоста>",
                 "config_spec": {
                   "postgresql_config_<версия_PostgreSQL>": {
                     <настройки_PostgreSQL>
                   }
                 }
               }
             ]
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.UpdateHosts
     ```


     Где `update_host_specs` — массив изменяемых хостов. Один элемент массива содержит настройки для одного хоста и имеет следующую структуру:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `host_name` — [FQDN изменяемого хоста](connect/fqdn.md).

     
     * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`.


     * `replication_source` — источник репликации для хоста для [ручного управления потоками репликации](../concepts/replication.md#replication-manual). В параметре укажите FQDN хоста, который будет источником репликации.
     * `priority` — приоритет хоста среди всех хостов.
     * `config_spec.postgresql_config_<версия_PostgreSQL>` — набор настроек PostgreSQL. Укажите каждую настройку на отдельной строке через запятую.

       Список версий PostgreSQL, доступных для параметра, вы найдете в [описании метода](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec). Описание и возможные значения настроек в разделе [Настройки PostgreSQL](../concepts/settings-list.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

{% endlist %}


{% note warning %}

Если после изменения хоста к нему невозможно [подключиться](connect/index.md), убедитесь, что [группа безопасности](../concepts/network.md#security-groups) кластера настроена корректно для подсети, в которую помещен хост.

{% endnote %}


## Удалить хост {#remove}

Вы можете удалить хост из кластера PostgreSQL, если он не является единственным хостом. Чтобы заменить единственный хост, сначала создайте новый хост, а затем удалите старый.

Если хост является мастером в момент удаления, Managed Service for PostgreSQL автоматически назначит мастером следующую по приоритету реплику.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить хост из кластера:
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Хосты**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста, выберите пункт **Удалить** и подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить хост из кластера, выполните команду:

  ```bash
  yc managed-postgresql host delete <имя_хоста> \
    --cluster-name <имя_кластера>
  ```

  Имя хоста можно запросить со [списком хостов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

  Чтобы удалить хост из кластера:
  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкцию по созданию такого файла читайте в разделе [Создание кластера](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL вы найдете в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).
  1. Удалите из описания кластера Managed Service for PostgreSQL блок `host`, соответствующий удаляемому хосту.
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

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
     
     * создание, в том числе путем восстановления из резервной копии, — 30 минут;
     * изменение — 60 минут;
     * удаление — 15 минут.
     
     Операции, длящиеся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       timeouts {
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
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
       --data '{
                 "hostNames": [
                   "<FQDN_хоста>"
                 ]
               }'
     ```

     Где `hostNames` — массив строк, каждая из которых содержит [FQDN удаляемого хоста](connect/fqdn.md).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_names": [
               "<FQDN_хоста>"
             ]
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.DeleteHosts
     ```

     Где `host_names` — массив строк, каждая из которых содержит [FQDN удаляемого хоста](connect/fqdn.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).

{% endlist %}