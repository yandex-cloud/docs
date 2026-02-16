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
               "<FQDN_хоста>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
    ```

    Где `host_names` — массив с удаляемым хостом.

    В одном запросе можно передать только один FQDN хоста. Если нужно удалить несколько хостов, выполните запрос для каждого хоста.

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-clickhouse/api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).
