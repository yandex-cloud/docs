1. [Get an IAM token for API authentication](../../../../managed-valkey/api-ref/authentication.md) and place it in an environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../grpc-api-setup-repo.md) %}

1. Call the [ClusterService.DeleteHosts](../../../../managed-valkey/api-ref/grpc/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "host_names": [ "<host_name>" ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.redis.v1.ClusterService.DeleteHosts
    ```

    Where `host_names` is the name of the host to delete. To find out the name, [get the list of hosts in the cluster](../../../../managed-valkey/operations/hosts.md#list).

    You can get the cluster ID from the [list of clusters in your folder](../../../../managed-valkey/operations/cluster-list.md#list-clusters).

1. Check the [server response](../../../../managed-valkey/api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.
