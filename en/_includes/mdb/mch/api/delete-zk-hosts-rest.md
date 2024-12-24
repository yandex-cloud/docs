1. [Get an IAM token for API authentication](../../../../managed-clickhouse/api-ref/authentication.md) and put it into the environment variable:

    {% include [api-auth-token](../../api-auth-token.md) %}

1. Use the [Cluster.DeleteHosts](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/hosts:batchDelete' \
        --data '{
                  "hostNames": [
                    <list_of_host_names>
                  ]
                }'
    ```

    Where `hostNames` is an array of strings. Each string is the name of a host to delete. You can request host names with a [list of hosts in the cluster](#list-hosts).

    You can get the cluster ID with a [list of clusters in the folder](../../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. View the [server response](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.
