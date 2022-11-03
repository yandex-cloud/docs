# Updating subclusters

You can perform the following actions for any subcluster:

* [{#T}](#change-host-number).
* [{#T}](#change-resource-preset).
* [{#T}](#change-autoscaling-rule).
* [{#T}](#change-disk-size).
* [{#T}](#change-sg-set).

## Changing the number of hosts {#change-host-number}

You can change the number of hosts in data storage and processing subclusters:

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ dataproc-name }}**.
   1. Click the name of the desired cluster and open the **Subclusters** tab.
   1. Click ![image](../../_assets/options.svg) for the desired subcluster and select **Edit**.
   1. Enter or select the required number of hosts in the **Hosts** field.
   1. (Optional) Specify the [decommissioning](../concepts/decommission.md) timeout.
   1. Click **Save changes**.

   {{ dataproc-name }} runs the add host operation.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the number of hosts for a subcluster:

   1. View a description of the CLI update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update --help
      ```

   1. Set a new number of hosts in the update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update <subcluster ID or name> \
         --cluster-name=<cluster name> \
         --hosts-count=<number of hosts>
      ```

      You can request a subcluster name or ID with a [list of cluster subclusters](subclusters.md#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ dataproc-name }} cluster description, edit the value of the `hosts_count` parameter under `subcluster_spec` for the relevant data storage or processing subcluster:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name>" {
        ...
        cluster_config {
          ...
          subcluster_spec {
            name        = "<subcluster name>"
            ...
            hosts_count = <number of hosts in subcluster>
          }
        }
      }
      ```

{% endlist %}

## Changing the host class {#change-resource-preset}

You can change the computing power of hosts in a separate subcluster:

{% list tabs %}

- Management console

   To change the [host class](../concepts/instance-types.md) for a subcluster:

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
   1. Select **{{ dataproc-name }}** and the desired cluster.
   1. Go to **Subclusters**.
   1. Click ![image](../../_assets/options.svg) for the desired subcluster and select **Edit**.
   1. Select the required platform and configuration under **Host class**.
   1. Specify an optional [decommissioning](../concepts/decommission.md) timeout.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for a subcluster:

   1. View a description of the CLI update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update --help
      ```

   1. Request a list of available host classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):

      ```bash
      {{ yc-dp }} resource-preset list
      ```

      Result:

      ```text
      +-----------+--------------------------------+-------+----------+
      |    ID     |            ZONE IDS            | CORES |  MEMORY  |
      +-----------+--------------------------------+-------+----------+
      | b3-c1-m4  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 4.0 GB   |
      |           | {{ region-id }}-c                  |       |          |
      | ...                                                           |
      +-----------+--------------------------------+-------+----------+
      ```

   1. Specify the class in the update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update <subcluster ID or name> \
         --cluster-name=<cluster name> \
         --resource-preset=<host class>
      ```

      You can request a subcluster name or ID with a [list of cluster subclusters](subclusters.md#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ dataproc-name }} cluster description, edit the value of the `resource_preset_id` parameter under `subcluster_spec.resources` for the relevant subcluster:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name>" {
        ...
        cluster_config {
          ...
          subcluster_spec {
            name = "<subcluster name>"
            ...
            resources {
              resource_preset_id = "<subcluster host class>"
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/dataproc_cluster).

{% endlist %}

{{ dataproc-name }} runs the update subcluster operation. Note that all the hosts in the updated subcluster will be restarted.

## Changing the autoscaling rule for data processing subclusters {#change-autoscaling-rule}

You can configure the [autoscaling](../concepts/autoscaling.md) rule in data processing subclusters:

Make sure the cloud's quota is sufficient to increase the VM resources. Open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the **{{ compute-name }}** section still has space available in the following lines:

* **Total HDD capacity**.
* **Total SSD capacity**.
* **Number of disks**.
* **Number of vCPUs for instances**.
* **Number of instances**.

{% list tabs %}

- Management console

   {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Select a cluster and open the **Subclusters** tab.
   1. Click the ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) for the desired subcluster and select **Edit**.
   1. Under **Scalability**, enable **Automatic scaling** if it's not activated.
   1. Set autoscaling parameters.
   1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **Default scaling** option and set the target CPU utilization level.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set up [autoscaling](../concepts/autoscaling.md) for subclusters:

   1. View a description of the CLI update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update --help
      ```

   1. Set the autoscaling parameters in the update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update <subcluster ID or name> \
         --cluster-name=<cluster name> \
         --hosts-count=<minimum number of hosts> \
         --max-hosts-count=<maximum number of hosts> \
         --enable-preemptible=<use preemptible VMs: true or false> \
         --warmup-duration=<instance warmup period> \
         --stabilization-duration=<stabilization period> \
         --measurement-duration=<utilization measurement period> \
         --cpu-utilization-target=<target CPU utilization level, %> \
         --autoscaling-decommission-timeout=<decommissioning timeout>
      ```

      Where:

      * `--hosts-count`: Minimum number of hosts (VMs) in a subcluster. The minimum value is `1` and the maximum value is `32`.
      * `--max-hosts-count`: Maximum number of hosts (VMs) in a subcluster. The minimum value is `1` and the maximum value is `100`.
      * `--enable-preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used.
      * `--warmup-duration`: The time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s` and the maximum value is `600s` (10 minutes).
      * `--stabilization-duration`: The interval, in seconds, during which the required number of instances can't be decreased, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `1800s` (30 minutes).
      * `--measurement-duration`: The period, in seconds, for which utilization measurements should be averaged for each instance, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `600s` (10 minutes).
      * `--cpu-utilization-target`: Target CPU utilization level, %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used as a metric (based on the number of pending resources). The minimum value is `10` and the maximum value is `100`.
      * `--autoscaling-decommission-timeout`: [Decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0` and the maximum value is `86400` (24h).

      You can request a subcluster name or ID with a [list of cluster subclusters](#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ dataproc-name }} cluster description, add a `subcluster_spec.autoscaling_config` section with the required autoscaling settings for the relevant subcluster:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name>" {
        ...
        cluster_config {
          ...
          subcluster_spec {
            name = "<subcluster name>"
            role = "COMPUTENODE"
            ...
            autoscaling_config {
              max_hosts_count        = <maximum number of VMs in group>
              measurement_duration   = <load measurement interval (seconds)>
              warmup_duration        = <VM initialization time (seconds)>
              stabilization_duration = <stabilization interval (seconds)>
              preemptible            = <use preemptible VM: true or false>
              cpu_utilization_target = <target vCPU workload, %>
              decommission_timeout   = <VM decommissioning timeout (seconds)>
            }
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/dataproc_cluster).

{% endlist %}

## Increasing storage size {#change-disk-size}

You can increase the amount of storage available to each host in a particular subcluster.

{% note info %}

Currently, you cannot reduce storage size. If necessary, re-create the {{ dataproc-name }} subcluster.

{% endnote %}

Make sure the cloud's quota is sufficient to increase the VM resources. Open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the **{{ compute-name }}** section still has space available in the following lines:

* **Total HDD capacity**.
* **Total SSD capacity**.
* **Number of disks**.

{% list tabs %}

- Management console

   To change the storage size for a subcluster:

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
   1. Select **{{ dataproc-name }}** and the desired cluster.
   1. Go to **Subclusters**.
   1. Click ![image](../../_assets/options.svg) for the desired subcluster and select **Edit**.
   1. Enter or select the required amount of storage under **Storage size**.
   1. Click **Save changes**.

   {{ dataproc-name }} runs the update subcluster operation.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the storage size for a subcluster:

   1. View a description of the CLI update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update --help
      ```

   1. Specify the desired storage size in the update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update <subcluster ID or name> \
         --cluster-name=<cluster name> \
         --disk-size=<storage size in GB>
      ```

      You can request a subcluster name or ID with a [list of cluster subclusters](#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

   If all these conditions are met, {{ dataproc-name }} launches the operation to increase storage space.

- {{ TF }}

   To increase the subcluster storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ dataproc-name }} cluster description, edit the value of the `disk_size` parameter under `subcluster_spec.resources` for the relevant subcluster:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name>" {
        ...
        cluster_config {
          ...
          subcluster_spec {
            name = "<subcluster name>"
            ...
            resources {
              disk_size = <storage size, GB>
              ...
            }
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/dataproc_cluster).

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click on the name of the host you want.
   1. Under **Network**, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit network interface**.
   1. Select the appropriate security groups.
   1. Click **Save**.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Change the value of the `security_group_ids` parameter in the cluster description:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name>" {
        ...
        security_group_ids = ["<list of cluster security group IDs>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/dataproc_cluster).

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](./connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
