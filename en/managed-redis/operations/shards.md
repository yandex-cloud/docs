# Managing cluster shards

You can add and remove cluster shards, request a list of shards in the selected cluster, and rebalance your cluster.

{% note warning %}

You can only manage shards in sharded clusters.

You can [create a sharded cluster](./cluster-create.md#create-cluster) or [enable sharding](./update.md#enable-sharding) in an existing non-sharded cluster.

{% endnote %}

## Listing shards in a cluster {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.redis.cluster.switch_shards }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of shards in a cluster, run the following command:

  ```bash
  {{ yc-mdb-rd }} shards list --cluster-name <cluster_name>
  ```

  Result:

  ```text
  +--------------+
  |     NAME     |
  +--------------+
  | test-shard-1 |
  | test-shard-2 |
  | test-shard-3 |
  +--------------+
  ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.ListShards](../api-ref/Cluster/listShards.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/shards'
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/listShards.md#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.ListShards](../api-ref/grpc/Cluster/listShards.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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
            yandex.cloud.mdb.redis.v1.ClusterService.ListShards
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listShards.md#yandex.cloud.mdb.redis.v1.ListClusterShardsResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a shard {#get}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a shard, run the following command:

  ```bash
  {{ yc-mdb-rd }} shards get <shard_name> --cluster-name <cluster_name>
  ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.GetShard](../api-ref/Cluster/getShard.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/shards/<shard_name>'
        ```

        You can request the cluster ID with a [list of clusters in a folder](cluster-list.md#list-clusters) and the shard name with a [list of shards in a cluster](#list).

    1. View the [server response](../api-ref/Cluster/getShard.md#yandex.cloud.mdb.redis.v1.Shard) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.GetShard](../api-ref/grpc/Cluster/getShard.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "shard_name": "<shard_name>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.GetShard
        ```

        You can request the cluster ID with a [list of clusters in a folder](cluster-list.md#list-clusters) and the shard name with a [list of shards in a cluster](#list).

    1. View the [server response](../api-ref/grpc/Cluster/getShard.md#yandex.cloud.mdb.redis.v1.Shard) to make sure the request was successful.

{% endlist %}

You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in a folder](cluster-list.md).

## Creating a shard {#add}

For clusters with the **local-ssd** disk type, the minimum allowed number of hosts per shard is two.

{% list tabs group=instructions %}

- Management console {#console}

  To add a shard:

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.redis.cluster.switch_shards }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
  1. Specify **{{ ui-key.yacloud.mdb.forms.base_field_shard-name }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:
     * (Optional) Edit the host settings.
     * Click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
     * In the **{{ ui-key.yacloud.mdb.forms.host_column_zone }}** field, choose the availability zone, select **{{ ui-key.yacloud.mdb.forms.host_column_subnetwork }}**, and enable the **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}** option.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  View a description of the CLI command for adding a shard:

  ```bash
  {{ yc-mdb-rd }} shards add --help
  ```

  To create a shard of two hosts, one with public access and the other with a [host priority](../concepts/replication.md#master-failover) of `50`, run this command:

  ```bash
  {{ yc-mdb-rd }} shards add --name=<new_shard_name> \
    --cluster-name=<cluster_name> \
    --host zone-id=<availability_zone>,`
      `subnet-name=<subnet_name>,`
      `assign-public-ip=true \
    --host zone-id=<availability_zone>,`
      `subnet-name=<subnet_name>,`
      `replica-priority=50
  ```

- {{ TF }} {#tf}

  To add a shard:

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Add the required number of `host` sections to the {{ mrd-name }} cluster description and specify the shard name in the `shard_name` parameter:

     ```hcl
     resource "yandex_mdb_redis_cluster" "<cluster_name>" {
       ...
       host {
         zone             = "<availability_zone>"
         subnet_id        = <subnet_ID>
         assign_public_ip = <public_access>
         replica_priority = <host_priority>
         shard_name       = "<shard_name>"
       }
     }
     ```

     Where `assign_public_ip` is public access to the host, `true` or `false`.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.AddShard](../api-ref/Cluster/addShard.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/shards' \
            --data '{
                      "shardName": "<shard_name>",
                      "hostSpecs": [
                        {
                          "zoneId": "<availability_zone>",
                          "subnetId": "<subnet_ID>",
                          "shardName": "<shard_name>",
                          "replicaPriority": "<host_priority>",
                          "assignPublicIp": <public_access_to_cluster_host>
                        },
                        { <similar_configuration_for_host_2> },
                        { ... },
                        { <similar_configuration_for_host_N> }
                      ]
                    }'
        ```

        Where:

        * `shardName`: Name of the shard you are creating.
        * `hostSpecs`: Host parameters:

            * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
            * `shardName`: Shard name for the host.
            * `replicaPriority`: Priority for assigning the host as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`. You can enable public access only if TLS support is enabled in the cluster.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "shard_name": "<shard_name>",
                  "host_specs": [
                    {
                      "zone_id": "<availability_zone>",
                      "subnet_id": "<subnet_ID>",
                      "shard_name": "<shard_name>",
                      "replica_priority": "<host_priority>",
                      "assign_public_ip": <public_access_to_cluster_host>
                    },
                    { <similar_configuration_for_host_2> },
                    { ... },
                    { <similar_configuration_for_host_N> }
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.AddShard
        ```

        Where:

        * `shard_name`: Name of the shard you are creating.
        * `host_specs`: Host parameters:

            * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
            * `shard_name`: Shard name for the host.
            * `replica_priority`: Priority for assigning the host as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`. You can enable public access only if TLS support is enabled in the cluster.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

1. View the [server response](../api-ref/grpc/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

To be able to place data in the new shard, start [rebalancing](#rebalance-cluster) the {{ mrd-name }} cluster.

## Deleting a shard {#remove}

{% note alert %}

* All the shard hosts are deleted with the shard.
* If a cluster has two or three shards, use the CLI, {{ TF }}, or API to delete a shard.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to delete the shard from.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.redis.cluster.switch_shards }}** tab.
  1. In the line with the shard, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.shards.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard from the cluster, run:

  ```bash
  {{ yc-mdb-rd }} shards delete <shard_name> \
    --cluster-name=<cluster_name>
  ```

  You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in a folder](cluster-list.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Delete all shard-related `host` blocks from the {{ mrd-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

  {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/shards/<shard_name>'
        ```

        You can request the cluster ID with a [list of clusters in a folder](cluster-list.md#list-clusters) and the shard name with a [list of shards in a cluster](#list).

    1. View the [server response](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "shard_name": "<shard_name>" 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.DeleteShard
        ```

        You can request the cluster ID with a [list of clusters in a folder](cluster-list.md#list-clusters) and the shard name with a [list of shards in a cluster](#list).

    1. View the [server response](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Rebalancing a cluster {#rebalance-cluster}

New shards are created without hash slots and can't accept data. To begin populating a new shard with data, rebalance the cluster to allocate some of its hash slots to the new shard. The cluster will move the data in the reassigned hash slots to the appropriate shard. Rebalancing can be performed on a running cluster and does not affect data availability or integrity.

For more information, see [{#T}](../concepts/sharding.md#scaling).

{% list tabs group=instructions %}

- Management console {#console}

  To rebalance a cluster:
  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name.
  1. In the **{{ ui-key.yacloud.common.overview }}** tab, click **{{ ui-key.yacloud.mdb.cluster.hosts.button_rebalance-cluster-short }}**.

  {% note tip %}

  You can also rebalance a cluster using the **{{ ui-key.yacloud.mdb.cluster.hosts.button_rebalance-cluster }}** button on the **{{ ui-key.yacloud.redis.cluster.switch_shards }}** tab.

  {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To rebalance a cluster, run the command below:

  ```bash
  {{ yc-mdb-rd }} cluster rebalance \
    --name=<cluster_name>
  ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Rebalance](../api-ref/Cluster/rebalance.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>:rebalance'
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/rebalance.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Rebalance](../api-ref/grpc/Cluster/rebalance.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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
            yandex.cloud.mdb.redis.v1.ClusterService.Rebalance
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/rebalance.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
