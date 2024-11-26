1. [Получите IAM-токен для аутентификации в API](../../../../managed-redis/api-ref/authentication.md) и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Воспользуйтесь методом [Cluster.AddHosts](../../../../managed-redis/api-ref/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>/hosts:batchCreate' \
        --data '{
                  "hostSpecs": [
                    {
                      "zoneId": "<зона_доступности>",
                      "subnetId": "<идентификатор_подсети>",
                      "shardName": "<имя_шарда>",
                      "replicaPriority": "<приоритет_хоста>",
                      "assignPublicIp": <публичный_доступ_к_хосту_кластера>
                    }
                  ]
                }'
    ```

    Где `hostSpecs` — параметры хоста:

    * `zoneId` — [зона доступности](../../../../overview/concepts/geo-scope.md).
    * `subnetId` — [идентификатор подсети](../../../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
    * `shardName` — имя шарда для хоста. Этот параметр используется, только если включено [шардирование кластера](../../../../managed-redis/concepts/sharding.md).
    * `replicaPriority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../../../../managed-redis/concepts/replication.md#master-failover).
    * `assignPublicIp` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Включить публичный доступ можно, только если в кластере включена поддержка TLS.

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-redis/api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation).
