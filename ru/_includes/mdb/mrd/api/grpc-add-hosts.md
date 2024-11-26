1. [Получите IAM-токен для аутентификации в API](../../../../managed-redis/api-ref/authentication.md) и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../grpc-api-setup-repo.md) %}

1. Воспользуйтесь вызовом [ClusterService.AddHosts](../../../../managed-redis/api-ref/grpc/Cluster/addHosts.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "host_specs": [
                {
                  "zone_id": "<зона_доступности>",
                  "subnet_id": "<идентификатор_подсети>",
                  "shard_name": "<имя_шарда>",
                  "replica_priority": "<приоритет_хоста>",
                  "assign_public_ip": <публичный_доступ_к_хосту_кластера>
                }
              ] 
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.ClusterService.AddHosts
    ```

    Где `host_specs` — параметры хоста:

    * `zone_id` — [зона доступности](../../../../overview/concepts/geo-scope.md).
    * `subnet_id` — [идентификатор подсети](../../../../vpc/concepts/network.md#subnet). Необходимо указывать, если в выбранной зоне доступности создано две или больше подсетей.
    * `shard_name` — имя шарда для хоста. Этот параметр используется, только если включено [шардирование кластера](../../../../managed-redis/concepts/sharding.md).
    * `replica_priority` — приоритет назначения хоста мастером при [выходе из строя основного мастера](../../../../managed-redis/concepts/replication.md#master-failover).
    * `assign_public_ip` — доступность хоста из интернета по публичному IP-адресу: `true` или `false`. Включить публичный доступ можно, только если в кластере включена поддержка TLS.

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-redis/api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation).
