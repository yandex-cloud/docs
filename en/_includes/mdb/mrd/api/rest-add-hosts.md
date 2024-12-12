1. [Get an IAM token for API authentication](../../../../managed-redis/api-ref/authentication.md) and put it into the environment variable:

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
                      "assignPublicIp": <public_access_to_cluster_host>
                    }
                  ]
                }'
    ```

    Where `hostSpecs` sets the host parameters:

    * `zoneId`: [Availability zone](../../../../overview/concepts/geo-scope.md).
    * `subnetId`: [Subnet ID](../../../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
    * `shardName`: Shard name for the host. Only used if [cluster sharding](../../../../managed-redis/concepts/sharding.md) is enabled.
    * `replicaPriority`: Priority for assigning the host as a master if the [primary master fails](../../../../managed-redis/concepts/replication.md#master-failover).
    * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`. You can enable public access only if TLS support is enabled in the cluster.

    You can get the cluster ID with a [list of clusters in the folder](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-redis/api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.
