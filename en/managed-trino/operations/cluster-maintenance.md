---
title: '{{ TR }} cluster maintenance'
description: Follow this guide to view the {{ TR }} cluster’s scheduled and completed maintenance jobs and schedule a maintenance window.
---

# {{ TR }} cluster maintenance

You can manage [maintenance](../concepts/maintenance.md) of a {{ mtr-full-name }} cluster.

## Getting a list of maintenance jobs {#list-maintenance}

{% list tabs group=instructions %}

- Management console {#console}
  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-trino) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.

  To view maintenance jobs with a specific status, click **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** above the list of maintenance jobs and select the status you want from the drop-down menu. To find a specific maintenance job, enter its ID or task name in the field above the list of maintenance jobs.

{% endlist %}

## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-trino) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click the ID of the maintenance job you need.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Moving scheduled maintenance {#postpone-planned-maintenance}

Maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status is scheduled for the date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can reschedule them to a new date and time if needed.

To reschedule maintenance for a new date and time:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-trino) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
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

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-trino) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

By default, [maintenance](../concepts/maintenance.md) can be scheduled for any time. You can choose a specific day of the week and time interval to schedule maintenance. For example, you can specify the cluster's least busy time.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-trino) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. In the window that opens:
     * To allow maintenance at any time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}**, which is also the default option.
     * To allow weekly maintenance at a specific time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** and specify the day of the week and UTC time interval.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change your maintenance window settings:

  1. View the description of the CLI command for updating a cluster:

      ```bash
      {{ yc-mdb-tr }} cluster update --help
      ```

  1. Run this command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --deletion-protection \
          --maintenance-window type=<maintenance_type>,`
                              `day=<day_of_week>,`
                              `hour=<sequence_number_of_hour_interval>
        ```

        Where `type` is the maintenance type: 

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

     To learn how to create this file, refer to [Creating a cluster](cluster-create.md).

  1. To change maintenance time (including for disabled clusters), add the `maintenance_window` section to the cluster description:

     {% include [Terraform maintenance window parameters description](../../_includes/managed-trino/terraform/maintenance-window-parameters.md) %}

     You can get the cluster name with the [list of clusters](cluster-list.md#list-clusters) in the folder.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "updateMask": "maintenanceWindow",
        "maintenanceWindow": {
          "weeklyMaintenanceWindow": {
            "day": "<day_of_week>",
            "hour": "<sequence_number_of_hour_interval>"
          }
        }
      }
      ```

     Where:

        * `updateMask`: Comma-separated string of settings to update.

            Here, we provide only one setting. 

        * `maintenanceWindow`: Maintenance window settings, applying to both running and stopped clusters. Provide one of these two properties: 

            * `anytime`: Maintenance takes place at any time.
            * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

                * `day`: Day of week, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: UTC hour interval, from `1` to `24`.

                  > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>'
        --data '@body.json'
      ```

     You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "cluster_id": "<cluster_ID>",
        "update_mask": {
          "paths": ["maintenance_window"]
        },
        "maintenance_window": {
          "weekly_maintenance_window": {
            "day": "<day_of_week>",
            "hour": "<sequence_number_of_hour_interval>"
          }
        }
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.

          You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `maintenance_window`: Maintenance window settings (including for disabled clusters). Provide one of these two properties:

          * `anytime`: Maintenance takes place at any time.
          * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

            * `day`: Day of week, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
            * `hour`: UTC hour interval, from `1` to `24`.

              > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.ClusterService.Update \
        < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
