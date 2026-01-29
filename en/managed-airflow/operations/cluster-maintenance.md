---
title: '{{ maf-full-name }} cluster maintenance'
description: Follow this guide to view information about planned and performed {{ maf-name }} cluster maintenance and to schedule maintenance.
---

# {{ maf-full-name }} cluster maintenance

You can manage [maintenance](../concepts/maintenance.md) of a {{ maf-name }} cluster.

## Getting a list of maintenance jobs {#list-maintenance}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.

  To view maintenance jobs with a specific status, click **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** above the maintenance list and select the status you want from the drop-down menu. To find a specific maintenance job, enter its ID or task name in the field above the list of maintenance sessions.

{% endlist %}

## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click the ID of the maintenance job you need.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Postponing scheduled maintenance {#postpone-planned-maintenance}

Maintenance sessions with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status are scheduled for the date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can reschedule them to a new date and time if needed.

To reschedule maintenance for a new date and time:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. In the window that opens:

      * To postpone the maintenance until the next available window, click **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** and then **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
      * To move a maintenance forward or backward to a specific UTC date and time, click **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, then select a new date and time and click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

{% endlist %}

## Starting scheduled maintenance immediately {#exec-planned-maintenance}

If you need to, you can perform a maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately without waiting for the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

To run a scheduled cluster maintenance job immediately:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

By default, maintenance can be scheduled for any time. You can choose a specific day of the week and hour to schedule maintenance. For example, you can choose the time when the cluster is least busy.

{% note warning %}

By selecting a new maintenance interval you will automatically cancel scheduled maintenance unless it falls within the new interval.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. In the window that opens:
  
     * To allow maintenance at any time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}**, which is also the default option.
     * To allow weekly maintenance at a specific time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** and specify the weekday and hour in UTC.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating the maintenance window:

      ```bash
      {{ yc-mdb-af }} cluster update --help
      ```

  1. Run this command:

      ```bash
      {{ yc-mdb-af }} cluster update <cluster_name_or_ID> \
          --maintenance-window type=<maintenance_type>,`
                              `day=<day_of_week>,`
                              `hour=<hour>
      ```

      Where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

      You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      To learn how to create this file, see [Creating a cluster](cluster-create.md).

  1. To set up a maintenance window, add the `maintenance_window` section to the cluster description:
  
      ```hcl
      resource "yandex_airflow_cluster" "<cluster_name>" {
        ...
        maintenance_window = {
          type = "<maintenance_type>"
          day  = "<day_of_week>"
          hour = <hour>
        }
        ...
      }
      ```
  
      {% include [Maintenance window description](../../_includes/mdb/terraform/maintenance-window-description.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-airflow }}/managed-airflow/v1/clusters/<cluster_ID>' \
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

     * `updateMask`: Comma-separated string of settings you want to update.

       Here, we provide only one setting.

     * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-rest.md) %}

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
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
       {{ api-host-airflow }}:{{ port-https }} \
       yandex.cloud.airflow.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-grpc.md) %}

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.


{% endlist %}

