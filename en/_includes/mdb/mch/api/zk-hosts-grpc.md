1. [Get an IAM token for API authentication](../../../../managed-clickhouse/api-ref/authentication.md) and put it into the environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../grpc-api-setup-repo.md) %}
1. Use the [ClusterService.AddZookeeper](../../../../managed-clickhouse/api-ref/grpc/Cluster/addZookeeper.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                 "subnet_id": "<subnet_ID>",
                 "assign_public_ip": <public_access_to_host>
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

      * `resource_preset_id`: [Host class](../../../../managed-clickhouse/concepts/instance-types.md).
      * `disk_size`: Disk size in bytes.
      * `disk_type_id`: [Disk type](../../../../managed-clickhouse/concepts/storage.md).

    * `host_specs`: Array with settings for the new hosts. One array element contains settings for a single host and the cluster must have at least three {{ ZK }} hosts.

      An array element has the following structure.

      * `type`: `ZOOKEEPER` host type.
      * `zone_id`: Availability zone.
      * `subnet_id`: Subnet ID.
      * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.

    * `convert_tables_to_replicated`: Converting non-replicated tables to [replicated](../../../../managed-clickhouse/concepts/replication.md#replicated-tables) ones, `true` or `false`.

    You can get the cluster ID with a [list of clusters in the folder](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-clickhouse/api-ref/grpc/Cluster/addZookeeper.md#yandex.cloud.operation.Operation) to make sure the request was successful.
