# Managing shards

You can enable sharding for a cluster as well as add and configure individual shards.

{% note warning %}

If a cluster uses [hybrid storage](../concepts/storage.md#hybrid-storage-features) at the [Preview](https://cloud.yandex.com/docs/overview/concepts/launch-stages) stage, only shards with a single host can be added to this cluster. This restriction is removed at the General Availability stage.

{% endnote %}

## Enabling sharding {#enable}

{{ mch-name }} clusters are created with one shard. To start sharding data, [add](#add-shard) one or more shards and [create](../tutorials/sharding.md#example) a distributed table.

## Adding a shard {#add-shard}

The number of shards in {{ mch-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find the **{{ mch-full-name }}** block.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and go to the **Hosts** tab.
  1. Click **Add shard**.
  1. Enter a name for the shard and add the desired number of hosts.
  1. Click **Create shard**.

- Terraform

    {% note info %}

    {{ TF }} doesn't allow specifying shard weight.

    {% endnote %}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Add a `CLICKHOUSE` type `host` block  with the `shard_name` field filled in to the {{ mch-name }} cluster description or change existing hosts:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          host {
            type       = "CLICKHOUSE"
            zone       = "<availability zone>"
            subnet_id  = yandex_vpc_subnet.<subnet in the availability zone>.id
            shard_name = "<shard name>"
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  To add a shard to the cluster, use the [addShard](../api-ref/Cluster/addShard.md) method.

{% endlist %}

## Listing shards in a cluster {#list-shards}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click the name of a cluster and open the **Shards** tab.

- API

  To list the shards in a cluster, use the [listShards](../api-ref/Cluster/listShards.md) method.

{% endlist %}

## Changing a shard {#shard-update}

You can change the shard weight as well as [host class](../concepts/instance-types.md) and storage size.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click the name of a cluster and open the **Shards** tab.
  1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Change**.

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
     {{ yc-mdb-ch }} shards update --cluster-name clickhouse12 \
                                   --name shard1 \
                                   --weight 80
     ```

   When the operation is complete, the CLI displays information about the changed shard:

   ```
   name: shard1
   cluster_id: c9fmo2rf013t4q0ab8m1
   config:
     clickhouse:
       config:
         effective_config:
           log_level: INFORMATION
     ...
   
     weight: "80"
   ```

- API

  To change the shard settings, use the [updateShard](../api-ref/Cluster/updateShard.md) method.

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ CH }} cluster provided that:

- It's not the only shard.
- It's not the only shard in a [group of shards](shard-groups.md).

When you delete a shard, all tables and data that are saved on that shard are deleted.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of a cluster and open the **Shards** tab.

  1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line of the desired host and select **Delete**.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Delete the `host` block with a shard description from the {{ mch-name }} cluster description.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the deletion of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Use the [deleteShard](../api-ref/Cluster/deleteShard.md) method to delete a shard.

{% endlist %}

