1. [Получите IAM-токен для аутентификации в API](../../../../managed-clickhouse/api-ref/authentication.md) и поместите токен в переменную среды окружения:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Воспользуйтесь методом [Cluster.AddZookeeper](../../../../managed-clickhouse/api-ref/Cluster/addZookeeper.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

    ```bash
    curl \
      --request POST \
      --header "Authorization: Bearer $IAM_TOKEN" \
      --header "Content-Type: application/json" \
      --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<идентификатор_кластера>:addZookeeper' \
      --data '{
               "resources": {
                 "resourcePresetId": "<класс_хостов>",
                 "diskSize": "<размер_хранилища_в_байтах>",
                 "diskTypeId": "<тип_диска>"
               },
               "hostSpecs": [
                 {
                   "type": "ZOOKEEPER",
                   "zoneId": "<зона_доступности>",
                   "subnetId": "<идентификатор_подсети>"
                 },
                 { <аналогичный_набор_настроек_для_создаваемого_хоста_2> },
                 { ... },
                 { <аналогичный_набор_настроек_для_создаваемого_хоста_N> }
               ],
               "convertTablesToReplicated": true
             }'
    ```

    Где:

    * `resources` — набор ресурсов для хостов {{ ZK }}:

      * `resourcePresetId` — идентификатор [класса хостов](../../../../managed-clickhouse/concepts/instance-types.md);
      * `diskSize` — размер диска в байтах;
      * `diskTypeId` — [тип диска](../../../../managed-clickhouse/concepts/storage.md).

    * `hostSpecs` — массив, содержащий настройки создаваемых хостов. Один элемент массива содержит настройки для одного хоста, в кластере должно быть минимум три хоста {{ ZK }}. Элемент массива имеет следующую структуру:

      * `type` — тип хоста `ZOOKEEPER`;
      * `zoneId` — зона доступности;
      * `subnetId` — идентификатор подсети.

    * `convertTablesToReplicated` — преобразование нереплицируемых таблиц в [реплицируемые](../../../../managed-clickhouse/concepts/replication.md#replicated-tables): `true` или `false`. Нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication).

      {% note warning %}

      После включения этой настройки ее нельзя отключить.

      {% endnote %}

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../../../managed-clickhouse/api-ref/Cluster/addZookeeper.md#responses).
