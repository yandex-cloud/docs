1. [Получите IAM-токен для аутентификации в API](../../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../grpc-api-setup-repo.md) %}
1. Воспользуйтесь вызовом [ClusterService.AddZookeeper](../../../../managed-clickhouse/api-ref/grpc/Cluster/addZookeeper.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "resources": {
               "resource_preset_id": "<класс_хостов>",
               "disk_size": "<размер_хранилища_в_байтах>",
               "disk_type_id": "<тип_диска>"
             },
             "host_specs": [
               {
                 "type": "ZOOKEEPER",
                 "zone_id": "<зона_доступности>",
                 "subnet_id": "<идентификатор_подсети>"
               },
               { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
               { ... },
               { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
             ],
             "convert_tables_to_replicated": true
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.AddZookeeper
     ```

    Где:

    * `resources` — набор ресурсов для хостов {{ ZK }}:

      * `resource_preset_id` — идентификатор [класса хостов](../../../../managed-clickhouse/concepts/instance-types.md);
      * `disk_size` — размер диска в байтах;
      * `disk_type_id` — [тип диска](../../../../managed-clickhouse/concepts/storage.md).

    * `host_specs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста, в кластере должно быть минимум три хоста {{ ZK }}.

      Элемент массива имеет следующую структуру:

      * `type` — тип хоста `ZOOKEEPER`;
      * `zone_id` — зона доступности;
      * `subnet_id` — идентификатор подсети.

    * `convert_tables_to_replicated` — преобразование нереплицируемых таблиц в [реплицируемые](../../../../managed-clickhouse/concepts/replication.md#replicated-tables): `true` или `false`. Нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication).

      {% note warning %}

      После включения этой настройки ее нельзя отключить.

      {% endnote %}

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-clickhouse/api-ref/grpc/Cluster/addZookeeper.md#yandex.cloud.operation.Operation).
