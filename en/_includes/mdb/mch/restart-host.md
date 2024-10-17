# Restarting a host

You may need to restart hosts to promptly address such issues as the following:

* Resource overrun
* Memory leak
* Deadlock between requests
* Unresponsive {{ CH }} operations and internal processes

To restart a host:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. In the required host row, click ![icon](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
   1. Confirm the host restart.

- CLI {#cli}

   {% include [cli-install](../../cli-install.md) %}

   {% include [default-catalogue](../../default-catalogue.md) %}

   To restart a host, run this command:

   ```bash
   {{ yc-mdb-ch }} host restart <host_name> \
      --cluster-name=<cluster_name>
   ```

   You can request the host name with a list of cluster hosts, and the cluster name, with a [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- REST API {#api}

   1. [Get an IAM token for API authentication](../../../managed-clickhouse/api-ref/authentication.md) and place it in the environment variable:

      {% include [api-auth-token](../../mdb/api-auth-token.md) %}

   1. Use the [Cluster.restartHosts](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

      Where `hostNames` is an array of strings. Each string is the name of a host to restart. You can request host names with a [list of hosts in the cluster](../../../managed-clickhouse/operations/hosts.md#list-hosts).

      You can request the cluster ID with a [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   1. View the [server response](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

   1. [Get an IAM token for API authentication](../../../managed-clickhouse/api-ref/authentication.md) and place it in the environment variable:

      {% include [api-auth-token](../../mdb/api-auth-token.md) %}

   1. {% include [grpc-api-setup-repo](../../mdb/grpc-api-setup-repo.md) %}

   1. Use the [ClusterService/RestartHosts](../../../managed-clickhouse/api-ref/grpc/Cluster/restartHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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
          {{ api-host-mdb }}:443 \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.RestartHosts
      ```

      Where `host_names` is an array of strings. Each string is the name of a host to restart. You can request host names with a [list of hosts in the cluster](../../../managed-clickhouse/operations/hosts.md#list-hosts).

      You can request the cluster ID with a [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

   1. View the [server response](../../../managed-clickhouse/api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
