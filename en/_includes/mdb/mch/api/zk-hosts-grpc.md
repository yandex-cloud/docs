1. [Get an IAM token for API authentication](../../../../managed-clickhouse/api-ref/authentication.md) and put it in an environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../grpc-api-setup-repo.md) %}
1. Call the [ClusterService.AddZookeeper](../../../../managed-clickhouse/api-ref/grpc/Cluster/addZookeeper.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "resources": {
               "resource_preset_id": "<host_class>",
               "disk_size": "<storage_size_in_bytes>",
               "disk_type_id": "<disk_type>"
             },
             "host_specs": [
               {
                 "type": "ZOOKEEPER",
                 "zone_id": "<availability_zone>",
                 "subnet_id": "<subnet_ID>"
               },
               { <similar_settings_for_new_host_2> },
               { ... },
               { <similar_settings_for_new_host_N> }
             ],
             "convert_tables_to_replicated": true
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.AddZookeeper
     ```

    Where:

    * `resources`: Resources for {{ ZK }} hosts.

      * `resource_preset_id`: [Host class](../../../../managed-clickhouse/concepts/instance-types.md) ID.
      * `disk_size`: Disk size, in bytes.
      * `disk_type_id`: [Disk type](../../../../managed-clickhouse/concepts/storage.md).

    * `host_specs`: Array of settings for the new hosts. Each array element contains settings for a single host and the cluster must have at least three {{ ZK }} hosts.

      An array element has the following structure:

      * `type`: Host type, `ZOOKEEPER`.
      * `zone_id`: Availability zone.
      * `subnet_id`: Subnet ID.

    * `convert_tables_to_replicated`: Converting non-replicated tables to [replicated](../../../../managed-clickhouse/concepts/replication.md#replicated-tables) ones, `true` or `false`. This will automatically convert [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree) tables to [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication) ones.

      {% note warning %}

      Once this option is enabled, you cannot disable it.

      {% endnote %}

    You can get the cluster ID with the [list of clusters in the folder](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-clickhouse/api-ref/grpc/Cluster/addZookeeper.md#yandex.cloud.operation.Operation) to make sure your request was successful.
