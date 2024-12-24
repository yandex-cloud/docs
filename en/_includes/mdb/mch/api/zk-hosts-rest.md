1. [Get an IAM token for API authentication](../../../../managed-clickhouse/api-ref/authentication.md) and put it into the environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Use the [Cluster.AddZookeeper](../../../../managed-clickhouse/api-ref/Cluster/addZookeeper.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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
                   "zoneId": "<availability_zone>",
                   "type": "ZOOKEEPER",
                   "subnetId": "<subnet_ID>",
                   "shardName": "<shard_name>",
                   "assignPublicIp": <public_access_to_host>
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

      * `resourcePresetId`: [Host class](../../../../managed-clickhouse/concepts/instance-types.md).
      * `diskSize`: Disk size in bytes.
      * `diskTypeId`: [Disk type](../../../../managed-clickhouse/concepts/storage.md).

    * `hostSpecs`: Array with settings for the new hosts. One array element contains settings for a single host and the cluster must have at least three {{ ZK }} hosts. An array element has the following structure:

      * `type`: `ZOOKEEPER` host type.
      * `zoneId`: Availability zone.
      * `subnetId`: Subnet ID.
      * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.

    * `convertTablesToReplicated`: Converting non-replicated tables to [replicated](../../../../managed-clickhouse/concepts/replication.md#replicated-tables) ones, `true` or `false`.

    You can get the cluster ID with a [list of clusters in the folder](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-clickhouse/api-ref/Cluster/addZookeeper.md#responses) to make sure the request was successful.
