1. Воспользуйтесь методом [Cluster.DeleteHosts](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

    ```bash
    curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
       --data '{
                 "hostNames": [
                   "<FQDN_хоста>"
                 ]
               }'
    ```

    Где `hostNames` — массив с удаляемым хостом.

    В одном запросе можно передать только один FQDN хоста. Если нужно удалить несколько хостов, выполните запрос для каждого хоста.

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).
