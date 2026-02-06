---
title: '{{ KF }} cluster maintenance'
description: In this guide, you will learn how to view the {{ KF }} cluster’s scheduled and completed maintenance jobs and schedule new maintenance windows.
---

# {{ KF }} cluster maintenance

You can manage [maintenance](../concepts/maintenance.md) of a {{ mkf-full-name }} cluster.

## Getting a list of maintenance jobs {#list-maintenance}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.

    To view maintenance jobs with a specific status, click **{{ ui-key.yacloud.mdb.maintenance.label_task-status }}** above the maintenance list and select the status you want from the drop-down menu. To find a specific maintenance job, enter its ID or task name in the field above the list of maintenance sessions.

{% endlist %}

## Getting cluster maintenance logs {#maintenance-logs}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
    1. Click the ID of the maintenance job you need.
    1. Click **{{ ui-key.yacloud.mdb.maintenance.label_task-logs }}**.

{% endlist %}

## Postponing scheduled maintenance {#postpone-planned-maintenance}

Maintenance jobs with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status are scheduled for the date and time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column. You can reschedule them for a new date and time, if required.

{% list tabs group=instructions %}

- Management console {#console}

    To reschedule maintenance for a new date and time:

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status.
    1. In the drop-down menu, select ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_change-task-time }}**.
    1. In the window that opens:
        * To postpone the maintenance until the next available window, click **{{ ui-key.yacloud.component.maintenance-alert.value_next-available-window }}** and then **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.
        * To reschedule maintenance for a specific UTC date and time, click **{{ ui-key.yacloud.component.maintenance-alert.value_specific-time }}**, then select a new date and time and click **{{ ui-key.yacloud.component.maintenance-alert.button_reschedule }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To reschedule maintenance for a new date and time:

    1. See the description of the CLI command for rescheduling maintenance :

        ```bash
        {{ yc-mdb-kf }} cluster reschedule-maintenance --help
        ```

    1. Run this command:

        ```bash
        {{ yc-mdb-kf }} cluster reschedule-maintenance <cluster_name_or_ID> \
          --reschedule-type <reschedule_type> \
          --delayed-until <timestamp>
        ```

        Where:

        * `reschedule-type`: Reschedule type:

            * `next-available-window`: Next available window.
            * `specific-time`: Specific date and time.

        * `delayed-until`: Timestamp (do not use with the `next-available-window` reschedule type).

            The timestamp must be in one of the following formats:

            * [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt).
            * HH:MM:SS.
            * Relative time to postpone maintenance for.

            Here are some examples: `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, or `3h30m ago`.

        You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    To reschedule maintenance for a new date and time:

    1. Get an [IAM token for API authentication](../api-ref/authentication.md).
    1. Save the token to an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.rescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>:rescheduleMaintenance' \
          --data '{
            "rescheduleType": <reschedule_type>,
            "delayedUntil": <timestamp>
          }'
        ```

        Where:

        * `rescheduleType`: Reschedule type:

            * `NEXT_AVAILABLE_WINDOW`: Next available window.
            * `SPECIFIC_TIME`: Specific date and time.

        * `delayedUntil`: Timestamp in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, such as `2006-01-02T15:04:05Z`.

            Do not use this option with the `NEXT_AVAILABLE_WINDOW` reschedule type.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    To reschedule maintenance for a new date and time:

    1. Get an [IAM token for API authentication](../api-ref/authentication.md).

    1. Save the token to an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
    1. Call the [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
            "cluster_id": "<cluster_ID>",
            "reschedule_type": <reschedule_type>,
            "delayed_until": <timestamp>
          }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ClusterService.RescheduleMaintenance
        ```

        Where:

        * `reschedule_type`: Reschedule type:

            * `NEXT_AVAILABLE_WINDOW`: Next available window.
            * `SPECIFIC_TIME`: Specific date and time.

        * `delayedUntil`: Timestamp in [RFC-3339](https://www.ietf.org/rfc/rfc3339.txt) format, such as `2006-01-02T15:04:05Z`.

            Do not use this option with the `NEXT_AVAILABLE_WINDOW` reschedule type.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.kafka.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Starting scheduled maintenance immediately {#exec-planned-maintenance}

You can start maintenance with the **{{ ui-key.yacloud.mdb.maintenance.label_task-status-planned }}** status immediately, prior to the time specified in the **{{ ui-key.yacloud.mdb.maintenance.label_task-start-time }}** column.

{% list tabs group=instructions %}

- Management console {#console}

    To start scheduled maintenance immediately, do the following:

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the maintenance job.
    1. In the drop-down menu, select ![image](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.mdb.maintenance.action_exec-task-now }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To start scheduled maintenance immediately, do the following:

    1. See the description of the CLI command for rescheduling maintenance :

        ```bash
        {{ yc-mdb-kf }} cluster reschedule-maintenance --help
        ```

    1. Run this command using the `immediate` reschedule type:

        ```bash
        {{ yc-mdb-kf }} cluster reschedule-maintenance <cluster_name_or_ID> \
          --reschedule-type immediate
        ```

        You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    To start scheduled maintenance immediately, do the following:

    1. Get an [IAM token for API authentication](../api-ref/authentication.md).
    1. Save the token to an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.rescheduleMaintenance](../api-ref/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>:rescheduleMaintenance' \
          --data '{
            "rescheduleType": "IMMEDIATE"
          }'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/rescheduleMaintenance.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    To start scheduled maintenance immediately, do the following:

    1. Get an [IAM token for API authentication](../api-ref/authentication.md).
    1. Save the token to an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.RescheduleMaintenance](../api-ref/grpc/Cluster/rescheduleMaintenance.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
            "cluster_id": "<cluster_ID>",
            "reschedule_type": "IMMEDIATE"
          }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ClusterService.RescheduleMaintenance
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/rescheduleMaintenance.md#yandex.cloud.mdb.kafka.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Configuring a maintenance window {#set-maintenance-window}

By default, maintenance can run at any time. To set a specific maintenance window, specify the day of the week and time interval. For example, you can schedule it for periods of lowest cluster load.

{% note warning %}

A scheduled maintenance job will be canceled automatically if it falls outside the specified interval.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_kafka }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.maintenance.title_maintenance }}** tab.
    1. Click ![image](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.mdb.maintenance.action_maintenance-window-setup }}**.
    1. In the window that opens:
        * To allow maintenance at any time, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}**, which is the default option.
        * To set a specific window, select **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** and specify the day of the week and UTC time interval.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for updating the maintenance window:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Run this command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
          --maintenance-window type=<maintenance_type>,`
                              `day=<day_of_week>,`
                              `hour=<hour>
        ```

        Where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

        You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

        For a complete list of {{ mkf-name }} cluster configuration fields you can update, see [this {{ TF }} provider guide]({{ tf-provider-mkf }}).

    1. {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- REST API {#api}

    1. Get an [IAM token for API authentication](../api-ref/authentication.md).
    1. Save the token to an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
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

        * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. The possible values are:

            * `anytime`: Maintenance can run at any time.
            * `weeklyMaintenanceWindow`: Maintenance runs once a week on the specified day and at the specified time:

                * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. Get an [IAM token for API authentication](../api-ref/authentication.md).
    1. Save the token to an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
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
          yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`). 

            Here, we provide only one setting.

        * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. The possible values are:

            * `anytime`: Maintenance can run at any time.
            * `weekly_maintenance_window`: Maintenance runs once a week on the specified day and at the specified time:

                * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.kafka.v1.Cluster) to make sure your request was successful.

{% endlist %}
