1. [Get an IAM token for API authentication](../../../../managed-redis/api-ref/authentication.md) and place it in an environment variable:

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
                  "assign_public_ip": <allow_public_access_to_host>
                }
              ] 
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.ClusterService.AddHosts
    ```


    Where `host_specs` represents the host parameters:

    * `zone_id`: [Availability zone](../../../../overview/concepts/geo-scope.md).
    * `subnet_id`: [Subnet ID](../../../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
    * `shard_name`: Shard name for the host. Only used if [cluster sharding](../../../../managed-redis/concepts/sharding.md) is enabled.
    * `replica_priority`: Host priority for assignment as a master if the [primary master fails](../../../../managed-redis/concepts/replication.md#master-failover).
    * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`. Public access is only a possibility if the cluster has TLS support enabled.

    You can get the cluster ID from the [folder’s cluster list](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. Check the [server response](../../../../managed-redis/api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.
