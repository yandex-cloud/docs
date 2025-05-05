---
title: '{{ PG }} cluster maintenance'
description: Follow this guide to view information about planned and performed {{ PG }} cluster maintenance and schedule maintenance.
---

# {{ PG }} cluster maintenance

{{ mpg-full-name }} cluster [maintenance](../concepts/maintenance.md) can be managed.

## Getting a list of maintenances {#list-maintenance}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.

To view maintenances with a particular status, click **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** above the list of maintenances and select the status of interest from the drop-down menu. You can also find a maintenance by its ID or task name: use the box above the list of maintenances.

## Getting cluster logs related to maintenance {#maintenance-logs}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click the maintenance ID you need.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

## Moving scheduled maintenance {#postpone-planned-maintenance}

Maintenance jobs with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status are scheduled for a particular date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can move them to a new date and time if needed.

{% list tabs group=instructions %}

- Management console {#console}

  To move a maintenance to a new date and time:

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. In the window that opens:
      * To move a maintenance forward to the next maintenance window, click **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** and then **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
      * To move a maintenance forward or backward to a specific UTC date and time, click **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, then select a new date and time interval and click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To move a maintenance to a new date and time:

  1. View the description of the CLI command to move maintenance:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance --help
      ```

  1. To move a maintenance to the nearest window, run the command by specifying the `next-available-window` reschedule type. To move to a specific date and time, specify the `specific-time` reschedule type:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance <cluster_name_or_ID> \
         --reschedule-type <reschedule_type> \
         --delayed-until <timestamp>
      ```

      The timestamp must have one of the following formats:
        * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt)
        * HH:MM:SS
        * Number of hours and minutes by which to move the maintenance.

      For example, `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, or `3h30m ago`. When selecting the `next-available-window` reschedule type, you do not need to specify `--delayed-until`.

  You can [get the cluster name with the list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  To move a maintenance to a new date and time:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.rescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) method and run the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:rescheduleMaintenance' \
        --data '{
                    "rescheduleType": <reschedule_type>,
                    "delayedUntil": <timestamp>
                }'
        ```

        Where `rescheduleType` is the reschedule type, which can take one of these two values:

          * `NEXT_AVAILABLE_WINDOW`: Move the maintenance to the nearest window.
          * `SPECIFIC_TIME`: Move the maintenance to a specific date and time.

        The timestamp must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2006-01-02T15:04:05Z`. When selecting the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `delayedUntil`.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) call and run the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "reschedule_type": <reschedule_type>,
             "delayed_until": <timestamp>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.RescheduleMaintenance
     ```

     Where `reschedule_type` is the reschedule type, which can take one of these two values:

        * `NEXT_AVAILABLE_WINDOW`: Move the maintenance to the nearest window.
        * `SPECIFIC_TIME`: Move the maintenance to a specific date and time.

     The timestamp must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2006-01-02T15:04:05Z`. When selecting the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `delayed_until`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Performing scheduled maintenance immediately {#exec-planned-maintenance}

If you need to, you can perform a maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately without waiting for the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

{% list tabs group=instructions %}

- Management console {#console}

  To perform a scheduled cluster maintenance immediately:

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the maintenance.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To perform a scheduled cluster maintenance immediately:

  1. View the description of the CLI command to move maintenance:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance --help
      ```

  1. Run this command with `immediate` for reschedule type:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance <cluster_name_or_ID> \
         --reschedule-type immediate
      ```

  You can [get the cluster name with the list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  To perform a scheduled cluster maintenance immediately:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.rescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) method and run the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:rescheduleMaintenance' \
        --data '{
                    "rescheduleType": "IMMEDIATE"
                }'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) call and run the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "reschedule_type": "IMMEDIATE"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.RescheduleMaintenance
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

By default, maintenance can be scheduled to any time slot. You can select a particular day of week and hour for the maintenance. For example, you can specify the time when the cluster is least loaded.

{% note warning %}

Selecting a new maintenance interval will automatically cancel any scheduled maintenance not falling within the new interval.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. In the window that opens:
     * To allow maintenance at any time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (default).
     * To allow maintenance once a week at a particular time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** and specify the day of week and hour in UTC.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating the maintenance window:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance --help
      ```

  1. Run this command:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour>
      ```

      Where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

  You can [get the cluster name with the list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

  1. {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

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
                 "updateMask": "maintenanceWindow",
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

       Only one parameter is provided in this case.

     * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). In `maintenanceWindow`, provide one of the two parameters:

       * `anytime`: Maintenance can be scheduled to any time slot.
       * `weeklyMaintenanceWindow`: Maintenance can be scheduled to selected day of week and time only:

         * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
         * `hour`: Hour of day (UTC) in `HH` format, from `1` to `24`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

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
               "paths": ["maintenance_window"]
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

       Only one parameter is provided in this case.

     * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). In `maintenance_window`, provide one of the two parameters:

       * `anytime`: Maintenance can be scheduled to any time slot.
       * `weekly_maintenance_window`: Maintenance can be scheduled to selected day of week and time only:

         * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
         * `hour`: Hour of day (UTC) in `HH` format, from `1` to `24`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}
