---
title: Managing disk space
description: When the storage is more than 97% full, the host automatically switches to read-only mode. You can track storage usage, configure its automatic expansion, and disable the read-only mode.
---

# Managing disk space

When the [storage](../concepts/storage.md) is more than 97% full, the host automatically switches to read-only mode.
To avoid issues with writing to the database, use one of the following methods:


* [Set up alerts in {{ monitoring-full-name }}](#set-alert) to monitor storage utilization.


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

            You can [get](../operations/cluster-list.md#list-clusters) the cluster ID with a list of clusters in the folder.

        * `disk.free_bytes` label

    1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**: Set the `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` condition for free disk space utilization percentage to trigger the alert:

        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (minimum metric value for the period).
        * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: `90` (90% of the storage size).
        * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `95` (95% of the storage size).
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: Preferred metric update period.

    1. Add the previously created notification channel.


## Manually get the cluster out of the read-only mode {#read-only-solutions}

{% note alert %}

Do not allow free disk space to drop to zero during the following actions. Otherwise, since the fail-safe mechanism is disabled, {{ PG }} will crash and the cluster will stop operating.

{% endnote %}

To disable the read-only mode:

1. [Connect to the database](../operations/connect.md) in any appropriate way.

1. Open a transaction and run the following command inside it:

    ```sql
    SET LOCAL transaction_read_only TO off;
    ```

1. As part of the same transaction, delete the data you do not need using the `DROP` or `TRUNCATE` operators. Do not use the `DELETE` operator, as it marks rows as deleted but does not physically delete them from the database.

1. Commit the transaction and restart all connections to the database.

> For example, if your database contains a table called `ExcessDataTable1` that you no longer need, delete it using the following transaction:
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
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, specify the required value.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To increase the cluster storage size:

    1. View the description of the update cluster CLI command:

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

        For more information about creating this file, see [Creating clusters](cluster-create.md).

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

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data '{
                 "updateMask": "configSpec.resources.diskSize",
                 "configSpec": {
                   "resources": {
                     "diskSize": "<storage_size_in_bytes>"
                   }
                 }
               }'
     ```

     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       Only one parameter is provided in this case.

     * `configSpec.resources.diskSize`: New storage size in bytes.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                 "config_spec.resources.disk_size"
               ]
             },
             "config_spec": {
               "resources": {
                 "disk_size": "<storage_size_in_bytes>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       Only one parameter is provided in this case.

     * `config_spec.resources.disk_size`: New storage size in bytes.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Setting up automatic increase of storage size {#disk-size-autoscale}

{% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ mpg-name }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**:

        1. In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, set the storage utilization percentage to trigger storage increase. You can configure the increase to take place:

            * During the next [maintenance window](../concepts/maintenance.md#maintenance-window).
            * Right away.

            You can enable both rules, but the threshold for immediate increase should be higher than that for increase during the maintenance window.

        1. In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set when increasing the storage size automatically.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To set up automatic increase of storage size:

    1. View the description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Set the maximum storage size and conditions for its increase in the update cluster command.

        Make sure the maximum storage size is greater than the `disk_size` value in the cluster properties. The percentage for immediate increase should be higher than that for increase during the next [maintenance window](../concepts/maintenance.md#maintenance-window).

        ```bash
        {{ yc-mdb-pg }} cluster update <cluster_ID_or_name> \
            --disk-size-autoscaling disk-size-limit=<maximum_storage_size_in_bytes>,`
                                   `planned-usage-threshold=<scheduled_increase_percentage>,`
                                   `emergency-usage-threshold=<immediate_increase_percentage>
        ```

        If you have set up the storage size to increase within the maintenance window, set up a schedule for the maintenance window.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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
                     "plannedUsageThreshold": "<scheduled_increase_percentage>",
                     "emergencyUsageThreshold": "<immediate_increase_percentage>",
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

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, provide only `configSpec.diskSizeAutoscaling` and `maintenanceWindow`.

     * `configSpec.diskSizeAutoscaling`: Automatic storage size increase settings:

       * `plannedUsageThreshold`: Storage utilization percentage to trigger a storage increase during the next maintenance window.

         Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled).

         If you have set this parameter, configure the maintenance window schedule in the `maintenanceWindow` parameter.

       * `emergencyUsageThreshold`: Storage utilization percentage to trigger an immediate storage increase.

         Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled). This parameter value must be greater than or equal to `plannedUsageThreshold`.

       * `diskSizeLimit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.

     * `maintenanceWindow`: Maintenance window schedule. It is required only if the `plannedUsageThreshold` parameter is set. Contains the following parameters:

       * `day`: Day of week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour, in `HH` format, for scheduled maintenance. The values range from `1` to `24`.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                 "planned_usage_threshold": "<scheduled_increase_percentage>",
                 "emergency_usage_threshold": "<immediate_increase_percentage>",
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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       In this case, provide only `config_spec.disk_size_autoscaling` and `maintenance_window`.

     * `config_spec.disk_size_autoscaling`: Automatic storage size increase settings:

       * `planned_usage_threshold`: Storage utilization percentage to trigger a storage increase during the next maintenance window.

         Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled).

         If you have set this parameter, configure the maintenance window schedule in the `maintenance_window` parameter.

       * `emergency_usage_threshold`: Storage utilization percentage to trigger an immediate storage increase.

         Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled). This parameter value must be greater than or equal to `planned_usage_threshold`.

       * `disk_size_limit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.

     * `maintenance_window`: Maintenance window schedule. It is required only if the `planned_usage_threshold` parameter is set. Contains the following parameters:

       * `day`: Day of week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour, in `HH` format, for scheduled maintenance. The values range from `1` to `24`.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

{% include [storage-resize-steps](../../_includes/mdb/mpg/storage-resize-steps.md) %}
