---
title: '{{ mpg-name }} disk space management'
description: When the storage usage exceeds 97%, the host automatically switches to read-only mode. You can monitor storage usage, configure its automatic scaling, and disable read-only mode.
---

# Managing disk space

When the [storage](../concepts/storage.md) usage exceeds 97%, the host automatically switches to read-only mode.
To prevent issues with database write operations, use one of the following methods:


* [Set up alerts in {{ monitoring-full-name }}](#set-alert) to monitor storage utilization.


* [Manually disable read-only mode for the cluster](#read-only-solutions) and free up the storage space by deleting non-essential data.
* [Increase the storage size](#change-disk-size) to automatically disable read-only mode. You can also change the disk type.
* [Set up storage autoscaling](#disk-size-autoscale).


## Set up alerts in {{ monitoring-full-name }} {#set-alert}

1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Select the **{{ ui-key.yacloud_monitoring.services.label_postgresql }}** service dashboard.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following settings:

    1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**: Configure the following metric settings:

        * Cloud
        * Folder
        * **{{ ui-key.yacloud_monitoring.services.label_postgresql }}** service
        * {{ mpg-name }} cluster ID

            You can get the cluster ID from the [folder’s cluster list](../operations/cluster-list.md#list-clusters).

        * `disk.free_bytes` label

    1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**: Define the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for disk usage percentage that will trigger the alert:

        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (metric’s minimum value over the period).
        * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: `90` (90% of the storage size).
        * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `95` (95% of the storage size).
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: Preferred metric update period.

    1. Add the notification channel you created earlier.


## Manually disable read-only mode for the cluster {#read-only-solutions}

{% note alert %}

Take measures to prevent free disk space from being fully depleted during the following operations. Otherwise, with the fail-safe mechanism disabled, {{ PG }} will crash, rendering the cluster inoperable.

{% endnote %}

To disable read-only mode:

1. [Connect to the database](../operations/connect.md) using your preferred method.

1. Start a transaction and run the following statement within it:

    ```sql
    SET LOCAL transaction_read_only TO off;
    ```

1. In the same transaction, clean up the data you no longer need using the `DROP` or `TRUNCATE` statements. Avoid the `DELETE` statement because it marks rows as deleted without physically purging them from the database.

1. Commit the transaction and restart all database connections.

> For example, to remove the `ExcessDataTable1` table you no longer need, use the following transaction:
>
> ```sql
> BEGIN;
> SET LOCAL transaction_read_only TO off;
> DROP TABLE ExcessDataTable1;
> COMMIT;
> ```

## Changing the disk type and increasing the storage size {#change-disk-size}

{% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

- Management console {#console}

    To change the disk type and increase the storage size for a cluster:

    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

        * Select the [disk type](../concepts/storage.md).
        * Specify the disk size.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the disk type and increase the storage size for a cluster:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Specify the [disk type](../concepts/storage.md) and the storage size in the cluster update command. The storage size must not be less than the `disk_size` value in the cluster settings:

        ```bash
        {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
            --disk-type <disk_type> \
            --disk-size <storage_size_in_GB>
        ```

- {{ TF }} {#tf}

    To change the disk type and increase the storage size for a cluster:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).

    1. In the {{ mpg-name }} cluster description, update the `disk_type_id` and `disk_size` attributes in the `config.resources` block:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
          ...
          config {
            resources {
              disk_type_id = "<disk_type>"
              disk_size    = <storage_size_in_GB>
              ...
            }
          }
        }
        ```

    1. Check if the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data '{
                 "updateMask": "configSpec.resources.diskTypeId,configSpec.resources.diskSize",
                 "configSpec": {
                   "resources": {
                     "diskTypeId": "<disk_type>",
                     "diskSize": "<storage_size_in_bytes>"
                   }
                 }
               }'
     ```

     Where:

     * `updateMask`: Comma-separated list of settings you want to update.

     * `configSpec.resources`: Storage settings:

         * `diskTypeId`: [Disk type](../concepts/storage.md).
         * `diskSize`: New storage size in bytes.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "update_mask": {
               "paths": [
                 "config_spec.resources.disk_type_id",
                 "config_spec.resources.disk_size"
               ]
             },
             "config_spec": {
               "resources": {
                 "disk_type_id": "<disk_type>",
                 "disk_size": "<storage_size_in_bytes>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

     * `config_spec.resources`: Storage settings:

         * `disk_type_id`: [Disk type](../concepts/storage.md).
         * `disk_size`: New storage size in bytes.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Setting up storage autoscaling {#disk-size-autoscale}

{% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

- Management console {#console}

    1. [Go to](../../console/operations/select-service.md#select-service) **{{ mpg-name }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**:

        1. In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, specify the storage usage percentage that will trigger storage increase. You can configure scaling rules to trigger:

            * At the next [maintenance window](../concepts/maintenance.md#maintenance-window).
            * Immediately.

            You can set both thresholds, provided that the threshold for immediate scaling is higher than that for scaling during the maintenance window.

            To learn more about storage scaling rules, see [this section](../concepts/storage.md#auto-rescale).

        1. In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set during automatic scaling.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To set up storage autoscaling:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. In the cluster update command, specify the maximum storage size and the conditions for autoscaling.

        Make sure the maximum storage size is greater than the `disk_size` cluster setting. The storage usage percentage triggering an immediate increase should be higher than the percentage scheduling an increase for the next [maintenance window](../concepts/maintenance.md#maintenance-window).

        ```bash
        {{ yc-mdb-pg }} cluster update <cluster_ID_or_name> \
            --disk-size-autoscaling disk-size-limit=<maximum_storage_size_in_bytes>,`
                                   `planned-usage-threshold=<scheduled_increase_percentage>,`
                                   `emergency-usage-threshold=<immediate_increase_percentage>
        ```

        If you have configured storage scaling during a maintenance window, set the maintenance schedule.

        To learn more about storage scaling rules, see [this section](../concepts/storage.md#auto-rescale).
        
- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).

    1. Add the `disk_size_autoscaling` section to the `config` block:

        {% include [disk-size-autoscaling](../../_includes/mdb/mpg/terraform/disk-size-autoscaling.md) %}
        
        {% note warning %}
        
        If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.
        
        {% endnote %}
    
    1. If you specified `planned_usage_threshold`, configure the [maintenance schedule](cluster-maintenance.md#set-maintenance-window).
    
    1. Check if the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data '{
                 "updateMask": "configSpec.diskSizeAutoscaling,maintenanceWindow",
                 "configSpec": {
                   "diskSizeAutoscaling": {
                     "plannedUsageThreshold": "<threshold_for_scheduled_increase_in_percent>",
                     "emergencyUsageThreshold": "<threshold_for_immediate_increase_in_percent>",
                     "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                   }
                 },
                 "maintenanceWindow": {
                   "weeklyMaintenanceWindow": {
                     "day": "<day_of_week>",
                     "hour": "<hour>"
                   }
                 }
               }'
     ```

     Where:

     * `updateMask`: Comma-separated list of settings you want to update.

       Here we provide only the `configSpec.diskSizeAutoscaling` and `maintenanceWindow` settings.

     * `configSpec`: Cluster settings:
       
       {% include [disk-size-autoscaling-rest](../../_includes/mdb/mpg/disk-size-autoscaling-rest.md) %}

         Use a value between `0` and `100`. The default value is `0` (autoscale disabled). The value of this setting must be greater than or equal to `plannedUsageThreshold`.

       * `diskSizeLimit`: Maximum storage size, in bytes, that can be set when one of the specified storage usage thresholds is met.

        To learn more about storage scaling rules, see [this section](../concepts/storage.md#auto-rescale).

     * `maintenanceWindow`: Maintenance window schedule. This setting is required only if `plannedUsageThreshold` is set. It contains the following subsettings:

       * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour of day, in `HH` format, for scheduled maintenance. The possible values range from `1` to `24`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "update_mask": {
               "paths": [
                 "config_spec.disk_size_autoscaling",
                 "maintenance_window"
               ]
             },
             "config_spec": {
               "disk_size_autoscaling": {
                 "planned_usage_threshold": "<threshold_for_scheduled_increase_in_percent>",
                 "emergency_usage_threshold": "<threshold_for_immediate_increase_in_percent>",
                 "disk_size_limit": "<maximum_storage_size_in_bytes>"
               }
             },
             "maintenance_window": {
               "weekly_maintenance_window": {
                 "day": "<day_of_week>",
                 "hour": "<hour>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here we provide only the `config_spec.disk_size_autoscaling` and `maintenance_window` settings.

     * `config_spec`: Cluster settings:

       {% include [disk-size-autoscaling-grpc](../../_includes/mdb/mpg/disk-size-autoscaling-grpc.md) %}

        To learn more about storage scaling rules, see [this section](../concepts/storage.md#auto-rescale).

     * `maintenance_window`: Maintenance window schedule. This setting is required only if `planned_usage_threshold` is set. Contains the following parameters:

       * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour of day, in `HH` format, for scheduled maintenance. The possible values range from `1` to `24`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

{% include [storage-resize-steps](../../_includes/mdb/mpg/storage-resize-steps.md) %}
