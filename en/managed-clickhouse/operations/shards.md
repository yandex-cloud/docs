# Managing shards in a {{ CH }} cluster

You can enable sharding for a cluster as well as add and configure individual shards.

## Enabling sharding {#enable}

{{ mch-name }} clusters are created with one shard. To start sharding data, [add](#add-shard) one or more shards and [create](../tutorials/sharding.md#example) a distributed table.

## Adding a shard {#add-shard}

The number of shards in {{ mch-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mch-full-name }}**.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and go to the **Shards** tab.
   1. Click **Add shard**.
   1. Specify the shard parameters:
      * Name and weight.
      * To copy the schema from a random replica of one of the shards to the hosts of the new shard, select the **Copy data schema** option.
      * The required number of hosts.
   1. Click **Create shard**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a shard to a cluster, run the command below (the parameter list in the example is not exhaustive):

   ```bash
   {{ yc-mdb-ch }} shards add <new shard name> \
      --cluster-name=<cluster name> \
      --host zone-id=<availability zone>,`
            `subnet-name=<subnet name>
   ```

   Where:

   
   * `<new shard name>`: Must be unique in a cluster.

      May contain Latin letters, numbers, hyphens, and underscores. The maximum length is 63 characters.
   * `--cluster-name` is the name of a cluster.

      The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * `--host`: Host parameters:
      * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet).


- {{ TF }}

   {% note info %}

   {{ TF }} doesn't allow specifying shard weight.

   {% endnote %}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Add a `CLICKHOUSE` type `host` block with the `shard_name` field filled in to the {{ mch-name }} cluster description or change existing hosts:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        host {
          type       = "CLICKHOUSE"
          zone       = "<availability zone>"
          subnet_id  = yandex_vpc_subnet.<subnet in availability zone>.id
          shard_name = "<shard name>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To add a shard to the cluster, use the [addShard](../api-ref/Cluster/addShard.md) method.

   To copy the data schema from a random replica of one of the shards to the hosts of the new shard, pass the `copySchema` parameter set to `true` in the request.

{% endlist %}

{% note warning %}

Use the copy data schema option only if the schema is the same on all cluster shards.

{% endnote %}

## Listing shards in a cluster {#list-shards}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click the name of a cluster and open the **Shards** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of shards in a cluster, run the following command:

   ```bash
   {{ yc-mdb-ch }} shards list --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To list the shards in a cluster, use the [listShards](../api-ref/Cluster/listShards.md) method.

{% endlist %}

## Changing a shard {#shard-update}

You can change the shard weight as well as [host class](../concepts/instance-types.md) and storage size.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click the name of a cluster and open the **Shards** tab.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Edit**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change a shard in the cluster:
   1. View a description of the CLI's shard change command:

      ```bash
      {{ yc-mdb-ch }} shards update --help
      ```

   1. Start an operation, such as changing the shard weight:

      ```bash
      {{ yc-mdb-ch }} shards update <shard name> \
         --cluster-name=<cluster name> \
         --weight=<shard weight>
      ```

      Where:
      * `<shard name>`: Can be requested with a [list of shards in a cluster](#list-shards).
      * `--cluster-name` is the name of a cluster.

         The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).
      * `--weight`: Shard weight. The minimum value is `0`.

      When the operation is complete, the CLI displays information about the changed shard.

- API

   Use the API [updateShard](../api-ref/Cluster/updateShard.md) method and pass the following in the call:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name of the shard in the `shardName` parameter.
   * Shard settings in the `configSpec` parameter.
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ CH }} cluster in case:
* It is not the only shard.
* It is not the only shard in a [shard group](shard-groups.md).

When you delete a shard, all tables and data that are saved on that shard are deleted.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of a cluster and open the **Shards** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired host and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a shard from the cluster, run:

   ```bash
   {{ yc-mdb-ch }} shards delete <shard name> \
      --cluster-name=<cluster name>
   ```

   You can request a shard name with a [list of cluster shards](#list-shards) and a cluster name with a [list of clusters in a folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Delete the `host` block with a shard description from the {{ mch-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the [deleteShard](../api-ref/Cluster/deleteShard.md) method to delete a shard.

{% endlist %}