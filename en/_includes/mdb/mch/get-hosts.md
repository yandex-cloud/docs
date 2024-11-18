# Getting a list of cluster hosts

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  To get a list of cluster hosts, run the command:

  ```bash
  {{ yc-mdb-ch }} host list \
     --cluster-name=<cluster_name>
  ```

  ```text
  +----------------------------+--------------+---------+--------+---------------+
  |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------------+--------------+---------+--------+---------------+
  | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
  | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
  +----------------------------+--------------+---------+--------+---------------+
  ```

  You can request the cluster name with the [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../../managed-clickhouse/api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. Use the [Cluster.listHosts](../../../managed-clickhouse/api-ref/Cluster/listHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/hosts'
        ```

        You can get the cluster ID with a [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../../managed-clickhouse/api-ref/Cluster/listHosts.md#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../../managed-clickhouse/api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/ListHosts](../../../managed-clickhouse/api-ref/grpc/Cluster/listHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:443 \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListHosts
        ```

        You can get the cluster ID with a [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../../managed-clickhouse/api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse) to make sure the request was successful.

{% endlist %}
