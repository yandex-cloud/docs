# Information about {{ GP }} cluster hosts

You can get a list of hosts (masters and segments) in a {{ mgp-name }} cluster. To do this:

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the cluster name and select the ![hosts.svg](../../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

    In the list of hosts, the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_role }}** column shows the role of each host:

    * `MASTER`: Primary master host to receive user connections.
    * `REPLICA`: Standby master host to replicate data of the primary master host.
    * `SEGMENT`: Segment host to store part of the cluster data.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

    You can request the cluster name with a [list of clusters in the folder](../cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. To get a list of cluster master hosts:

        1. Use the [Cluster.ListMasterHosts](../../api-ref/Cluster/listMasterHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/master-hosts'
            ```

            You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

        1. View the [server response](../../api-ref/Cluster/listMasterHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) to make sure the request was successful.

    1. To get a list of cluster segment hosts:

        1. Use the [Cluster.ListSegmentHosts](../../api-ref/Cluster/listSegmentHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/segment-hosts'
            ```

            You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

        1. View the [server response](../../api-ref/Cluster/listSegmentHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. To get a list of cluster master hosts:

        1. Use the [ClusterService.ListMasterHosts](../../api-ref/grpc/Cluster/listMasterHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

            You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

        1. View the [server response](../../api-ref/grpc/Cluster/listMasterHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) to make sure the request was successful.

    1. To get a list of cluster segment hosts:

        1. Use the [ClusterService.ListSegmentHosts](../../api-ref/grpc/Cluster/listSegmentHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

            You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

        1. View the [server response](../../api-ref/grpc/Cluster/listSegmentHosts.md#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) to make sure the request was successful.

{% endlist %}


{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
