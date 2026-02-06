{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  To get a list of cluster hosts, run this command:

  ```bash
  {{ yc-mdb-kf }} cluster list-hosts <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](../../../managed-kafka/operations/cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../../managed-kafka/api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. Call the [Cluster.listHosts](../../../managed-kafka/api-ref/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/hosts'
        ```

        You can get the cluster ID with the [list of clusters in the folder](../../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Check the [server response](../../../managed-kafka/api-ref/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../../managed-kafka/api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/ListHosts](../../../managed-kafka/api-ref/grpc/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        You can get the cluster ID with the [list of clusters in the folder](../../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Check the [server response](../../../managed-kafka/api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) to make sure your request was successful.

{% endlist %}
