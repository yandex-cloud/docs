1. [Get an IAM token for API authentication](../../../../managed-redis/api-ref/authentication.md) and place it in an environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Use the [Cluster.AddHosts](../../../../managed-redis/api-ref/Cluster/addHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

    
    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/hosts:batchCreate' \
        --data '{
                  "hostSpecs": [
                    {
                      "zoneId": "<availability_zone>",
                      "subnetId": "<subnet_ID>",
                      "shardName": "<shard_name>",
                      "replicaPriority": "<host_priority>",
                      "assignPublicIp": <allow_public_access_to_host>
                    }
                  ]
                }'
    ```


    Where `hostSpecs` sets the host parameters:

    * `zoneId`: [Availability zone](../../../../overview/concepts/geo-scope.md).
    * `subnetId`: [Subnet ID](../../../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
    * `shardName`: Shard name for the host. Only used if [cluster sharding](../../../../managed-redis/concepts/sharding.md) is enabled.
    * `replicaPriority`: Host priority for assignment as a master if the [primary master fails](../../../../managed-redis/concepts/replication.md#master-failover).
    * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`. Public access is only a possibility if the cluster has TLS support enabled.

    You can get the cluster ID from the [folder’s cluster list](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. Check the [server response](../../../../managed-redis/api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.
