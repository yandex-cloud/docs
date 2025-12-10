# Restarting a host

You may need to restart hosts to promptly address such issues as:

* Resource overutilization
* Memory leak
* Request deadlock
* Unresponsive {{ CH }} operations and internal processes

{% list tabs group=instructions %}

- Management console {#console}

  To restart a single host:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
    1. In the host row, click ![icon](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
    1. In the window that opens, enable **I am restarting host** and click **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

  To restart multiple hosts in one go:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
    1. Select the hosts you want to restart and click **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}** at the bottom of the screen.
    1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  To restart one or multiple hosts, run the command below providing their names. Use the space character as a separator.

  Here is the command to restart a single host:

  ```bash
  {{ yc-mdb-ch }} host restart <host_name> \
     --cluster-name=<cluster_name>
  ```

  You can get the host name with the list of cluster hosts, and the cluster name, with the [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../../managed-clickhouse/api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. Call the [Cluster.RestartHosts](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/hosts:restartHosts' \
            --data '{
                      "hostNames": [
                        <list_of_host_names>
                      ]
                    }'
        ```

        Where `hostNames` is an array of strings. Each string is the name of the host to restart. You can get the host names with the [list of hosts in the cluster](../../../managed-clickhouse/operations/hosts.md#list-hosts).

        You can get the cluster ID with the [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../../managed-clickhouse/api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.RestartHosts](../../../managed-clickhouse/api-ref/grpc/Cluster/restartHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
                      <list_of_host_names>
                    ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.RestartHosts
        ```

        Where `host_names` is an array of strings. Each string is the name of the host to restart. You can get the host names with the [list of hosts in the cluster](../../../managed-clickhouse/operations/hosts.md#list-hosts).

        You can get the cluster ID with the [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../../managed-clickhouse/api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
