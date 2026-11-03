---
title: '{{ metastore-name }} cluster maintenance'
description: Follow this guide to be able to view cluster maintenance info, postpone scheduled maintenance, and configure a maintenance window in {{ mgp-full-name }}.
---


# {{ metastore-full-name }} cluster maintenance

You can manage [maintenance](../../concepts/metastore-maintenance.md) of a {{ metastore-name }} cluster.

## Getting a list of maintenance jobs {#list-maintenance}

For {{ metastore-name }}, you can get a list of maintenance jobs in a [cloud](#list-cloud-maintenance), [folder](#list-folder-maintenance), or [cluster](#list-cluster-maintenance).

### Getting a list of maintenance jobs in a cloud {#list-cloud-maintenance}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Maintenance.List](../../api-ref/Maintenance/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances?cloudId=<cloud_ID>'
        ```

        
        Learn how to get a cloud ID in [this guide](../../../resource-manager/operations/cloud/get-id.md).


    1. Check the [server response](../../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [MaintenanceService.List](../../api-ref/grpc/Maintenance/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cloud_id": "<cloud_ID>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.List
        ```

        
        Learn how to get a cloud ID in [this guide](../../../resource-manager/operations/cloud/get-id.md).


    1. Check the [server response](../../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

### Getting a list of maintenance jobs in a folder {#list-folder-maintenance}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Maintenance.List](../../api-ref/Maintenance/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances?folderId=<folder_ID>'
        ```

        
        Learn how to get a folder ID in [this guide](../../../resource-manager/operations/folder/get-id.md).


    1. Check the [server response](../../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [MaintenanceService.List](../../api-ref/grpc/Maintenance/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<folder_ID>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.List
        ```

        
        Learn how to get a folder ID in [this guide](../../../resource-manager/operations/folder/get-id.md).


    1. Check the [server response](../../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

### Getting a list of maintenance jobs in a cluster {#list-cluster-maintenance}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. Under **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}**, select **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Click the name of your cluster and select ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.

        To view maintenance jobs with a specific status, select the status you want from the **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** field above the list of maintenance jobs. To find a specific maintenance job, enter its ID or task name in the field above the list of maintenance jobs.

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Maintenance.List](../../api-ref/Maintenance/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances?resourceId=<cluster_ID>'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [MaintenanceService.List](../../api-ref/grpc/Maintenance/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "resource_id": "<cluster_ID>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.List
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

## Getting maintenance job details {#get-maintenance}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Maintenance.Get](../../api-ref/Maintenance/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances/<maintenance_job_ID>'
        ```

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../../api-ref/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [MaintenanceService.Get](../../api-ref/grpc/Maintenance/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<maintenance_job_ID>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.Get
        ```

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance) to make sure your request was successful.

{% endlist %}

## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Under **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}**, select **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the name of your cluster and select ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Select a maintenance job. The maintenance page will open.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Moving scheduled maintenance {#postpone-planned-maintenance}

Maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status is scheduled for the date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can reschedule it to a new date and time as needed.

To reschedule maintenance for a new date and time:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. Under **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}**, select **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Click the name of your cluster and select ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status and select ![image](../../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
    1. Select the reschedule type for the planned maintenance:

        * **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}**: Reschedule to the next maintenance window.
        * **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**: Reschedule to a specific date and time.

            For this option, select the date and UTC time interval. Maintenance can be postponed for a maximum of two weeks from the original scheduled date.

    1. Click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- REST API {#api}

    To reschedule maintenance for a new date and time:

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Maintenance.Reschedule](../../api-ref/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances/<maintenance_job_ID>:reschedule' \
        --data '{
                    "rescheduleType": "<reschedule_type>",
                    "scheduledAt": "<timestamp>"
                }'
        ```

        Where `rescheduleType` is the reschedule type that can be one of the  following values:

        * `NEXT_AVAILABLE_WINDOW`: Postpone maintenance until the next available window.
        * `SPECIFIC_TIME`: Move the maintenance to a specific date and time.

        The timestamp must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2006-01-02T15:04:05Z`. With the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `scheduledAt`.

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [MaintenanceService.Reschedule](../../api-ref/grpc/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<maintenance_job_ID>",
                "reschedule_type": "<reschedule_type>",
                "scheduled_at": "<timestamp>"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.Reschedule
        ```

        Where `reschedule_type` is the reschedule type that can be one of the following values:

        * `NEXT_AVAILABLE_WINDOW`: Move the maintenance to the nearest window.
        * `SPECIFIC_TIME`: Move the maintenance to a specific date and time.

        The timestamp must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2006-01-02T15:04:05Z`. With the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `scheduled_at`.

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Starting scheduled maintenance immediately {#exec-planned-maintenance}

If you need to, you can perform a maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately without waiting for the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

To run a scheduled cluster maintenance job immediately:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. Under **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}**, select **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Click the name of your cluster and select ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
    1. In the maintenance row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Maintenance.Reschedule](../../api-ref/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/maintenances/<maintenance_job_ID>:reschedule' \
        --data '{
                    "rescheduleType": "IMMEDIATE"
                }'
        ```

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [MaintenanceService.Reschedule](../../api-ref/grpc/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/metastore/v1/maintenance_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "maintenance_id": "<maintenance_job_ID>",
                "reschedule_type": "IMMEDIATE"
              }' \
          {{ api-host-metastore }}:{{ port-https }} \
          yandex.cloud.metastore.v1.MaintenanceService.Reschedule
        ```

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenance) in a cloud, folder, or cluster.

    1. Check the [server response](../../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Under **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}**, select **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the name of your cluster and select ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}**.
  1. Click ![image](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}** in the top-right corner of the page.
  1. Select cluster [maintenance](../../concepts/metastore-maintenance.md) time:

      {% include [Maintenance window](../../../_includes/metadata-hub/metastore-maintenance-window-console.md) %}

  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To configure a [maintenance window](../../concepts/metastore-maintenance.md#maintenance-window):

  1. See the description of the CLI command for updating cluster settings:

      ```bash
      {{ yc-metastore }} cluster update --help
      ```

  1. Configure the maintenance window:

      ```bash
      {{ yc-metastore }} cluster update <cluster_name_or_ID> \
        --maintenance-window type=<maintenance_type>,`
                            `day=<day_of_week>,`
                            `hour=<sequence_number_of_hour_interval>
      ```

      Where:

      * `<cluster_name_or_ID>`: Cluster name or ID which you can get with the [list of clusters in the folder](cluster-list.md#list-clusters).
      * `--maintenance-window`: [Maintenance window](../../concepts/metastore-maintenance.md) settings that apply to both running and stopped clusters. The `type` setting defines the maintenance type:

        {% include [maintenance-window](../../../_includes/mdb/cli/maintenance-window-description.md) %}


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      To learn how to create this file, see [Creating a cluster](cluster-create.md).

      For the complete list of configurable {{ metastore-name }} cluster fields, see [this {{ TF }} provider guide]({{ tf-provider-metastore }}).

  1. To set up a [maintenance window](../../concepts/metastore-maintenance.md#maintenance-window), add the `maintenance_window` section to the cluster description:

      ```hcl
      resource "yandex_metastore_cluster" "<local_cluster_name>" {
        ...
        maintenance_window = {
          type = "<maintenance_type>"
          day  = "<day_of_week>"
          hour = <sequence_number_of_hour_interval>
        }
        ...
      }
      ```

      Where:

      * `type`: Maintenance type. The possible values include:

        * `ANYTIME`: Any time.
        * `WEEKLY`: On a schedule.

      * `day`: Day of week for the `WEEKLY` type, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
      * `hour`: UTC hour interval for the `WEEKLY` type, from `1` to `24`.

        > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<cluster_ID>' \
        --data '{
                 "updateMask": "maintenanceWindow",
                 "maintenanceWindow": {
                   "weeklyMaintenanceWindow": {
                     "day": "<day_of_week>",
                     "hour": "<sequence_number_of_hour_interval>"
                   }
                 }
               }'
      ```

      Where:

      * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters in the folder](cluster-list.md#list-clusters).

      * `updateMask`: Comma-separated string of settings to update.

        In this example, only the `maintenanceWindow` setting is provided.

        {% note warning %}

        All settings of the cluster object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

        {% endnote %}

      * {% include [metastore-maintenance-window-rest](../../../_includes/metadata-hub/metastore-maintenance-window-rest.md) %}

  1. Check the [server response](../../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.Update](../../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
             "cluster_id": "<cluster_ID>",
             "update_mask": {
               "paths": [
                 "maintenance_window"
               ]
             },
             "maintenance_window": {
               "weekly_maintenance_window": {
                 "day": "<day_of_week>",
                 "hour": "<sequence_number_of_hour_interval>"
               }
             }
           }' \
        {{ api-host-metastore }}:{{ port-https }} \
        yandex.cloud.metastore.v1.ClusterService.Update \
      ```

      Where:

      * `cluster_id`: Cluster ID which you can get with the [list of clusters in the folder](cluster-list.md#list-clusters).
      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

        {% cut "Format for listing settings" %}

        ```yaml
        "update_mask": {
          "paths": [
            "<setting_1>",
            "<setting_2>",
            ...
            "<setting_N>"
          ]
        }
        ```

        {% endcut %}

        In this example, only the `maintenance_window` setting is provided.

        {% note warning %}

        All settings of the cluster object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

        {% endnote %}

      * {% include [metastore-maintenance-window-grpc](../../../_includes/metadata-hub/metastore-maintenance-window-grpc.md) %}

  1. Check the [server response](../../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
