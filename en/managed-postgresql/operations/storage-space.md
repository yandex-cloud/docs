---
title: "Managing disk space"
description: "When the storage is more than 97% full, the host automatically switches to read-only mode. You can track storage usage, configure its automatic expansion, and disable the read-only mode."
---

# Managing disk space

When the [storage](../concepts/storage.md) is more than 97% full, the host automatically switches to read-only mode.
To avoid issues with writing to the database, use one of the following methods:


* [Set up alerts in {{ monitoring-full-name }}](#set-alert) to monitor storage usage.


* [Manually get the cluster out of the read-only mode](#read-only-solutions) and free up the storage space by deleting some data.
* [Increase the storage size](#change-disk-size) to automatically disable the read-only mode.
* [Set up automatic storage size increase](#disk-size-autoscale).


## Set up alerts in {{ monitoring-full-name }} {#set-alert}

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Select **{{ ui-key.yacloud_monitoring.services.label_postgresql }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following properties:

   1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**: Set the following metric parameters:

      * Cloud
      * Folder
      * **{{ ui-key.yacloud_monitoring.services.label_postgresql }}** service
      * {{ mpg-name }} cluster ID

         You can get the cluster ID [with a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

      * `disk.free_bytes` label

   1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**: Set the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for the percentage of free disk space to trigger the alert:

      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (a minimum metric value for the period)
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: `90` (90% of storage size)
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `95` (95% of storage size)
      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: Required period to update a metric value

   1. Add the previously created notification channel.


## Manually get the cluster out of the read-only mode {#read-only-solutions}

{% note alert %}

Do not allow free disk space to drop to zero during the following actions. Otherwise, since the fail-safe is disabled, {{ PG }} will crash and the cluster will stop working.

{% endnote %}

To disable the read-only mode:

1. [Connect to the database](../operations/connect.md) in any appropriate way.

1. Open a transaction and run the following command inside it:

   ```sql
   SET LOCAL transaction_read_only TO off;
   ```

1. As part of the same transaction, delete the data you do not need using the `DROP` or `TRUNCATE` operators. Do not use the `DELETE` operator, as it marks rows as deleted but does not physically delete them from the database.

1. Commit the transaction and restart all connections to the database.

> For example, if your database contains a table called `ExcessDataTable1` that you no longer need, delete it with the following transaction:
>
> ```sql
> BEGIN;
> SET LOCAL transaction_read_only TO off;
> DROP TABLE ExcessDataTable1;
> COMMIT;
> ```

## Increasing storage size {#change-disk-size}

{% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

- Management console {#console}

   To increase the cluster storage size:

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Select the cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, specify the required value.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase the cluster storage size:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

   1. Specify the required storage in the cluster update command (it must be at least as large as `disk_size` in the cluster properties):

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
          --disk-size <storage_size_in_GB>
      ```

- {{ TF }} {#tf}

   To increase the cluster storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. In the {{ mpg-name }} cluster description, change the `disk_size` attribute value under `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        config {
          resources {
            disk_size = <storage_size_in_GB>
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API {#api}

   To increase the cluster storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * New storage size in the `configSpec.resources.diskSize` parameter.
   * List of settings to update (in this case, `configSpec.resources.diskSize`) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Setting up automatic increase of storage size {#disk-size-autoscale}

{% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **Automatic increase of storage size**:

      1. In the **Increase size** field, set the storage usage percentage to trigger storage increase. You can set the increase rules:

         * In the next maintenance window
         * Immediately

         You can enable both rules, but the threshold for immediate increase should be higher than the threshold for increase during the maintenance window.

      1. In the **New storage size** field, specify the storage size to apply when any of the given conditions is met.

   1. Click **Save changes**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set up automatic increase of storage size:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

   1. Set a new storage size and conditions for increasing it in the update cluster command.

      Make sure it is larger than the `disk_size` value in the cluster properties. The percentage for increasing the storage size immediately should be higher than that for increasing it during the next maintenance window.

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster_ID_or_name> \
          --disk-size-autoscaling disk-size-limit=<new_storage_size_in_bytes>,`
                                 `planned-usage-threshold=<percentage_for_scheduled_increase>,`
                                 `emergency-usage-threshold=<percentage_for_immediate_increase>
      ```

- API {#api}

   To enable automatic increase of storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   {% include [api-storage-resize](../../_includes/mdb/mpg/api-storage-resize.md) %}

{% endlist %}

{% include [storage-resize-maintenance](../../_includes/mdb/mpg/storage-resize-maintenance.md) %}

{% include [storage-resize-reset](../../_includes/mdb/mpg/storage-resize-reset.md) %}
