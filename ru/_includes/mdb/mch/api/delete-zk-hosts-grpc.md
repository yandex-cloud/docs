1. [Получите IAM-токен для аутентификации в API](../../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../grpc-api-setup-repo.md) %}

1. Воспользуйтесь вызовом [ClusterService.DeleteHosts](../../../../managed-clickhouse/api-ref/grpc/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
    ```

    Где `host_names` — массив строк. Каждая строка — имя хоста, который нужно удалить. Имена хостов можно запросить со [списком хостов в кластере](#list-hosts).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-clickhouse/api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).
