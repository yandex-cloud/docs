---
title: '{{ metastore-name }} cluster maintenance'
description: Follow this guide to be able to view cluster maintenance info, postpone scheduled maintenance, and configure a maintenance window in {{ mgp-full-name }}.
---


# {{ metastore-full-name }} cluster maintenance

You can manage [maintenance](../../concepts/metastore-maintenance.md) of a {{ metastore-name }} cluster.


## Getting a list of maintenance jobs {#list-maintenance}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the name of your cluster and select the ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.

      To view maintenance jobs with a specific status, select the status you want from the **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** field above the list of maintenance jobs. To find a specific maintenance job, enter its ID or task name in the field above the list of maintenance jobs.

{% endlist %}


## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the name of your cluster and select the ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
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
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the name of your cluster and select the ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status and select ![image](../../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. Select the reschedule type for the planned maintenance:
    
      * **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}**: Reschedule to the next maintenance window.
      * **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**: Reschedule to a specific date and time.

        For this option, select the date and UTC time interval.

        Maintenance can be postponed for a maximum of two weeks from the original scheduled date.

  1. Click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

{% endlist %}


## Starting scheduled maintenance immediately {#exec-planned-maintenance}

If you need to, you can perform a maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately without waiting for the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

To run a scheduled cluster maintenance job immediately:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the name of your cluster and select the ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. In the maintenance row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

{% endlist %}


## Configuring a maintenance window {#set-maintenance-window}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. Click the name of your cluster and select the ![image](../../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
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