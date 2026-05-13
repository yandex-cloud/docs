# Удаление кластера Sharded PostgreSQL

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Вы можете удалить кластер Sharded PostgreSQL, если он вам больше не нужен.

## Удалить кластер {#delete}

Перед удалением кластера отключите его защиту от удаления, если она включена.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, из которого нужно удалить кластер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex Managed Service for Sharded&nbsp;PostgreSQL**.
    1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **Удалить**.
    1. В открывшемся окне подтвердите удаление и нажмите кнопку **Удалить**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.Delete](../api-ref/Cluster/delete.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-spqr/v1/clusters/<идентификатор_кластера>'
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

  1. Воспользуйтесь вызовом [ClusterService.Delete](../api-ref/grpc/Cluster/delete.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": <идентификатор_кластера>
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.spqr.v1.ClusterService.Delete
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation).

{% endlist %}