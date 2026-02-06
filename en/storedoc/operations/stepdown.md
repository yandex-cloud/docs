# Primary replica failover

In a cluster with [multiple replicas](../concepts/replication.md), you can switch the primary replica if needed.

The switchover typically takes less than a minute. During the switchover, the cluster may be unwriteable for a few seconds.


{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}** tab.
    1. Locate the `PRIMARY` host in the list, click ![options](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yacloud.mongodb.hosts.action_stepdown-host }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To perform a primary replica switchover, run this command:

    ```bash
    {{ yc-mdb-mg }} hosts stepdown <current_primary_replica_name> \
       --name=<cluster_name>
    ```

    You can get the primary replica name for the required shard from the [cluster’s host list](hosts.md#list), and the cluster name from the [list of clusters in your folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.StepdownHosts](../api-ref/Cluster/stepdownHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:stepdownHosts' \
            --data '{
                     "hostNames": [
                        "<current_primary_replica_name>"
                     ]
                    }'
        ```

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters), and the primary replica name for the required shard from the [cluster’s host list](hosts.md#list).

    1. Check the [server response](../api-ref/Cluster/stepdownHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.StepdownHosts](../api-ref/grpc/Cluster/stepdownHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                 "cluster_id": "<cluster_ID>",
                 "host_names": [
                    "<current_primary_replica_name>"
                 ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.StepdownHosts
        ```    

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters), and the primary replica name for the required shard from the [cluster’s host list](hosts.md#list).

    1. Check the [server response](../api-ref/grpc/Cluster/stepdownHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
