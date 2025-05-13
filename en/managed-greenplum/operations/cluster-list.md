# Information about existing {{ GP }} clusters

You can request detailed information about each {{ mgp-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs group=instructions %}

- Management console {#console}

    Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To request a list of {{ GP }} clusters in a folder, run the following command:

    ```bash
    {{ yc-mdb-gp }} cluster list
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.list](../api-ref/Cluster/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters' \
            --url-query folderId=<folder_ID>
        ```

        
        You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


    1. View the [server response](../api-ref/Cluster/list.md#yandex.cloud.mdb.greenplum.v1.ListClustersResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.List](../api-ref/grpc/Cluster/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "folder_id": "<folder_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.List
        ```

        
        You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


    1. View the [server response](../api-ref/grpc/Cluster/list.md#yandex.cloud.mdb.greenplum.v1.ListClustersResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get information about the {{ GP }} cluster, run the following command:

    ```bash
    {{ yc-mdb-gp }} cluster get <cluster_name_or_ID>
    ```

    You can request the cluster ID and name with the [list of clusters in the folder](#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Get](../api-ref/Cluster/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>'
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.greenplum.v1.Cluster) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Get](../api-ref/grpc/Cluster/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Get
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.greenplum.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Getting information about cluster hosts {#get-hosts}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select the ![hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

    In the list of hosts, the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_role }}** column shows the role of each host:

    * `MASTER`: Primary master host to receive user connections.
    * `REPLICA`: Standby master host to replicate data of the primary master host.
    * `SEGMENT`: Segment host to store part of the cluster data.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of cluster master hosts, run the command:

    ```bash
    {{ yc-mdb-gp }} hosts list master \
       --cluster-name=<cluster_name>
    ```

    To get a list of cluster segment hosts, run the command:

    ```bash
    {{ yc-mdb-gp }} hosts list segment \
       --cluster-name=<cluster_name>
    ```

    You can request the cluster name with the [list of clusters in the folder](#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To get a list of cluster master hosts:

        1. Use the [Cluster.ListMasterHosts](../api-ref/Cluster/listMasterHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/master-hosts'
            ```

            You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

        1. View the [server response](../api-ref/Cluster/listMasterHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) to make sure the request was successful.

    1. To get a list of cluster segment hosts:

        1. Use the [Cluster.ListSegmentHosts](../api-ref/Cluster/listSegmentHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/segment-hosts'
            ```

            You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

        1. View the [server response](../api-ref/Cluster/listSegmentHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. To get a list of cluster master hosts:

        1. Use the [ClusterService.ListMasterHosts](../api-ref/grpc/Cluster/listMasterHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.greenplum.v1.ClusterService.ListMasterHosts
            ```

            You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

        1. View the [server response](../api-ref/grpc/Cluster/listMasterHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) to make sure the request was successful.

    1. To get a list of cluster segment hosts:

        1. Use the [ClusterService.ListSegmentHosts](../api-ref/grpc/Cluster/listSegmentHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.greenplum.v1.ClusterService.ListSegmentHosts
            ```

            You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

        1. View the [server response](../api-ref/grpc/Cluster/listSegmentHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) to make sure the request was successful.

{% endlist %}
