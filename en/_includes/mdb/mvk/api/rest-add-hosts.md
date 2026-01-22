1. [Get an IAM token for API authentication](../../../../managed-valkey/api-ref/authentication.md) and save it as an environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Call the [Cluster.AddHosts](../../../../managed-valkey/api-ref/Cluster/addHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

    
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
    * `shardName`: Shard name for the host. Only used if [cluster sharding](../../../../managed-valkey/concepts/sharding.md) is enabled.
    * `replicaPriority`: Host priority for promotion to master if the [primary master fails](../../../../managed-valkey/concepts/replication.md#master-failover).
    * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`. You can only enable public access if your cluster supports TLS.

    You can get the cluster ID with the [list of clusters in the folder](../../../../managed-valkey/operations/cluster-list.md#list-clusters).


1. Check the [server response](../../../../managed-valkey/api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.
