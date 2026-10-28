---
title: '{{ PG }} cluster maintenance'
description: Follow this guide to view the {{ PG }} cluster’s scheduled and completed maintenance jobs and schedule a maintenance window.
---

# {{ PG }} cluster maintenance

You can manage [maintenance](../concepts/maintenance.md) of a {{ mpg-full-name }} cluster.

## Getting a list of maintenance jobs {#list-maintenances}

For {{ mpg-name }}, you can get a list of maintenance jobs in:

* [Cloud](#list-maintenance-cloud)
* [Folder](#list-maintenance-folder)
* [Cluster](#list-maintenance-cluster)

### Getting a list of maintenance jobs in a cloud {#list-maintenance-cloud}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Maintenance.List](../api-ref/Maintenance/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/?cloudId=<cloud_ID>'
     ```

  1. Check the [server response](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cloud_id": "<cloud_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.MaintenanceService.List
        ```

    1. Check the [server response](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

### Getting a list of maintenance jobs in a folder {#list-maintenance-folder}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Maintenance.List](../api-ref/Maintenance/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/?folderId=<folder_ID>'
     ```

     
     You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


  1. Check the [server response](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "folder_id": "<folder_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.MaintenanceService.List
        ```

        
        You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


    1. Check the [server response](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

### Getting a list of maintenance jobs in a cluster {#list-maintenance-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.

    To view maintenance jobs with a specific status, click **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** above the maintenance list and select the status you want from the drop-down menu. You can also find a maintenance job by its ID or job name using the search field above the list.

    Click an ID to see [how the maintenance job affects cluster availability](../concepts/maintenance.md#impact-on-cluster). Look up **{{ ui-key.yacloud.mdb.maintenance.title_task-details }}** to see how the maintenance job affects users.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Maintenance.List](../api-ref/Maintenance/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/?resourceId=<cluster_ID>'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "resource_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.MaintenanceService.List
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}

## Getting maintenance job details {#get-maintenance}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Maintenance.Get](../api-ref/Maintenance/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/<maintenance_job_ID>'
     ```

     You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenances).

  1. Check the [server response](../api-ref/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "maintenance_id": "<maintenance_job_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.MaintenanceService.Get
        ```

        You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenances).

    1. Check the [server response](../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance) to make sure your request was successful.

{% endlist %}

## Getting maintenance-related cluster logs {#maintenance-logs}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click the ID of the maintenance job you need.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

## Postpone the planned maintenance {#postpone-planned-maintenance}

Maintenance jobs with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status have a specific scheduled date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can reschedule them to a new date and time if needed.

{% list tabs group=instructions %}

- Management console {#console}

  To reschedule maintenance for a new date and time:

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance job with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. In the window that opens:
      * To postpone the maintenance until the next available window, click **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** and then **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
      * To reschedule maintenance to a specific UTC date and time, click **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, then select a new date and time interval and click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To reschedule maintenance for a new date and time:

  1. See the description of the CLI command for rescheduling maintenance :

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance --help
      ```

  1. To reschedule to the next available window, run this command using the `next-available-window` reschedule type. To reschedule to a specific date and time, use the `specific-time` reschedule type:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance <cluster_name_or_ID> \
         --reschedule-type <reschedule_type> \
         --delayed-until <timestamp>
      ```

      The timestamp must be in one of the following formats:
        * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt)
        * HH:MM:SS
        * Number of hours and minutes by which to move the maintenance.

      For example, `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, or `3h30m ago`. When selecting the `next-available-window` reschedule type, you do not need to specify `--delayed-until`.

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  You can reschedule a scheduled maintenance job using one of these methods:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)
  
  To postpone a scheduled maintenance job using the `Cluster.RescheduleMaintenance` method:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Send a request, e.g., using {{ api-examples.rest.tool }}:

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

      Where `rescheduleType` is the reschedule type that can be one of the  following values:

      * `NEXT_AVAILABLE_WINDOW`: Postpone maintenance until the next available window.
      * `SPECIFIC_TIME`: Move the maintenance to a specific date and time.

      The timestamp must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2006-01-02T15:04:05Z`. When selecting the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `delayedUntil`.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  To postpone a scheduled maintenance job using the `Maintenance.Reschedule` method:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Send a request, e.g., using {{ api-examples.rest.tool }}:

      ```bash
      curl \
      --request POST \
      --header "Authorization: Bearer $IAM_TOKEN" \
      --header "Content-Type: application/json" \
      --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/<maintenance_job_ID>:reschedule' \
      --data '{
                  "rescheduleType": <reschedule_type>,
                  "scheduledAt": <timestamp>
              }'
      ```

      Where `rescheduleType` is the reschedule type that can be one of the  following values:

      * `NEXT_AVAILABLE_WINDOW`: Postpone maintenance until the next available window.
      * `SPECIFIC_TIME`: Move the maintenance to a specific date and time.

      The timestamp must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2006-01-02T15:04:05Z`. With the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `scheduledAt`.

      You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenances).

  1. Check the [server response](../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  You can reschedule a scheduled maintenance job using one of these calls:
  
  * [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md)
  * [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md)

  To postpone a scheduled maintenance job using the `ClusterService.RescheduleMaintenance` call:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Send a request, e.g., using {{ api-examples.grpc.tool }}.

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

      Where `reschedule_type` is the reschedule type that can be one of the following values:

      * `NEXT_AVAILABLE_WINDOW`: Move the maintenance to the nearest window.
      * `SPECIFIC_TIME`: Move the maintenance to a specific date and time.

      The timestamp must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2006-01-02T15:04:05Z`. When selecting the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `delayed_until`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  To postpone a scheduled maintenance job using the `MaintenanceService.Reschedule` call:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Send a request, e.g., using {{ api-examples.grpc.tool }}.

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<maintenance_job_ID>",
              "reschedule_type": <reschedule_type>,
              "scheduled_at": <timestamp>
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.postgresql.v1.MaintenanceService.Reschedule
      ```

      Where `reschedule_type` is the reschedule type that can be one of the following values:

      * `NEXT_AVAILABLE_WINDOW`: Move the maintenance to the nearest window.
      * `SPECIFIC_TIME`: Move the maintenance to a specific date and time.

      The timestamp must be in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2006-01-02T15:04:05Z`. With the `NEXT_AVAILABLE_WINDOW` reschedule type, you do not need to specify `scheduled_at`.

      You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenances).

  1. Check the [server response](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Starting scheduled maintenance immediately {#exec-planned-maintenance}

If necessary, you can run a maintenance job with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately, prior to the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

{% list tabs group=instructions %}

- Management console {#console}

  To run a scheduled cluster maintenance job immediately:

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance job you need.
  1. In the drop-down menu, select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To run a scheduled cluster maintenance job immediately:

  1. See the description of the CLI command for rescheduling maintenance:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance --help
      ```

  1. Run this command using the `immediate` reschedule type:

      ```bash
      {{ yc-mdb-pg }} cluster reschedule-maintenance <cluster_name_or_ID> \
         --reschedule-type immediate
      ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  You can run a scheduled maintenance job immediately using one of these methods:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)
  
  To run a scheduled maintenance job immediately using the `Cluster.RescheduleMaintenance` method:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Send a request, e.g., using {{ api-examples.rest.tool }}:

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

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  To run a scheduled maintenance job immediately using the `Maintenance.Reschedule` method:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Send a request, e.g., using {{ api-examples.rest.tool }}:

      ```bash
      curl \
      --request POST \
      --header "Authorization: Bearer $IAM_TOKEN" \
      --header "Content-Type: application/json" \
      --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/maintenances/<maintenance_job_ID>:reschedule' \
      --data '{
                  "rescheduleType": "IMMEDIATE"
              }'
      ```

      You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenances).

  1. Check the [server response](../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  You can run a scheduled maintenance job immediately using one of these calls:
  
  * [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md)
  * [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md)

  To run a scheduled maintenance job immediately using the `ClusterService.RescheduleMaintenance` call:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Send a request, e.g., using {{ api-examples.grpc.tool }}:

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

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  To run a scheduled maintenance job immediately using the `MaintenanceService.Reschedule` call:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Send a request, e.g., using {{ api-examples.grpc.tool }}.

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/maintenance_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "maintenance_id": "<maintenance_job_ID>",
             "reschedule_type": "IMMEDIATE"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.MaintenanceService.Reschedule
     ```

     You can request the maintenance job ID along with the [list of maintenance jobs](#list-maintenances).

  1. Check the [server response](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

By default, maintenance can be scheduled for any time. You can choose a specific day of week and hour interval for the start of the maintenance. For example, you can specify the least busy time interval for the cluster.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
  1. In the window that opens:
     * To allow maintenance at any time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}**, which is also the default option.
     * To allow weekly maintenance at a specific time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** and specify the day of the week and UTC time interval.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating the maintenance window:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
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

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      To learn how to create this file, see [Creating a cluster](cluster-create.md).

      For the complete list of configurable {{ mpg-name }} cluster fields, see [this {{ TF }} provider guide]({{ tf-provider-mpg }}).

  1. {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

  1. Make sure the settings are correct.

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

     * `updateMask`: Comma-separated string of settings to update.

       Here, we provide only one setting.

     * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. In `maintenanceWindow`, provide one of these two parameters:

       * `anytime`: Maintenance can be scheduled for any time.
       * `weekly_maintenance_window`: Maintenance can only be scheduled for a specific day of week and a sequence number of an hour interval:

         * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
         * `hour`: UTC hour interval in `HH` format, from `1` to `24`.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

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
               "paths": ["maintenance_window"]
             },
             "maintenance_window": {
               "weekly_maintenance_window": {
                 "day": "<day_of_week>",
                 "hour": "<sequence_number_of_hour_interval>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. In `maintenance_window`, provide one of these two parameters:

       * `anytime`: Maintenance can be scheduled for any time.
       * `weekly_maintenance_window`: Maintenance can only be scheduled for a specific day of week and hour:

         * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
         * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}
