---
title: How to update a subcluster in {{ dataproc-full-name }}
description: Follow this guide to update a subcluster.
---

# Updating subclusters

You can perform the following actions for any subcluster:

* [Change the number of hosts](#change-host-number).
* [Change the host class](#change-resource-preset).
* [Change the autoscaling rule for data processing subclusters](#change-autoscaling-rule).
* [Increase storage size](#change-disk-size).
* [Change security groups](#change-sg-set).

You can also change subclusters' availability zone. In which case they will be migrated to a different availability zone together with the {{ dataproc-name }} cluster. The process depends on the cluster type:

* [Migrating a lightweight cluster to a different availability zone](migration-to-an-availability-zone.md).
* [Migrating an HDFS cluster to a different availability zone](../tutorials/hdfs-cluster-migration.md).

## Changing the number of hosts {#change-host-number}

You can change the number of hosts in data storage and processing subclusters:

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the subcluster you need and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Enter or select the required number of hosts in the **{{ ui-key.yacloud.mdb.forms.base_field_hosts-count }}** field.
    1. (Optional) Specify the [decommissioning](../concepts/decommission.md) timeout.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    {{ dataproc-name }} will run the add host operation.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the number of hosts for a subcluster:

    1. View a description of the CLI update subcluster command:

        ```bash
        {{ yc-dp }} subcluster update --help
        ```
    
    1. Set a new number of hosts in the update subcluster command:

        ```bash
        {{ yc-dp }} subcluster update <subcluster_name_or_ID> \
           --cluster-name=<cluster_name> \
           --hosts-count=<number_of_hosts>
        ```

        You can request a subcluster name or ID with a [list of cluster subclusters](subclusters.md#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ dataproc-name }} cluster description, edit the value of the `hosts_count` parameter under `subcluster_spec` for the relevant data storage or processing subcluster:

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          cluster_config {
            ...
            subcluster_spec {
              name        = "<subcluster_name>"
              ...
              hosts_count = <number_of_hosts_in_subcluster>
            }
          }
        }
        ```

{% endlist %}

## Changing the host class {#change-resource-preset}

{% include [dedicated-hosts-edit-restrictions](../../_includes/data-processing/note-vm-edit-restrictions.md) %}

You can change the computing power of hosts in a separate subcluster. It depends on the driver deploy mode:

{% include [subcluster-computing-nodes](../../_includes/data-processing/subcluster-computing-nodes.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    To change the [host class](../concepts/instance-types.md) for a subcluster:

    1. In the [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** and the required cluster.
    1. Go to **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the subcluster you need and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Select the required platform and configuration under **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
    1. (Optional) Specify the [decommissioning](../concepts/decommission.md) timeout.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

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
        {{ yc-dp }} subcluster update <subcluster_name_or_ID> \
           --cluster-name=<cluster_name> \
           --resource-preset=<host_class>
        ```

        You can request a subcluster name or ID with a [list of cluster subclusters](subclusters.md#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ dataproc-name }} cluster description, change the `resource_preset_id` parameter value under `subcluster_spec.resources` of the relevant subcluster:

        ```hcl
        resource "yandex_dataproc_cluster" data_cluster {
          ...
          cluster_config {
            ...
            subcluster_spec {
              name = "<subcluster_name>"
              ...
              resources {
                resource_preset_id = "<subcluster_host_class>"
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

{{ dataproc-name }} will run the update subcluster operation. Note that all the hosts in the updated subcluster will be restarted.

## Changing the autoscaling rule for data processing subclusters {#change-autoscaling-rule}

You can configure the [autoscaling](../concepts/autoscaling.md) rule in data processing subclusters.

Make sure the cloud quota is sufficient to increase the VM resources. Open the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) page for your cloud and check that the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** section still has space available in the following lines:

* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.hddDisks.size }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.ssdDisks.size }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.disks.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instanceCores.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instances.count }}**

To enable autoscaling, make sure the {{ dataproc-name }} cluster service account has the following [roles assigned](../../iam/operations/sa/assign-role-for-sa.md):

{% include [sa-roles](../../_includes/data-processing/sa-roles.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    To configure autoscaling for subclusters:

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Select a cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}** tab.
    1. Click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) for the subcluster you need and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_scaling }}**, enable **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}** if it is disabled.
    1. Set autoscaling parameters.
    1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU utilization, disable the **{{ ui-key.yacloud.compute.groups.create.field_default-utilization-target }}** setting and specify the target CPU utilization level.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To configure autoscaling for subclusters:

    1. View a description of the CLI update subcluster command:

        ```bash
        {{ yc-dp }} subcluster update --help
        ```

    1. Set the autoscaling parameters in the update subcluster command:

        ```bash
        {{ yc-dp }} subcluster update <subcluster_name_or_ID> \
           --cluster-name=<cluster_name> \
           --hosts-count=<minimum_number_of_hosts> \
           --max-hosts-count=<maximum_number_of_hosts> \
           --enable-preemptible=<use_preemptible_VMs> \
           --warmup-duration=<VM_warmup_period> \
           --stabilization-duration=<stabilization_period> \
           --measurement-duration=<load_measurement_interval> \
           --cpu-utilization-target=<target_CPU_utilization_level> \
           --autoscaling-decommission-timeout=<decommissioning_timeout>
        ```

        Where:

        * `--hosts-count`: Minimum number of hosts (VMs) in a subcluster. The minimum value is `1`, and the maximum value is `32`.
        * `--max-hosts-count`: Maximum number of hosts (VMs) in a subcluster. The minimum value is `1`, and the maximum value is `100`.
        * `--enable-preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used. It can either be `true` or `false`.
        * `--warmup-duration`: Time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s`, and the maximum value is `600s`.
        * `--stabilization-duration`: Period, in seconds, during which the required number of VMs cannot be decreased, in `<value>s` format. The minimum value is `60s` and the maximum value is `1800s`.
        * `--measurement-duration`: Period, in seconds, for which the average utilization is calculated for each VM, in `<value>s` format. The minimum value is `60s` (1 minute), and the maximum value is `600s` (10 minutes).
        * `--cpu-utilization-target`: Target CPU utilization level, in %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used for scaling based on the number of pending resources. The minimum value is `10`, and the maximum value is `100`.
        * `--autoscaling-decommission-timeout`: [Decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0`, and the maximum value is `86400` (24 hours).

        You can request a subcluster name or ID with a [list of cluster subclusters](#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

- {{ TF }} {#tf}

    To configure autoscaling for subclusters:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ dataproc-name }} cluster description, add a section named `subcluster_spec.autoscaling_config` with the required autoscaling settings for the relevant subcluster:

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          cluster_config {
            ...
            subcluster_spec {
              name = "<subcluster_name>"
              role = "COMPUTENODE"
              ...
              autoscaling_config {
              max_hosts_count        = <maximum_number_of_VMs_in_group>
              measurement_duration   = <load_measurement_interval>
              warmup_duration        = <warmup_period>
              stabilization_duration = <stabilization_period>
              preemptible            = <use_preemptible_VMs>
              cpu_utilization_target = <target_CPU_utilization_level>
              decommission_timeout   = <decommissioning_timeout>
            }
          }
       ```

       Where:

       * `max_hosts_count`: Maximum number of hosts (VMs) in a subcluster. The minimum value is `1`, and the maximum value is `100`.
       * `measurement_duration`: Period, in seconds, for which the average utilization is calculated for each VM, in `<value>s` format. The minimum value is `60s` (1 minute), and the maximum value is `600s` (10 minutes).
       * `warmup_duration`: Time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s`, and the maximum value is `600s`.
       * `stabilization_duration`: Period, in seconds, during which the required number of VMs cannot be decreased, in `<value>s` format. The minimum value is `60s` and the maximum value is `1800s`.
       * `preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used. It can either be `true` or `false`.
       * `cpu_utilization_target`: Target CPU utilization level, in %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used for scaling based on the number of pending resources. The minimum value is `10`, and the maximum value is `100`.
       * `decommission_timeout`: [Decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0`, and the maximum value is `86400` (24 hours).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [dedicated-hosts-edit-restrictions](../../_includes/data-processing/note-vm-edit-restrictions.md) %}

You can increase the amount of storage available to each host in a particular subcluster.

{% note info %}

Currently, you cannot reduce storage size. If necessary, re-create the {{ dataproc-name }} subcluster.

{% endnote %}

Make sure the cloud quota is sufficient to increase the VM resources. Open the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) page for your cloud and check that the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** section still has space available in the following lines:

* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.hddDisks.size }}**.
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.ssdDisks.size }}**.
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.disks.count }}**.

