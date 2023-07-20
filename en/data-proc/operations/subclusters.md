# Managing subclusters {{ dataproc-name }}

In addition to [updating the settings](subcluster-update.md) of a particular subcluster, you can create new and delete existing subclusters.

{% note warning %}

Each cluster may have only 1 subcluster with a master host, which is why you can't create or delete such subclusters. You can't delete data storage subclusters either.

{% endnote %}

## Getting a list of subclusters in a {#list-subclusters} cluster

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click the name of the desired cluster and open the **Subclusters** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ dataproc-name }} subclusters in a cluster, run the following command:

   ```bash
   {{ yc-dp }} subcluster list --cluster-name=<cluster name>
   ```

   You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list).

{% endlist %}

## Adding a subcluster {#add-subcluster}

The number of hosts in {{ dataproc-name }} clusters is limited by [quotas]({{ link-console-quotas }}) by the number of vCPUs and the amount of RAM that VMs in your cloud can use. To view the resources available, go to the [Quotas]({{ link-console-quotas }}) section and find **{{ compute-full-name }}**.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ dataproc-name }}** and the desired cluster.
   1. Go to **Subclusters**.
   1. Click **Add subcluster**.
   1. Select the number of hosts.
   1. Select **Roles** in the subcluster. To do this, decide what services should be deployed on the hosts:
      * You can deploy the following in data storage subclusters:
         * HBase RegionServer.
         * HDFS Datanode.
         * YARN NodeManager.
         * Spark libraries.
      * You can deploy the following in data processing subclusters:
         * YARN NodeManager.
         * Spark libraries.
   1. Select the other subcluster settings:
      * The [host class](../concepts/instance-types.md), which dictates the platform and computing resources available to the host.
      * Type and size of storage.
      * Format to specify the network.
      * The subnet of the network where the cluster is located.
      * (Optional) Enable **Public access** for online access to subcluster hosts.

         This setting cannot be edited after the subcluster is created.

         {% note tip %}

         You can delete data processing subclusters and recreate them with the relevant setting value.

         {% endnote %}

      * (Optional) Enable **Autoscaling**.
   1. Click **Add subcluster**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a subcluster:
   1. View a description of the CLI create subcluster command:

      ```bash
      {{ yc-dp }} subcluster create --help
      ```

   1. Specify subcluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      ```bash
      {{ yc-dp }} subcluster create <subcluster name> \
         --cluster-name=<cluster name> \
         --role=<subcluster role> \
         --resource-preset=<host class> \
         --disk-type=<type of storage: network-ssd, network-hdd or network-ssd-nonreplicated> \
         --disk-size=<storage size in GB> \
         --subnet-name=<subnet name> \
         --hosts-count=<number of hosts>
      ```

      Where:
      * `--cluster-name` is the name of a cluster. You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list).
      * `--role`: Subcluster role (`datanode`, or `computenode`)
      * `--resource-preset`: [Host class](../concepts/instance-types.md).
      * `--disk-type`: [Storage type](../concepts/storage.md).
      * `--disk-size`: Storage size in GB.
      * `--subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet).
      * `--hosts-count`: Subcluster host count. The minimum value is `1` and the maximum value is `32`.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the {{ dataproc-name }} cluster description, add a `subcluster_spec` section containing the settings for the new subcluster:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name>" {
        ...
        cluster_config {
          ...
          subcluster_spec {
            name = "<subcluster name>"
            role = "<subcluster role: COMPUTENODE or DATANODE>"
            resources {
              resource_preset_id = "<host class>"
              disk_type_id       = "<storage type>"
              disk_size          = <storage size, GB>
            }
            subnet_id   = "<subnet ID in {{ TF }}>"
            hosts_count = <number of hosts in subcluster>
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Deleting a subcluster {#remove-host}

{% note warning %}

You cannot delete data storage subclusters.

{% endnote %}

{% list tabs %}

- Management console

   To delete a subcluster:
   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ dataproc-name }}** and the desired cluster.
   1. Go to **Subclusters**.
   1. Click ![image](../../_assets/options.svg) for the desired subcluster and select **Delete**.
   1. (Optional) Specify the [decommissioning](../concepts/decommission.md) timeout.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a subcluster in a {{ dataproc-name }} cluster, run the command:

   ```bash
   {{ yc-dp }} subcluster delete <subcluster ID or name> \
      --cluster-name=<cluster name>
   ```

   You can request a subcluster name or ID with a [list of cluster subclusters](#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the {{ dataproc-name }} cluster description, delete the `subcluster_spec` section for the desired subcluster.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type the word `yes`, then press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}