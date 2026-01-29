# Managing subclusters {{ dataproc-name }}

In addition to [updating the settings](subcluster-update.md) of a particular subcluster, you can create new and delete existing subclusters.

{% note warning %}

Each cluster may only have one subcluster with a master host, which is why you cannot create or delete subclusters with this role. You cannot delete data storage subclusters either.

{% endnote %}

## Getting a list of subclusters in a cluster {#list-subclusters}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To request a list of {{ dataproc-name }} subclusters in a cluster, run the following command:

  ```bash
  {{ yc-dp }} subcluster list --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list).

{% endlist %}

## Creating a subcluster {#add-subcluster}

The number of hosts in {{ dataproc-name }} clusters is limited by [quotas]({{ link-console-quotas }}) regarding the number of vCPUs and the amount of RAM that VMs in your cloud can use. To view the available resources, navigate to the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) section and find **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you need.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** and select the cluster.
  1. Go to **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
  1. Click **{{ ui-key.yacloud.mdb.cluster.subclusters.action_add-subclaster }}**.
  1. Specify the subcluster settings:
     1. **{{ ui-key.yacloud.mdb.forms.base_field_hosts-count }}**: Select the number of hosts.
     1. **{{ ui-key.yacloud.mdb.forms.base_field_roles }}**: Select the subcluster roles depending on the services to deploy on the hosts:

         * `COMPUTENODE`: Role for processing data. In subclusters with this role, you can deploy YARN NodeManager and Spark libraries.
         * `DATANODE`: Role for storing data. In subclusters with this role, you can deploy YARN NodeManager, Spark libraries, HBase RegionServer, and HDFS Datanode.

     1. Under [**{{ ui-key.yacloud.mdb.forms.section_resource }}**](../concepts/instance-types.md), select a platform and computing resources available to the host.
     1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, specify the storage type and size.
     1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**:

         * Select **{{ ui-key.yacloud.mdb.forms.network_field_form-type }}**.
         * Specify **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** (subnet of the network hosting the cluster).
         * Optionally, enable **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** for online access to subcluster hosts.

             You will not be able to edit this setting after creating the subcluster.

             {% note tip %}

             You can delete data processing subclusters and recreate them with the required configuration.

             {% endnote %}

     1. Optionally, enable **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create-subcluster }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a subcluster:
  1. View the description of the CLI command for creating a subcluster:

     ```bash
     {{ yc-dp }} subcluster create --help
     ```

  1. Specify the subcluster settings in the create command properties in this command (the example does not show all that are available):

     ```bash
     {{ yc-dp }} subcluster create <subcluster_name> \
       --cluster-name=<cluster_name> \
       --role=<subcluster_role> \
       --resource-preset=<host_class> \
       --disk-type=<storage_type> \
       --disk-size=<storage_size_in_GB> \
       --subnet-name=<subnet_name> \
       --hosts-count=<number_of_hosts>
     ```

     Where:
     * `--cluster-name`: Cluster name. You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list).
     * `--role`: subcluster role, which can be either `datanode` or `computenode`.
     * `--resource-preset`: [Host class](../concepts/instance-types.md).
     * `--disk-type`: [Storage type](../concepts/storage.md), which can be `network-ssd`, `network-hdd`, or `network-ssd-nonreplicated`.
     * `--disk-size`: Storage size in GB.
     * `--subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet).
     * `--hosts-count`: Subcluster host count. The minimum value is `1`, and the maximum value is `32`.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. In the {{ dataproc-name }} cluster description, add a `subcluster_spec` section containing the settings for the new subcluster:

     ```hcl
     resource "yandex_dataproc_cluster" "data_cluster" {
       ...
       cluster_config {
         ...
         subcluster_spec {
           name = "<subcluster_name>"
           role = "<subcluster_role>"
           resources {
             resource_preset_id = "<host_class>"
             disk_type_id       = "<storage_type>"
             disk_size          = <storage_size_in_GB>
           }
           subnet_id   = "<subnet_ID>"
           hosts_count = <number_of_hosts_in_subcluster>
           ...
         }
       }
     }
     ```

     Where `role` is the subcluster role: `COMPUTENODE` or `DATANODE`.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  To learn more about resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Deleting a subcluster {#remove-host}

{% note warning %}

You cannot delete data storage subclusters.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a subcluster:
  1. In the [management console]({{ link-console-main }}), select the folder you need.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** and select the cluster.
  1. Go to **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the subcluster you need and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Optionally, specify the [decommissioning](../concepts/decommission.md) timeout.
  1. In the window that opens, click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-remove-subcluster_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a subcluster in a {{ dataproc-name }} cluster, run this command:

  ```bash
  {{ yc-dp }} subcluster delete <subcluster_name_or_ID> \
    --cluster-name=<cluster_name>
  ```

  You can request the subcluster name or ID with the [list of cluster subclusters](#list-subclusters), and the cluster name, with the [list of folder clusters](cluster-list.md#list).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Delete the `subcluster_spec` section of the relevant subcluster from the {{ dataproc-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  To learn more about resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}
