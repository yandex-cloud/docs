---
title: "Managing disk space"
description: "You can monitor storage usage and increase its size either manually or automatically."
---

# Managing disk space in a {{ mkf-name }} cluster

When the [storage](../concepts/storage.md) is more than 97% full, the host automatically switches to read-only mode. To avoid issues with writing to the database, use one of the following methods:


* [Set up alerts in {{ monitoring-full-name }}](#set-alert) to monitor storage utilization.


* [Increase the storage size](#change-disk-size) to automatically disable the read-only mode.
* [Set up automatic storage size increase](#disk-size-autoscale).


## Set up alerts in {{ monitoring-full-name }} {#set-alert}

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

    1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**: Set the following metric parameters:

        * Cloud
        * Folder
        * **{{ ui-key.yacloud_monitoring.services.label_managed-kafka }}** service
        * {{ mpg-name }} cluster ID

            You can [get](../operations/cluster-list.md#list-clusters) the cluster ID with a list of clusters in the folder.

        * `disk.free_bytes` label

    1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**: Set the condition for free disk space usage to trigger the alert:

        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (minimum metric value for the period).
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
        * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: `95` (95% of the storage size).
        * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `90` (90% of the storage size).
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: Preferred metric update period.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}**: Preferred time shift backward, in seconds. It enables preventing alert triggers when multiple metrics are specified and collected at different intervals. To learn more about the calculation delay, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

    1. **Notifications**: Add the previously created notification channel.


## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

* Management console {#console}

    To increase the cluster storage size:

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. In the appropriate cluster row, click ![image](../../_assets/console-icons/ellipsis.svg)and select. ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. Edit the settings in the **{{ ui-key.yacloud.mdb.forms.section_storage }}** section.

        You cannot change the disk type for an {{ KF }} cluster once you create it.

    1. Click **{{ ui-key.yacloud.common.save }}**.

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To increase the hosts' storage size:

    1. View a description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. To change the size of the broker host storage, run the command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --disk-size <storage_size>
        ```

        If no size units are specified, gigabytes are used.

    1. To change the size of the {{ ZK }} host storage, run the command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --zookeeper-disk-size <disk_size>
        ```

        If no size units are specified, gigabytes are used.

    You cannot change the disk type for a {{ KF }} cluster once you create it.

* {{ TF }} {#tf}

  To increase the cluster storage size:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, change the value of the `disk_size` parameter in the `kafka.resources` and `zookeeper.resources` blocks for {{ KF }} and {{ ZK }} hosts, respectively:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          kafka {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
            ...
          }
          zookeeper {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }
        }
        ```

        You cannot change the disk type for an {{ KF }} cluster once you create it.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster) provider documentation.

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

* API {#api}

    To increase the cluster storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * New storage settings in the `configSpec.kafka.resources` parameter (`configSpec.zookeeper.resources` for {{ ZK }} hosts).
    * List of settings to update, in the `updateMask` parameter.

    You cannot change the disk type for an {{ KF }} cluster once you create it.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Setting up automatic increase of storage size {#disk-size-autoscale}

To prevent the cluster disk space from running out, set up [automatic storage increase](../concepts/storage.md#auto-rescale).

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To set up automatic increase of storage size:

    1. View a description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Set the maximum storage size and conditions for its increase in the update cluster command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_ID_or_name> \
           --disk-size-autoscaling planned-usage-threshold=<scheduled_increase_percentage>,`
                                  `emergency-usage-threshold=<immediate_increase_percentage>,`
                                  `disk-size-limit=<maximum_storage_size_in_bytes>
        ```

        {% include [description-of-parameters](../../_includes/mdb/mkf/disk-auto-scaling.md) %}

* API {#api}

    To enable automatic increase of storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

    {% include [api-storage-resize](../../_includes/mdb/mpg/api-storage-resize.md) %}

{% endlist %}

{% include [storage-resize-steps](../../_includes/mdb/mkf/storage-resize-steps.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}

