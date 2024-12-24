1. Use the [ClusterService.DeleteHosts](../../../../managed-clickhouse/api-ref/grpc/Cluster/deleteHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

    ```bash
    grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "host_names": [
               "<host_FQDN>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
    ```

    Where `host_names` is the array with the host to delete.

    You can provide only one host FQDN in a single request. If you need to delete multiple hosts, make a separate request for each of them.

1. View the [server response](../../../../managed-clickhouse/api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.
