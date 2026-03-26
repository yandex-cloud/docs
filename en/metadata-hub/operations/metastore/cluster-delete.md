# Deleting a {{ metastore-full-name }} cluster

You can delete a {{ metastore-name }} cluster along with all its stored data. Before that, [disable](cluster-update.md) cluster deletion protection if enabled.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder with the cluster.
    1. [Go](../../../console/operations/select-service#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Click ![image](../../../_assets/console-icons/ellipsis.svg) for the cluster and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
    1. Confirm cluster deletion.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To delete a {{ metastore-name }} cluster, run this command:

  ```bash
  {{ yc-metastore }} cluster delete <cluster_name_or_ID>
  ```
  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Delete](../../api-ref/Cluster/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<cluster_ID>'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../../api-ref/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Delete](../../api-ref/grpc/Cluster/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-metastore }}:{{ port-https }} \
            yandex.cloud.metastore.v1.ClusterService.Delete
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
