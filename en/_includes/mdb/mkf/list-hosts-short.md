{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the relevant folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI {#cli}

   ```bash
   {{ yc-mdb-kf }} cluster list-hosts <cluster_name_or_ID>
   ```

   The FQDN is specified in the command output under `NAME`.

- REST API {#api}

    1. Use the [Cluster.listHosts](../../../managed-kafka/api-ref/Cluster/listHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/hosts'
        ```

        You can get the cluster ID with a [list of clusters in the folder](../../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../../managed-kafka/api-ref/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) to make sure the request was successful. The FQDN is specified in the response under `hosts[].name`.

- gRPC API {#grpc-api}

    1. Use the [ClusterService/ListHosts](../../../managed-kafka/api-ref/grpc/Cluster/listHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:443 \
            yandex.cloud.mdb.kafka.v1.ClusterService.ListHosts
        ```

        You can get the cluster ID with a [list of clusters in the folder](../../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../../managed-kafka/api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) to make sure the request was successful. The FQDN is specified in the response under `hosts[].name`.

{% endlist %}