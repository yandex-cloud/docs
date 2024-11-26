1. [Получите IAM-токен для аутентификации в API](../../../../managed-redis/api-ref/authentication.md) и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Воспользуйтесь методом [Cluster.DeleteHosts](../../../../managed-redis/api-ref/Cluster/deleteHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/hosts:batchDelete' \
        --data '{
                  "hostNames": [ "<имя_хоста>" ]
                }'
    ```

    Где `hostNames` — имя удаляемого хоста. Чтобы узнать имя, [получите список хостов в кластере](../../../../managed-redis/operations/hosts.md#list).

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-redis/api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation).
