1. [Get an IAM token for API authentication](../../../../managed-valkey/api-ref/authentication.md) and place it in an environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Call the [Cluster.DeleteHosts](../../../../managed-valkey/api-ref/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

    Where `hostNames` is the name of the host to delete. To find out the name, [get the list of hosts in the cluster](../../../../managed-valkey/operations/hosts.md#list).

    You can get the cluster ID from the [list of clusters in your folder](../../../../managed-valkey/operations/cluster-list.md#list-clusters).

1. Check the [server response](../../../../managed-valkey/api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.
