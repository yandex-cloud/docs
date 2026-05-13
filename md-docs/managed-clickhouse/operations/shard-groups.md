# Управление группами шардов в кластере ClickHouse®

Вы можете сгруппировать несколько [шардов](../concepts/sharding.md) кластера ClickHouse® в _группу шардов_ и затем размещать таблицы в этой группе.

## Получить список групп шардов в кластере {#list-shard-groups}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Группы шардов**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список групп шардов в кластере, выполните команду:

  ```bash
  yc managed-clickhouse shard-groups list \
     --cluster-name=<имя_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.ListShardGroups](../api-ref/Cluster/listShardGroups.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listShardGroups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse).

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
  1. Воспользуйтесь вызовом [ClusterService.ListShardGroups](../api-ref/grpc/Cluster/listShardGroups.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
       yandex.cloud.mdb.clickhouse.v1.ClusterService.ListShardGroups
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listShardGroups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse).

{% endlist %}

## Получить детальную информацию о группе шардов {#get-shard-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Группы шардов**.
  1. Выберите группу шардов для просмотра детальной информации о ней.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить детальную информацию о группе шардов в кластере, выполните команду:

  ```bash
  yc managed-clickhouse shard-groups get \
    --cluster-name=<имя_кластера> \
    --name=<имя_группы_шардов>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.GetShardGroup](../api-ref/Cluster/getShardGroup.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups/<имя_группы_шардов>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/getShardGroup.md#yandex.cloud.mdb.clickhouse.v1.ShardGroup).

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
  1. Воспользуйтесь вызовом [ClusterService.GetShardGroup](../api-ref/grpc/Cluster/getShardGroup.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "shard_group_name": "<имя_группы_шардов>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.GetShardGroup
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/getShardGroup.md#yandex.cloud.mdb.clickhouse.v1.ShardGroup).

{% endlist %}

## Создать группу шардов {#create-shard-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Группы шардов**.
  1. Нажмите кнопку **Создать группу шардов**.
  1. Заполните поля формы и нажмите кнопку **Применить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать группу шардов в кластере, выполните команду:

  ```bash
  yc managed-clickhouse shard-groups create \
    --cluster-name=<имя_кластера> \
    --name=<имя_группы_шардов> \
    --description=<описание_группы_шардов> \
    --shards=<список_имен_шардов>
  ```

  Где `--shards` — список имен шардов, которые нужно включить в группу.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Имена шардов можно запросить со [списком шардов в кластере](shards.md#list-shards).


- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Добавьте к описанию кластера Managed Service for ClickHouse® блок описания группы шардов `shard_group`.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
       ...
       shard_group {
         name        = "<имя_группы_шардов>"
         description = "<необязательное_описание_группы_шардов>"
         shard_names = [
           # Список шардов, входящих в группу
           "<имя_шарда_1>",
           ...
           "<имя_шарда_N>"
         ]
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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

  1. Воспользуйтесь методом [Cluster.CreateShardGroup](../api-ref/Cluster/createShardGroup.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups' \
       --data '{
                 "shardGroupName": "<имя_группы_шардов>",
                 "description": "<описание_группы_шардов>",
                 "shardNames": [
                   "<шард_1>", "<шард_2>", ... "<шард_N>"
                 ]
               }'
     ```

     Где:

     * `shardGroupName` — название группы шардов.
     * `description` — описание группы шардов.
     * `shardNames` — список шардов, которые нужно включить в создаваемую группу.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/createShardGroup.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.CreateShardGroup](../api-ref/grpc/Cluster/createShardGroup.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
               "cluster_id": "<идентификатор_кластера>",
               "shard_group_name": "<имя_группы_шардов>",
               "description": "<описание_группы_шардов>",
               "shard_names": [
                 "<шард_1>", "<шард_2>", ... "<шард_N>"
               ]
             }' \
         mdb.api.cloud.yandex.net:443 \
         yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateShardGroup
     ```

     Где:

     * `shard_group_name` — название группы шардов.
     * `description` — описание группы шардов.
     * `shard_names` — список шардов, которые нужно включить в создаваемую группу.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/createShardGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить группу шардов {#update-shard-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Группы шардов**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной группы шардов и выберите пункт **Редактировать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить группу шардов в кластере, выполните команду:

  ```bash
  yc managed-clickhouse shard-groups update \
    --cluster-name=<имя_кластера> \
    --name=<имя_группы_шардов> \
    --description=<новое_описание_группы_шардов> \
    --shards=<новый_список_имен_шардов>
  ```

  Где `--shards` — новый список имен шардов, которые нужно включить в группу.

  Эта команда заменяет существующий список шардов в группе новым, который был передан команде в параметре `--shards`. Перед выполнением команды убедитесь, что вы включили в новый список все необходимые шарды.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Имя группы шардов можно запросить со [списком групп шардов в кластере](#list-shard-groups).

  Имена шардов можно запросить со [списком шардов в кластере](shards.md#list-shards).


- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Измените в описании кластера Managed Service for ClickHouse® блок `shard_group` с нужной группой шардов:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
       ...
       shard_group {
         name        = "<новое_имя_группы_шардов>"
         description = "<новое_описание_группы_шардов>"
         shard_names = [
           # Новый список входящих в группу шардов
           "<имя_шарда_1>",
           ...
           "<имя_шарда_N>"
         ]
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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

  1. Воспользуйтесь методом [Cluster.updateShardGroup](../api-ref/Cluster/updateShardGroup.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups/<имя_группы_шардов>' \
       --data '{
                 "updateMask": "description,shardNames",
                 "description": "<описание_группы_шардов>",
                 "shardNames": [
                   "<шард_1>", "<шард_2>", ... "<шард_N>"
                 ]
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `description` — новое описание группы шардов.
     * `shardNames` — новый список шардов, которые нужно включить в группу. Чтобы узнать имена шардов, [получите их список](shards.md#list-shards) в кластере. Этот список заменит собой текущий: убедитесь, что вы включили в новый список все необходимые шарды.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.UpdateShardGroup](../api-ref/grpc/Cluster/updateShardGroup.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
             "shard_group_name": "<имя_группы_шардов>",
             "update_mask": {
               "paths": [
                 "description", "shard_names"
               ]
             },
             "description": "<описание_группы_шардов>",
             "shard_names": [
               "<шард_1>", "<шард_2>", ... "<шард_N>"
             ]
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateShardGroup
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `description` — новое описание группы шардов.
     * `shard_names` — новый список шардов, которые нужно включить в группу. Чтобы узнать имена шардов, [получите их список](shards.md#list-shards) в кластере. Этот список заменит собой текущий: убедитесь, что вы включили в новый список все необходимые шарды.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

## Удалить группу шардов {#delete-shard-group}

Удаление группы шардов не затрагивает входящие в нее шарды — они остаются в кластере.

Таблицы, созданные поверх удаляемой группы, остаются, но становятся неработоспособными: попытки выполнить запрос к ним приведут к ошибкам. Однако такие таблицы можно удалить до или после удаления группы шардов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится кластер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;ClickHouse**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Группы шардов**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужной группы шардов и выберите пункт **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить группу шардов в кластере, выполните команду:

  ```bash
  yc managed-clickhouse shard-groups delete \
     --cluster-name=<имя_кластера> \
     --name=<имя_группы_шардов>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Имя группы шардов можно запросить со [списком групп шардов в кластере](#list-shard-groups).


- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  1. Удалите из описания кластера Managed Service for ClickHouse® блок описания нужной группы шардов `shard_group`.
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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_clickhouse_cluster.md).

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

  1. Воспользуйтесь методом [Cluster.DeleteShardGroup](../api-ref/Cluster/deleteShardGroup.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>/shardGroups/<имя_группы_шардов>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/deleteShardGroup.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.DeleteShardGroup](../api-ref/grpc/Cluster/deleteShardGroup.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "shard_group_name": "<имя_группы_шардов>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteShardGroup
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя группы шардов — со [списком групп в кластере](#list-shard-groups).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteShardGroup.md#yandex.cloud.operation.Operation).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._