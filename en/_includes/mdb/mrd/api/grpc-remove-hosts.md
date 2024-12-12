1. [Get an IAM token for API authentication](../../../../managed-redis/api-ref/authentication.md) and put it into the environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. {% include [grpc-api-setup-repo](../../grpc-api-setup-repo.md) %}

1. Use the [ClusterService.DeleteHosts](../../../../managed-redis/api-ref/grpc/Cluster/deleteHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

    Where `host_names` is the name of the host to delete. To find out the name, [get a list of hosts in the cluster](../../../../managed-redis/operations/hosts.md#list).

    You can get the cluster ID with a [list of clusters in the folder](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-redis/api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.
