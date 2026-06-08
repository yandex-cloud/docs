1. [Get an IAM token for API authentication](../../../../managed-clickhouse/api-ref/authentication.md) and put it into an environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Call the [Cluster.AddZookeeper](../../../../managed-clickhouse/api-ref/Cluster/addZookeeper.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

    ```bash
    curl \
      --request POST \
      --header "Authorization: Bearer $IAM_TOKEN" \
      --header "Content-Type: application/json" \
      --url 'https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/<cluster_ID>:addZookeeper' \
      --data '{
               "resources": {
                 "resourcePresetId": "<host_class>",
                 "diskSize": "<storage_size_in_bytes>",
                 "diskTypeId": "<disk_type>"
               },
               "hostSpecs": [
                 {
                   "type": "ZOOKEEPER",
                   "zoneId": "<availability_zone>",
                   "subnetId": "<subnet_ID>"
                 },
                 { <similar_settings_for_new_host_2> },
                 { ... },
                 { <similar_settings_for_new_host_N> }
               ],
               "convertTablesToReplicated": true
             }'
    ```

    Where:

    * `resources`: Resources for {{ ZK }} hosts.

      * `resourcePresetId`: [Host class](../../../../managed-clickhouse/concepts/instance-types.md) ID.
      * `diskSize`: Disk size, in bytes.
      * `diskTypeId`: [Disk type](../../../../managed-clickhouse/concepts/storage.md).

    * `hostSpecs`: Array of settings for the new hosts. One array element contains settings for a single host and the cluster must have at least three {{ ZK }} hosts. An array element has the following structure:

      * `type`: `ZOOKEEPER` host type.
      * `zoneId`: Availability zone.
      * `subnetId`: Subnet ID.

    * `convertTablesToReplicated`: Converting non-replicated tables to [replicated](../../../../managed-clickhouse/concepts/replication.md#replicated-tables) ones, `true` or `false`. This will automatically convert non-replicated tables [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) tables to [ReplicatedMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication)-based replicated ones.

      {% note warning %}

      Once this option is enabled, you cannot disable it.

      {% endnote %}

    You can request the cluster ID with the [list of clusters in the folder](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-clickhouse/api-ref/Cluster/addZookeeper.md#responses) to make sure your request was successful.