{% list tabs group=instructions %}

- Management console {#console}

  To change the storage size for a subcluster:

    1. In the [management console]({{ link-console-main }}), select the folder with the cluster whose subcluster you want to change.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** and the required cluster.
    1. Go to **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the subcluster you need and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Enter or select the required amount of storage under **{{ ui-key.yacloud.mdb.forms.section_disk }}**.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    {{ dataproc-name }} will run the update subcluster operation.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the storage size for a subcluster:

    1. View a description of the CLI update subcluster command:

        ```bash
        {{ yc-dp }} subcluster update --help
        ```

    1. Specify the required storage size in the update subcluster command:

        ```bash
        {{ yc-dp }} subcluster update <subcluster_name_or_ID> \
           --cluster-name=<cluster_name> \
           --disk-size=<storage_size_in_GB>
        ```

        You can request a subcluster name or ID with a [list of cluster subclusters](#list-subclusters), and a cluster name with a [list of folder clusters](cluster-list.md#list).

    If all these conditions are met, {{ dataproc-name }} launches the operation to increase storage space.

- {{ TF }} {#tf}

    To increase the subcluster storage size:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ dataproc-name }} cluster description, change the `disk_size` parameter value under `subcluster_spec.resources` of the relevant subcluster:

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          cluster_config {
            ...
            subcluster_spec {
              name = "<subcluster_name>"
              ...
              resources {
                disk_size = <storage_size_in_GB>
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

    For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
    1. Click the host name.
    1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
    1. Select the appropriate security groups.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Change the value of the `security_group_ids` parameter in the cluster description:

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          security_group_ids = [ "<list_of_cluster_security_group_IDs>" ]
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](./connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
