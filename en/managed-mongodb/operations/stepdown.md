# Selecting a different primary replica

If a cluster has [several replicas](../concepts/replication.md), you can select a different primary replica (master) as required.

Switching takes on average less than a minute. The cluster may be unavailable for writing for several seconds while switching is taking place.

For more information about selecting a different primary replica, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/rs.stepDown/).

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}** tab.
    1. Click ![options](../../_assets/console-icons/ellipsis.svg) in the `PRIMARY` host row and select **{{ ui-key.yacloud.mongodb.hosts.action_stepdown-host }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change a cluster's primary replica, run the command:

    ```bash
    {{ yc-mdb-mg }} hosts stepdown <current_primary_replica_name> \
       --name=<cluster_name>
    ```

    You can request the name of the shard primary replica with the [list of cluster hosts](hosts.md#list) and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.StepdownHosts](../api-ref/Cluster/stepdownHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the name of the shard primary replica, with the [list of cluster hosts](hosts.md#list).

    1. View the [server response](../api-ref/Cluster/stepdownHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.StepdownHosts](../api-ref/grpc/Cluster/stepdownHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the name of the shard primary replica, with the [list of cluster hosts](hosts.md#list).

    1. View the [server response](../api-ref/grpc/Cluster/stepdownHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
