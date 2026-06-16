# Управление шардами Sharded PostgreSQL

## Создать шард {#create-shard}

Шарды Sharded PostgreSQL создаются на основе существующих кластеров Yandex Managed Service for PostgreSQL, расположенных в том же каталоге и в той же облачной сети, что и кластер Sharded PostgreSQL.


{% note warning %}

Чтобы роутер мог подключаться к хостам шарда, кластер Managed Service for Sharded PostgreSQL и шарды должны находиться в одной [группе безопасности](../../vpc/concepts/security-groups.md), разрешающей входящие и исходящие TCP-подключения на порт `6432`.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать шард.
    1. Перейдите в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.
    1. Нажмите кнопку **Создать шард**.
    1. Укажите имя шарда и выберите кластер PostgreSQL, хосты которого будут использоваться в качестве хостов с данными в кластере Sharded PostgreSQL.
    1. Нажмите кнопку **Создать**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.AddShard](../api-ref/Cluster/addShard.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-spqr/v1/clusters/<идентификатор_кластера>/shards' \
       --data '{
                 "shardSpec": {
                   "shardName": "<имя_шарда>",
                   "mdbPostgresql": {
                     "clusterId": "<идентификатор_кластера_PostgreSQL>"
                   }
                 }
               }'
     ```

     Где `mdbPostgresql.clusterId` — идентификатор кластера Managed Service for PostgreSQL в составе шарда.

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

  1. Воспользуйтесь вызовом [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <идентификатор_кластера>
             "shard_spec": {
               "shard_name": "<имя_шарда>",
               "mdb_postgresql": {
                 "cluster_id": "<идентификатор_кластера_PostgreSQL>"
               }
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.spqr.v1.ClusterService.AddShard
     ```

     Где `mdb_postgresql.cluster_id` — идентификатор кластера Managed Service for PostgreSQL в составе шарда.

{% endlist %}

## Удалить шард {#delete-shard}

При удалении шарда Sharded PostgreSQL кластер Managed Service for PostgreSQL не удаляется.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно удалить шард. 
    1. Перейдите в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного шарда и выберите пункт **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-spqr/v1/clusters/<идентификатор_кластера>/shards/<имя_шарда>'
     ```

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

  1. Воспользуйтесь вызовом [ClusterService.DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <идентификатор_кластера>,
             "shard_name": "<имя_шарда>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.spqr.v1.ClusterService.DeleteShard
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation).

{% endlist %}