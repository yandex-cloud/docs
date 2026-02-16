# Master failover

In a fault-tolerant multi-host {{ mrd-name }} cluster, you can perform a manual failover from the current master host to a replica host. After the failover, the current master host becomes a replica for the new master.

Master failover normally takes a few minutes, with no downtime for the cluster.

A [sharded cluster](../concepts/sharding.md) contains one or more master hosts: one per [shard](../concepts/sharding.md#valkey-cluster-structure). Master failover in a sharded cluster is performed sequentially for each shard.

{% list tabs group=instructions %}

- Management console {#console}

    To switch the master in a non-sharded cluster:

    1. In the [management console]({{ link-console-main }}), navigate to the folder with the non-sharded cluster.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
    1. Next to the host with the `MASTER` role, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label-title }}**.
    1. In the window that opens, select **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label_confirmation }}** and click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

    To switch the master in a sharded cluster:

    1. In the [management console]({{ link-console-main }}), navigate to the folder with the sharded cluster.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}** service.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
    1. Next to the host with the `MASTER` role, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_label-title }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To switch the master in a non-sharded cluster, run this command:

    ```bash
    {{ yc-mdb-rd }} cluster start-failover \
      --name <cluster_name>
    ```

    To switch the master in a sharded cluster, run this command:

    ```bash
    {{ yc-mdb-rd }} cluster start-failover \
      --name <cluster_name> \
      --hostnames <current_master_name>
    ```

    You can get the cluster name with the [list of clusters in the folder](cluster-list.md), and the master name for the shard, with the [list of hosts in the cluster](hosts.md#list).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.StartFailover](../api-ref/Cluster/startFailover.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        To switch the master in a non-sharded cluster:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>:startFailover'
        ```

        To switch the master in a sharded cluster:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>:startFailover' \
            --data '{
                      "hostNames": [
                        "<current_master_name>"
                      ]
                    }'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the name of the current master, with the [list of hosts in the cluster](hosts.md#list).

    1. Check the [server response](../api-ref/Cluster/startFailover.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.StartFailover](../api-ref/grpc/Cluster/startFailover.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        To switch the master in a non-sharded cluster:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.StartFailover
        ```

        To switch the master in a sharded cluster:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "host_names": [
                    "<current_master_name>"
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.StartFailover
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the name of the current master with the [list of hosts in the cluster](hosts.md#list).

    1. Check the [server response](../api-ref/grpc/Cluster/startFailover.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
