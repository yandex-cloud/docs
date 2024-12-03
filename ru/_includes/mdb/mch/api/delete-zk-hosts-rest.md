1. [Получите IAM-токен для аутентификации в API](../../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Воспользуйтесь методом [Cluster.DeleteHosts](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
        --data '{
                  "hostNames": [
                    <перечень_имен_хостов>
                  ]
                }'
    ```

    Где `hostNames` — массив строк. Каждая строка — имя хоста, который нужно удалить. Имена хостов можно запросить со [списком хостов в кластере](#list-hosts).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).
