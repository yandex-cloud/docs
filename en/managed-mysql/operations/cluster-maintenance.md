---
title: '{{ mmy-name }} cluster maintenance'
description: How to view information about cluster maintenance and configure a maintenance window in {{ mmy-full-name }}.
---


# {{ mmy-full-name }} cluster maintenance

You can manage [maintenance](../concepts/maintenance.md) of a {{ mmy-name }} cluster.


## Getting a list of maintenance jobs {#list-maintenance}

For {{ mmy-name }}, you can get a list of maintenance jobs in:

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
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances?cloudId=<cloud_ID>'
      ```
    
      
      Learn how to get a cloud ID in [this guide](../../resource-manager/operations/cloud/get-id.md).

  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cloud_id": "<cloud_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      
      Learn how to get a cloud ID in [this guide](../../resource-manager/operations/cloud/get-id.md).

  
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
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances?folderId=<folder_ID>'
      ```
    
      
      You can get the folder ID with the [list of folders](../../resource-manager/operations/folder/get-id.md) in the cloud.
      
  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "folder_id": "<folder_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      
      You can get the folder ID with the [list of folders](../../resource-manager/operations/folder/get-id.md) in the cloud.
      
  
  1. Check the [server response](../api-ref/grpc/Maintenance/list.md#yandex.cloud.maintenance.v2.ListMaintenancesResponse) to make sure your request was successful.

{% endlist %}


### Getting a list of maintenance jobs in a cluster {#list-maintenance-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the cluster.
  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select your cluster and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.

      To view maintenance jobs with a specific status, select the status you want from the **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** field above the list of maintenance jobs. You can also find a maintenance job by its ID or name using the search field above the list.

      Click an ID to see [how the maintenance job affects cluster availability](../concepts/maintenance.md#impact-on-cluster). Look up **{{ ui-key.yacloud.mdb.maintenance.title_task-details }}** to see how the maintenance job affects users.

- REST API {#api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Maintenance.List](../api-ref/Maintenance/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  
      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances?resourceId=<cluster_ID>'
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.
  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.List
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.
  
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
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances/<maintenance_job_ID>'
      ```
    
      You can get the maintenance job ID with the [list of maintenance jobs](#list-maintenance).
  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<maintenance_job_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.Get
      ```

      You can get the maintenance job ID with the [list of maintenance jobs](#list-maintenance).
  
  1. Check the [server response](../api-ref/grpc/Maintenance/get.md#yandex.cloud.maintenance.v2.Maintenance) to make sure your request was successful.

{% endlist %}


## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the cluster.
  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select your cluster and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Select a maintenance job.
  1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}


## Moving scheduled maintenance {#postpone-planned-maintenance}

Maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status is scheduled for the date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can postpone such maintenance for a maximum of two weeks from the original scheduled date and time.

{% list tabs group=instructions %}

- Management console {#console}

  To postpone scheduled maintenance:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the cluster.
  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select your cluster and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status and select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
  1. Select the rescheduling type:
    
      * **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}**: Postpone maintenance until the next available window.
      * **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**: Reschedule maintenance for a new date and time:

        For this option, select a date and UTC time interval.

  1. Click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To postpone scheduled maintenance:

  1. See the description of the CLI command for rescheduling maintenance :

      ```bash
      {{ yc-mdb-my }} cluster reschedule-maintenance --help
      ```

  1. Run this command to reschedule the maintenance job:

      ```bash
      {{ yc-mdb-my }} cluster reschedule-maintenance <cluster_name_or_ID> \
         --reschedule-type <reschedule_type> \
         --delayed-until <timestamp>
      ```
      Where:
      
      * `<cluster_name_or_ID>`: Cluster name or ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
      * `--reschedule-type`: Rescheduling type. The possible values are:
        
        * `next-available-window`: Postpone maintenance until the next available window.
        * `specific-time`: Reschedule maintenance for a new date and time.
      
      * `--delayed-until`: Timestamp for the `specific-time` type.
        
        The timestamp may be in one of the following formats:

        * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt)
        * HH:MM:SS
        * Maintenance time offset in hours and minutes

        > Here are some examples: `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, `3h30m ago`.

- REST API {#api}

  You can reschedule a scheduled maintenance job using one of these methods:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)

  To postpone a scheduled maintenance job using the `Cluster.RescheduleMaintenance` method:
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:rescheduleMaintenance' \
        --data '{
                  "rescheduleType": "<reschedule_type>",
                  "delayedUntil": "<timestamp>"
                }'
      ```

      Where:

      * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
      * `rescheduleType`: Rescheduling type. The possible values are:
        
        * `NEXT_AVAILABLE_WINDOW`: Postpone maintenance until the next available window.
        * `SPECIFIC_TIME`: Reschedule maintenance for a new date and time.
      
      * `delayedUntil`: Timestamp for the `SPECIFIC_TIME` type in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format.
        
        > Example: `2006-01-02T15:04:05Z`.

  1. Check the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  To postpone a scheduled maintenance job using the `Maintenance.Reschedule` method:
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
      
  1. Call the [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances/<maintenance_job_ID>:reschedule' \
        --data '{
                  "rescheduleType": "<reschedule_type>",
                  "scheduledAt": "<timestamp>"
                }'
      ```

      Where:

      * `<maintenance_job_ID>`: Maintenance job ID you can get with the [list of maintenance jobs](#list-maintenance).
      * `rescheduleType`: Rescheduling type. The possible values are:
        
        * `NEXT_AVAILABLE_WINDOW`: Postpone maintenance until the next available window.
        * `SPECIFIC_TIME`: Reschedule maintenance for a new date and time.
      
      * `scheduledAt`: Timestamp for the `SPECIFIC_TIME` type in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format.
        
        > Example: `2006-01-02T15:04:05Z`.

    1. Check the [server response](../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  You can reschedule a scheduled maintenance job using one of these calls:

  * [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md)
  * [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md)

  To postpone a scheduled maintenance job using the `ClusterService.RescheduleMaintenance` call:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "reschedule_type": "<reschedule_type>",
              "delayed_until": "<timestamp>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.ClusterService.RescheduleMaintenance
      ```

      Where:

      * `cluster_id`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
      * `reschedule_type`: Rescheduling type. The possible values are:
        
        * `NEXT_AVAILABLE_WINDOW`: Postpone maintenance until the next available window.
        * `SPECIFIC_TIME`: Reschedule maintenance for a new date and time.
      
      * `delayed_until`: Timestamp for the `SPECIFIC_TIME` type in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format.
        
        > Example: `2006-01-02T15:04:05Z`.

  1. Check the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  To postpone a scheduled maintenance job using the `MaintenanceService.Reschedule` call:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<maintenance_job_ID>",
              "reschedule_type": "<reschedule_type>",
              "scheduled_at": "<timestamp>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.Reschedule
      ```

      Where:

      * `maintenance_id`: Maintenance job ID you can get with the [list of maintenance jobs](#list-maintenance).
      * `reschedule_type`: Rescheduling type. The possible values are:
        
        * `NEXT_AVAILABLE_WINDOW`: Postpone maintenance until the next available window.
        * `SPECIFIC_TIME`: Reschedule maintenance for a new date and time.
      
      * `scheduled_at`: Timestamp for the `SPECIFIC_TIME` type in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format.
        
        > Example: `2006-01-02T15:04:05Z`.

  1. Check the [server response](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Starting scheduled maintenance immediately {#exec-planned-maintenance}

If you need to, you can perform a maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately without waiting for the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

{% list tabs group=instructions %}

- Management console {#console}

  To run a scheduled cluster maintenance job immediately:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the cluster.
  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select your cluster and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. In the maintenance row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To run a scheduled cluster maintenance job immediately:

  1. View the description of the CLI command for running a maintenance job:

      ```bash
      {{ yc-mdb-my }} cluster reschedule-maintenance --help
      ```

  1. Run this command to run the scheduled maintenance job:

      ```bash
      {{ yc-mdb-my }} cluster reschedule-maintenance <cluster_name_or_ID> \
         --reschedule-type immediate
      ```

      You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.
    
- REST API {#api}

  You can run a scheduled maintenance job immediately using one of these methods:

  * [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md)
  * [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md)

  To run a scheduled maintenance job immediately using the `Cluster.RescheduleMaintenance` method:
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Cluster.RescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:rescheduleMaintenance' \
        --data '{
                  "rescheduleType": "IMMEDIATE"
                }'
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

  1. Check the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.
  
  To run a scheduled maintenance job immediately using the `Maintenance.Reschedule` method:
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
      
  1. Call the [Maintenance.Reschedule](../api-ref/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/maintenances/<maintenance_job_ID>:reschedule' \
        --data '{
                  "rescheduleType": "IMMEDIATE"
                }'
      ```

      You can get the maintenance job ID with the [list of maintenance jobs](#list-maintenance).

    1. Check the [server response](../api-ref/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  You can run a scheduled maintenance job immediately using one of these calls:

  * [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md)
  * [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md)

  To run a scheduled maintenance job immediately using the `ClusterService.RescheduleMaintenance` call:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>",
              "reschedule_type": "IMMEDIATE"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.ClusterService.RescheduleMaintenance
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

  1. Check the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  To run a scheduled maintenance job immediately using the `MaintenanceService.Reschedule` call:

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [MaintenanceService.Reschedule](../api-ref/grpc/Maintenance/reschedule.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/maintenance_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "maintenance_id": "<maintenance_job_ID>",
              "reschedule_type": "IMMEDIATE"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.MaintenanceService.Reschedule
      ```

      You can get the maintenance job ID with the [list of maintenance jobs](#list-maintenance).

  1. Check the [server response](../api-ref/grpc/Maintenance/reschedule.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Configuring a maintenance window {#set-maintenance-window}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the cluster.
  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select your cluster and open the ![image](../../_assets/console-icons/bars-play.svg) **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
  1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}** in the top-right corner of the page.
  1. Set up the [maintenance](../concepts/maintenance.md) time for your cluster:

      {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To configure a [maintenance window](../concepts/maintenance.md#maintenance-window):
    
  1. See the description of the CLI command for updating cluster settings:
    
      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```
  
  1. Run this command to configure the maintenance window:
    
      ```bash
      {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<sequence_number_of_hour_interval>
      ```
    
      Where:
      
      * `<cluster_name_or_ID>`: Cluster name or ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
      * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings that apply to both running and stopped clusters. The `type` setting defines the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      To learn how to create this file, refer to [{#T}](cluster-create.md).

  1. {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}
      
      For more information about the `yandex_mdb_mysql_cluster` resource, see [this {{ TF }} provider guide]({{ tf-provider-mmy }}).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}


- REST API {#api}
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  
      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
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
      
      * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `updateMask`: Comma-separated string of settings to update.

        In this example, only the `maintenanceWindow` setting is provided.

        {% note warning %}
        
        All settings of the cluster object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

        {% endnote %}

      {% include [maintenance-window-rest](../../_includes/mdb/mmy/maintenance-window-rest.md) %}
  
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
        -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```
    
      Where:

      * `cluster_id`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
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

      {% include [maintenance-window-rest](../../_includes/mdb/mmy/maintenance-window-grpc.md) %}
  
  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
