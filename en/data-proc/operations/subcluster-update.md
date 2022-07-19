# Updating subclusters

You can perform the following actions for any subcluster:

* [{#T}](#change-host-number).
* [{#T}](#change-resource-preset).
* [{#T}](#change-autoscaling-rule).
* [{#T}](#change-disk-size).
* [{#T}](#change-sg-set).

## Changing the number of hosts {#change-host-number}

You can change the number of hosts in the `DATANODE` and the `COMPUTENODE` subclusters:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
   1. Select **{{ dataproc-name }}** and the desired cluster.
   1. Go to **Subclusters**.
   1. Click ![image](../../_assets/options.svg) for the desired subcluster and select **Edit**.
   1. Enter or select the required number of hosts in the **Hosts** field.
   1. Specify an optional [decommissioning](../concepts/decommission.md) timeout.
   1. Click **Save changes**.

   {{ dataproc-name }} runs the add host operation.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ dataproc-name }} cluster description, edit the value of the `hosts_count` parameter under `subcluster_spec` for the relevant `DATANODE` or `COMPUTENODE` subcluster:

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

   {{ dataproc-name }} runs the update subcluster operation. Note that all the hosts in the updated subcluster will be restarted.

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

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/dataproc_cluster).

{% endlist %}

## Changing the autoscaling rule for Compute subclusters {#change-autoscaling-rule}

You can set up the [autoscaling](../concepts/autoscaling.md) rule for hosts with the `COMPUTENODE` role:

{% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Select a cluster and open the **Subclusters** tab.
   1. Click the ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) for the desired subcluster and select **Edit**.
   1. Under **Scalability**, enable **Automatic scaling** if it's not activated.
   1. Set autoscaling parameters.
   1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **Default scaling** option and set the target CPU utilization level.
   1. Click **Save changes**.

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

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/dataproc_cluster).

{% endlist %}

## Increasing storage size {#change-disk-size}

You can increase the amount of storage available to each host in a particular subcluster.

{% note info %}

Currently, you cannot reduce storage size. If necessary, re-create the {{ dataproc-name }} subcluster.

{% endnote %}

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

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/dataproc_cluster).

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
        security_group_ids  = ["<list of cluster security group IDs>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/dataproc_cluster).

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](./connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
