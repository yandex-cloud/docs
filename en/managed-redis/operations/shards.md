# Managing cluster shards

You can add and remove cluster shards, request a list of shards in the selected cluster, and rebalance your cluster.

{% note warning %}

You can only manage shards in sharded clusters. Existing non-sharded clusters can't be sharded later. To create a sharded cluster, see [Creating clusters](cluster-create.md#create-cluster).

{% endnote %}

## Listing shards in a cluster {#list}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click the name of a cluster and open the **Shards** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```
  $ yc managed-redis shards list --cluster-name <cluster name>
  +--------------+
  |     NAME     |
  +--------------+
  | test-shard-1 |
  | test-shard-2 |
  | test-shard-3 |
  | test-shard-4 |
  | test-shard-5 |
  +--------------+
  ```

{% endlist %}

## Getting detailed information about a shard {#get}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

To get information about a shard, run the following command:

```
$ {{ yc-mdb-rd }} shards get <shard name> --cluster-name <cluster name>
```

The cluster name and ID can be requested with a [list of clusters in the folder](cluster-list.md).

## Adding a shard {#add}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click on the name of the cluster and go to the **Shards** tab.

  1. Click **Add shard**.

  1. Specify the shard parameters:
      * Name of the shard.
      * Availability zones.
      * Add more hosts to the shard if needed.

  1. Click **Create shard**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a two-host shard to the cluster:

  ```
  $ yc managed-redis shards add --name <name of the new shard> --cluster-name <cluster name> \
    --host zone-id=<availability zone>,subnet-name=<subnet name> \
    --host zone-id=<availability zone>,subnet-name=<subnet name>
  ```

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

    1. Add the required number of `host` blocks to the {{ mrd-name }} cluster description and specify the shard name in the `shard_name` parameter:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster name>" {
          ...
          host {
            zone       = "<availability zone>"
            subnet_id  = <subnet ID>
            shard_name = "<shard name>"
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider's documentation]({{ tf-provider-mrd }}).

{% endlist %}

To be able to place data in the new shard, start {{ mrd-name }} [cluster rebalancing](#rebalance-cluster).

## Deleting a shard {#remove}

{% note alert %}

All the shard hosts are deleted with the shard.

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click on the name of a cluster and open the **Shards** tab.

  1. Click ![image](../../_assets/options.svg) in the row of the shard, then click **Delete** in the menu that opens.

  1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard from the cluster, run:

  ```
  $ {{ yc-mdb-rd }} shards delete <shard name>
       --cluster-name=<cluster name>
  ```

  The shard name can be requested with a [list of cluster shards](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

    To delete a shard from a cluster:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Delete all shard-related `host` blocks from the {{ mrd-name }} cluster description.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the deletion of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider's documentation]({{ tf-provider-mrd }}).

{% endlist %}

## Rebalancing a cluster {#rebalance-cluster}

New shards are created without hash slots and can't accept data. To begin populating a new shard with data, rebalance the cluster to allocate some of its hash slots to the new shard. The cluster will move the data in the reassigned hash slots to the appropriate shard. Rebalancing can be performed on a running cluster and does not affect data availability or integrity.

For more information, see [{#T}](../concepts/sharding.md#scaling).

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mrd-name }}**.
    1. Click on the name of the cluster you need.
    1. On the **Overview** tab, click **Rebalance**.

    {% note tip %}

    You can also rebalance a cluster using the **Rebalance cluster** button on the **Shards** tab.

    {% endnote %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To rebalance a cluster, run the command below:

  ```bash
  {{ yc-mdb-rd }} cluster rebalance \
     --name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

    You can rebalance a cluster using the [rebalance](../api-ref/Cluster/rebalance.md) method.

{% endlist %}
