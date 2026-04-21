---
title: '{{ mgp-full-name }} cluster maintenance'
description: How to view information about cluster maintenance, postpone scheduled maintenance, and configure a maintenance window in {{ mgp-full-name }}.
---

# {{ mgp-full-name }} cluster maintenance

You can manage [maintenance](../concepts/maintenance.md) of a {{ mgp-full-name }} cluster.

## Getting a list of maintenance jobs {#list-maintenance}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Optionally, select a maintenance status above the maintenance list.

{% endlist %}

## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Select the maintenance. The maintenance page will open.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Postponing scheduled maintenance {#postpone-planned-maintenance}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status and select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. Select the reschedule type for the planned maintenance:
    
      * **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}**: Reschedule to the next maintenance window.
      * **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**: Reschedule to a specific date and time interval (UTC).

        For this option, select the date and UTC time interval.

        Maintenance can be postponed for a maximum of two weeks from the original scheduled date.
  
  1. Click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To postpone scheduled maintenance:
    
  1. View the description of the CLI command for rescheduling maintenance:
    
      ```bash
      {{ yc-mdb-gp }} cluster reschedule-maintenance --help
      ```
  
  1. Reschedule the maintenance:
    
      ```bash
      {{ yc-mdb-gp }} cluster reschedule-maintenance <cluster_name_or_ID> \
        --reschedule-type <reschedule_type>
      ```
    
      Where `reschedule_type` is reschedule type:
    
      * `next-available-window`: Next available maintenance window.
      * `specific-time`: Specific date and time, UTC.
        
        For this value, also use the `--delayed-until` parameter to provide a timestamp in one of these formats:
    
        * [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt).
        * HH:MM:SS.
        * Relative time to postpone maintenance for.
    
        > Here are some examples: `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, `3h30m ago`.

        Maintenance can be postponed for a maximum of two weeks from the original scheduled date.
    
      You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:
      
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  
      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:rescheduleMaintenance' \
        --data '{
                 "rescheduleType": "<reschedule_type>"
               }'
      ```

      Where `reschedule_type` is reschedule type:
    
      * `NEXT_AVAILABLE_WINDOW`: Next available maintenance window.
      * `SPECIFIC_TIME`: Specific date and time, UTC.
        
        For this value, also use the `delayedUntil` parameter to provide a timestamp in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format. Here is an example:

        > `2006-01-02T15:04:05Z`
    
        Maintenance can be postponed for a maximum of two weeks from the original scheduled date.
    
      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
  1. Check the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
             "cluster_id": "<cluster_ID>",
             "reschedule_type": "<reschedule_type>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.greenplum.v1.ClusterService.RescheduleMaintenance
      ```

      Where `reschedule_type` is reschedule type:
    
      * `NEXT_AVAILABLE_WINDOW`: Next available maintenance window.
      * `SPECIFIC_TIME`: Specific date and time, UTC.
        
        For this value, also use the `delayed_until` parameter to provide a timestamp in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format. Here is an example:

        > `2006-01-02T15:04:05Z`

        Maintenance can be postponed for a maximum of two weeks from the original scheduled date.
    
      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
  1. Check the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Starting scheduled maintenance immediately {#exec-planned-maintenance}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. In the maintenance row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To start scheduled maintenance immediately, do the following:
    
  1. View the description of the CLI command for rescheduling maintenance:
    
      ```bash
      {{ yc-mdb-gp }} cluster reschedule-maintenance --help
      ```
  
  1. Start scheduled maintenance immediately:
    
      ```bash
      {{ yc-mdb-gp }} cluster reschedule-maintenance <cluster_name_or_ID> \
        --reschedule-type immediate
      ```
    
      You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:
      
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  
      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:rescheduleMaintenance' \
        --data '{
                 "rescheduleType": "IMMEDIATE"
               }'
      ```
    
      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
  1. Check the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
             "cluster_id": "<cluster_ID>",
             "reschedule_type": "IMMEDIATE"
           }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.greenplum.v1.ClusterService.RescheduleMaintenance
      ```
    
      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
  1. Check the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}** in the top-right corner of the page.
  1. Select a maintenance window:
    
      * **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}**: Maintenance takes place at any time.
      * **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}**: Maintenance is scheduled for the selected day of the week and UTC time interval.

        For this type of maintenance, define the start of the maintenance window: select the day of the week and UTC time interval.

  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set a maintenance window:
    
  1. See the description of the CLI command for updating cluster settings:
    
      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```
  
  1. Set up a maintenance window:
    
      ```bash
      {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
        --maintenance-window type=<maintenance_type>,`
                            `day=<day_of_week>,`
                            `hour=<hour>
      ```
    
      Where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}
    
      You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more on how to create this file, see [Creating a cluster](cluster-create.md).

      For a complete list of configurable {{ GP }} cluster fields, see [this {{ TF }} provider guide]({{ tf-provider-mgp }}).

  1. To set up a [maintenance window](../concepts/maintenance.md#maintenance-window), add the `maintenance_window` section to the cluster description:
  
      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<local_cluster_name>" {
        ...
        maintenance_window {
          type = "<maintenance_type>"
        }
        ...
      }
      ```

      Where `type` is the maintenance type:

      * `ANYTIME`: Any time (default).
      * `WEEKLY`: On a schedule. For this value, also specify the following:
        
        * `day`: Day of week, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
        * `hour`: Hour of day (UTC), from `1` to `24`.

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}


- REST API {#api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:
      
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  
      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
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

      * `updateMask`: Comma-separated string of settings to update.

        In this example, only the `maintenanceWindow` setting is provided.

        {% note warning %}

        When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

        {% endnote %}

      * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md#maintenance-window) settings. Provide one of the values:

        * `anytime`: Allows performing maintenance at any time; default option.
          
          This parameter is provided as an empty object: `"anytime": {}`.
        
        * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

          * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
          * `hour`: Time of day (UTC), from `1` to `24`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
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
                 "hour": "<hour>"
               }
             }
           }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.greenplum.v1.ClusterService.Update
      ```
    
      Where:

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

        When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

        {% endnote %}

      * `maintenance_window`: [Maintenance window](../concepts/maintenance.md#maintenance-window) settings. Provide one of the values:

        * `anytime`: Allows performing maintenance at any time; default option.
          
          This parameter is provided as an empty object: `"anytime": {}`.

        * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

          * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
          * `hour`: Time of day (UTC), from `1` to `24`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}