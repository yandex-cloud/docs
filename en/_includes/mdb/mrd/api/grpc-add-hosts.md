1. [Get an IAM token for API authentication](../../../../managed-redis/api-ref/authentication.md) and put it into the environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../grpc-api-setup-repo.md) %}

1. Use the [ClusterService.AddHosts](../../../../managed-redis/api-ref/grpc/Cluster/addHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "host_specs": [
                {
                  "zone_id": "<availability_zone>",
                  "subnet_id": "<subnet_ID>",
                  "shard_name": "<shard_name>",
                  "replica_priority": "<host_priority>",
                  "assign_public_ip": <public_access_to_cluster_host>
                }
              ] 
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.ClusterService.AddHosts
    ```

    Where `host_specs` represents the host parameters:

    * `zone_id`: [Availability zone](../../../../overview/concepts/geo-scope.md).
    * `subnet_id`: [Subnet ID](../../../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
    * `shard_name`: Shard name for the host. Only used if [cluster sharding](../../../../managed-redis/concepts/sharding.md) is enabled.
    * `replica_priority`: Priority for assigning the host as a master if the [primary master fails](../../../../managed-redis/concepts/replication.md#master-failover).
    * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`. You can enable public access only if TLS support is enabled in the cluster.

    You can get the cluster ID with a [list of clusters in the folder](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-redis/api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.
