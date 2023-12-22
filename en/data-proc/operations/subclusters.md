# Managing subclusters {{ dataproc-name }}

In addition to [updating the settings](subcluster-update.md) of a particular subcluster, you can create new and delete existing subclusters.

{% note warning %}

Each cluster may have only 1 subcluster with a master host, which is why you cannot create or delete subclusters with this role. You cannot delete data storage subclusters either.

{% endnote %}

## Getting a list of subclusters in a {#list-subclusters} cluster

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}** tab.

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

The number of hosts in {{ dataproc-name }} clusters is limited by [quotas]({{ link-console-quotas }}) by the number of vCPUs and the amount of RAM that VMs in your cloud can use. To view the available resources, go to the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) section and find **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** and the required cluster.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
   1. Click **{{ ui-key.yacloud.mdb.cluster.subclusters.button_create }}**.
   1. Specify the subcluster parameters:
      1. **{{ ui-key.yacloud.mdb.forms.base_field_hosts-count }}**: Select the number of hosts.
      1. **{{ ui-key.yacloud.mdb.forms.base_field_roles }}**: Select the subcluster roles depending on the services to be deployed on the hosts:

         * `COMPUTENODE`: Role for processing data. In subclusters with this role, you can deploy YARN NodeManager and Spark libraries.
         * `DATANODE`: Role for storing data. In subclusters with this role, you can deploy YARN NodeManager, Spark libraries, HBase RegionServer, and HDFS Datanode.

      1. Under [**{{ ui-key.yacloud.mdb.forms.section_resource }}**](../concepts/instance-types.md), select a platform and computing resources available to the host.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, specify the type and size of storage.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**:

         * Select **{{ ui-key.yacloud.mdb.forms.network_field_form-type }}**.
         * Specify **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** (subnet of the network where the cluster is located).
         * (Optional) Enable **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** for online access to subcluster hosts.

            This setting cannot be edited after the subcluster is created.

            {% note tip %}

            You can delete data processing subclusters and recreate them with the relevant setting value.

            {% endnote %}

      1. (Optional) Enable **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}**.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create-subcluster }}**.

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
      * `--cluster-name`: Cluster name. You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list).
      * `--role`: Subcluster role (`datanode`, or `computenode`).
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

   1. Confirm updating the resources.

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
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** and the required cluster.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the subcluster you need and select **{{ ui-key.yacloud.mdb.cluster.subclusters.button_action-delete }}**.
   1. (Optional) Specify the [decommissioning](../concepts/decommission.md) timeout.
   1. In the window that opens, click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-remove-subcluster_button }}**.

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
   1. In the {{ dataproc-name }} cluster description, delete the `subcluster_spec` section for the required subcluster.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}
