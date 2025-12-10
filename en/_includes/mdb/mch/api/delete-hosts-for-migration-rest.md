1. Call the [Cluster.DeleteHosts](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

    ```bash
    curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/hosts:batchDelete' \
       --data '{
                 "hostNames": [
                   "<host_FQDN>"
                 ]
               }'
    ```

    Where `hostNames` is the array containing the host you want to delete.

    You can only specify one host FQDN per request. If you need to delete multiple hosts, make a separate request for each of them.

1. View the [server response](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.
