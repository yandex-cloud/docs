1. Use the [Cluster.DeleteHosts](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

    Where `hostNames` is the array with the host to delete.

    You can provide only one host FQDN in a single request. If you need to delete multiple hosts, make a separate request for each of them.

1. View the [server response](../../../../managed-clickhouse/api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.
