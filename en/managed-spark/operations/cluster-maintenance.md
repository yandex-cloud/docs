---
title: '{{ SPRK }} cluster maintenance'
description: Follow this guide to view the {{ SPRK }} cluster’s scheduled and completed maintenance jobs and schedule a maintenance window.
---

# {{ SPRK }} cluster maintenance

You can manage {{ SPRK }} cluster maintenance, including the following:

* [Getting a list of maintenance jobs](#list-maintenance)
* [Getting maintenance job details](#get-maintenance)
* [Getting cluster maintenance logs](#maintenance-logs)
* [Postponing scheduled maintenance](#postpone-planned-maintenance)
* [Starting scheduled maintenance immediately](#exec-planned-maintenance)
* [Configuring a maintenance window](#set-maintenance-window)

## Getting a list of maintenance jobs {#list-maintenance}

For {{ msp-name }}, you can get a list of maintenance jobs in a [cloud](#list-cloud-maintenance), [folder](#list-folder-maintenance), or [cluster](#list-cluster-maintenance).

### Getting a list of maintenance jobs in a cloud {#list-cloud-maintenance}

{% list tabs group=instructions %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cloud_id": "<cloud_ID>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.List
        ```

        
        Learn how to get a cloud ID in [this guide](../../resource-manager/operations/cloud/get-id.md).


    1. Check the [server response](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

### Getting a list of maintenance jobs in a folder {#list-folder-maintenance}

{% list tabs group=instructions %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<folder_ID>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.List
        ```

        
        Learn how to get a folder ID in [this guide](../../resource-manager/operations/folder/get-id.md).


    1. Check the [server response](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

### Getting a list of maintenance jobs in a cluster {#list-cluster-maintenance}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name and navigate to **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

    To view maintenance jobs with a specific status, click **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** above the list of maintenance jobs and select the status of interest from the drop-down menu. To find a specific maintenance job, enter its ID or task name in the field above the list of maintenance jobs.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [MaintenanceService.List](../api-ref/grpc/Maintenance/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "resource_id": "<cluster_ID>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.List
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

## Getting maintenance job details {#get-maintenance}

{% list tabs group=instructions %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [MaintenanceService.Get](../api-ref/grpc/Maintenance/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<maintenance_job_ID>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.Get
        ```

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance) to make sure your request was successful.

{% endlist %}

## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Click the cluster name and navigate to **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Click the ID of the maintenance job you need.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Moving scheduled maintenance {#postpone-planned-maintenance}

Maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status is scheduled for the date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can reschedule such maintenance to a new date and time if needed.

To reschedule maintenance for a new date and time:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name and navigate to **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status.
    1. In the drop-down menu, select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
    1. In the window that opens:
        * To postpone the maintenance until the next available window, click **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** and then **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
        * To move a maintenance forward or backward to a specific UTC date and time, click **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, then select a new date and time and click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<maintenance_job_ID>",
                "reschedule_type": "<reschedule_type>",
                "scheduled_at": "<timestamp>"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.Reschedule
        ```

        Where:

        * `reschedule_type`: Reschedule type, takes one of these two values:

            * `NEXT_AVAILABLE_WINDOW`: Postpone maintenance until the next available window.
            * `SPECIFIC_TIME`: Reschedule maintenance to a specific date and time.

        * `scheduled_at`: New service date and time. The value must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g.: `2006-01-02T15:04:05Z`. With the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `scheduled_at`.

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Starting scheduled maintenance immediately {#exec-planned-maintenance}

If you need to, you can perform a maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately without waiting for the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

To run a scheduled cluster maintenance job immediately:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name and navigate to **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance.
    1. In the drop-down menu, select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<maintenance_job_ID>",
                "reschedule_type": "IMMEDIATE"
              }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.MaintenanceService.Reschedule
        ```

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

By default, [maintenance](../concepts/maintenance.md) can be scheduled for any time. You can choose a specific day of week and hour interval for the maintenance. For example, you can specify the cluster's least busy time.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Click the cluster name and navigate to **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. In the window that opens:
     * To allow maintenance at any time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (default).
     * To allow weekly maintenance at a specific time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** and specify the day of the week and UTC time interval.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating the maintenance window:

      ```bash
      {{ yc-mdb-sp }} cluster update --help
      ```

  1. Run this command:

      ```bash
      {{ yc-mdb-sp }} cluster update <cluster_name_or_ID> \
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<sequence_number_of_hour_interval>
      ```

      Where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

      You can get the cluster name or ID [with the list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      Learn how to create this file in [Creating a cluster](cluster-create.md).

      For a complete list of configurable {{ SPRK }} cluster fields, see [this {{ TF }} provider guide]({{ tf-provider-msp }}).

  1. {% include [Maintenance window](../../_includes/mdb/msp/terraform/maintenance-window.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- gRPC API {#grpc-api}

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request.
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
       -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
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
           }' \
       {{ api-host-spark }}:{{ port-https }} \
       yandex.cloud.spark.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `maintenance_window`: [Maintenance](../concepts/maintenance.md) window settings, applying to both running and stopped clusters. Provide one of these two properties:

       * `anytime`: Any time.
       * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

         * `day`: Day of week, e.g., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
         * `hour`: UTC hour interval, from `1` to `24`.

           > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.spark.v1.Cluster) to make sure your request was successful.

{% endlist %}
