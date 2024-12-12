1. [Get an IAM token for API authentication](../../../../managed-redis/api-ref/authentication.md) and put it into the environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Use the [Cluster.DeleteHosts](../../../../managed-redis/api-ref/Cluster/deleteHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/hosts:batchDelete' \
        --data '{
                  "hostNames": [ "<host_name>" ]
                }'
    ```

    Where `hostNames` is the name of the host to delete. To find out the name, [get a list of hosts in the cluster](../../../../managed-redis/operations/hosts.md#list).

    You can get the cluster ID with a [list of clusters in the folder](../../../../managed-redis/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-redis/api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.
