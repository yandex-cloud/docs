---
title: "How to update a subcluster in {{ dataproc-full-name }}"
description: "Follow this guide to update a subcluster."
---

# Updating subclusters

You can perform the following actions for any subcluster:

* [{#T}](#change-host-number).
* [{#T}](#change-resource-preset).
* [{#T}](#change-autoscaling-rule).
* [{#T}](#change-disk-size).
* [{#T}](#change-sg-set).

To move subclusters to a different availability zone, follow this [guide](migration-to-an-availability-zone.md).

## Changing the number of hosts {#change-host-number}

You can change the number of hosts in data storage and processing subclusters:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}** tab.
   1. Click ![image](../../_assets/options.svg) for the appropriate subcluster and select **{{ ui-key.yacloud.mdb.cluster.subclusters.button_action-edit }}**.
   1. Enter or select the required number of hosts in the **{{ ui-key.yacloud.mdb.forms.base_field_hosts-count }}** field.
   1. (Optional) Specify the [decommissioning](../concepts/decommission.md) timeout.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

   {{ dataproc-name }} will run the add host operation.

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

{% include [dedicated-hosts-edit-restrictions](../../_includes/data-proc/note-vm-edit-restrictions.md) %}

You can change the computing power of hosts in a separate subcluster:

{% list tabs %}

- Management console

   To change the [host class](../concepts/instance-types.md) for a subcluster:

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** and the required cluster.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
   1. Click ![image](../../_assets/options.svg) for the subcluster you need and select **{{ ui-key.yacloud.mdb.cluster.subclusters.button_action-edit }}**.
   1. Select the required platform and configuration under **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
   1. (Optional) Specify the [decommissioning](../concepts/decommission.md) timeout.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

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

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

{{ dataproc-name }} will run the update subcluster operation. Note that all the hosts in the updated subcluster will be restarted.

## Changing the autoscaling rule for data processing subclusters {#change-autoscaling-rule}

You can configure the [autoscaling](../concepts/autoscaling.md) rule in data processing subclusters:

Make sure the cloud quota is sufficient to increase the VM resources. Open the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) page for your cloud and check that the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** section still has space available in the following lines:

* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.hddDisks.size }}**.
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.ssdDisks.size }}**.
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.disks.count }}**.
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instanceCores.count }}**.
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instances.count }}**.

{% list tabs %}

- Management console

   {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}** tab.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) for the appropriate subcluster and select **{{ ui-key.yacloud.mdb.cluster.subclusters.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_scaling }}**, enable **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}** if it is disabled.
   1. Set autoscaling parameters.
   1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **{{ ui-key.yacloud.compute.groups.create.field_default-utilization-target }}** setting and specify the target CPU utilization level.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

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
      * `--warmup-duration`: Time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s` and the maximum value is `600s` (10 minutes).
      * `--stabilization-duration`: Period, in seconds, during which the required number of instances cannot be decreased, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `1800s` (30 minutes).
      * `--measurement-duration`: Period, in seconds, for which utilization measurements are averaged for each instance, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `600s` (10 minutes).
      * `--cpu-utilization-target`: Target CPU utilization level, in %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used as a metric (based on the number of pending resources). The minimum value is `10` and the maximum value is `100`.
      * `--autoscaling-decommission-timeout`: [Decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0` and the maximum value is `86400` (24 hours).

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
              stabilization_duration = <stabilization period (seconds)>
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

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [dedicated-hosts-edit-restrictions](../../_includes/data-proc/note-vm-edit-restrictions.md) %}

You can increase the amount of storage available to each host in a particular subcluster.

{% note info %}

Currently, you cannot reduce storage size. If necessary, re-create the {{ dataproc-name }} subcluster.

{% endnote %}

Make sure the cloud quota is sufficient to increase the VM resources. Open the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) page for your cloud and check that the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** section still has space available in the following lines:

* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.hddDisks.size }}**.
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.ssdDisks.size }}**.
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.disks.count }}**.

{% list tabs %}

- Management console

   To change the storage size for a subcluster:

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** and the required cluster.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
   1. Click ![image](../../_assets/options.svg) for the subcluster you need and select **{{ ui-key.yacloud.mdb.cluster.subclusters.button_action-edit }}**.
   1. Enter or select the required amount of storage under **{{ ui-key.yacloud.mdb.forms.section_disk }}**.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

   {{ dataproc-name }} will run the update subcluster operation.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the storage size for a subcluster:

   1. View a description of the CLI update subcluster command:

      ```bash
      {{ yc-dp }} subcluster update --help
      ```

   1. Specify the required storage size in the update subcluster command:

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

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
   1. Click the host name.
   1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
   1. Select the appropriate security groups.
   1. Click **{{ ui-key.yacloud.common.save }}**.

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

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](./connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
