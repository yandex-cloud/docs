---
title: How to schedule a workflow to start on a timer
description: Follow this guide to schedule a workflow to start on a timer.
---

# Scheduling a workflow to start on a timer

You can add a schedule when [creating](../workflow/create-yawl.md) or [updating](../workflow/update.md) a workflow.


## Adding a schedule {#add-schedule}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. [Go](../../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the workflow row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. On the workflow diagram, click the **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_trigger-settings-label }}** section.
  1. Specify the schedule as a [cron expression](../../../concepts/cron.md) and select the time zone.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating a [workflow](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Add a schedule:

      ```bash
      yc serverless workflow update <workflow_name_or_ID> \
        --schedule-cron-expression "<cron_expression>" \
        --schedule-timezone "<time_zone>"
      ```

      Where:
      
      * `--schedule-cron-expression`: Cron expression, e.g., `"0 * * * * *"`. Learn more about the cron expression format [here](../../../concepts/cron.md).
      * `--schedule-timezone`: Time zone, e.g., `Europe/Moscow`.

      Result:

      ```text
      id: dfqai557kgv0********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: ...
      created_at: "2025-09-19T09:11:38.826207Z"
      name: cron-flow
      status: ACTIVE
      log_options:
        folder_id: b1g681qpemb4********
      service_account_id: ajelprpohp7r********
      schedule:
        cron_expression: 0 * * * * *
        timezone: Europe/Moscow
      ```

- API {#api}

  Use the [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md) gRPC API call. In the `schedule` field, provide the schedule and specify the time zone.

{% endlist %}


## Removing a schedule {#remove-schedule}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. [Go](../../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the workflow row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. On the workflow diagram, click the **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_trigger-settings-label }}** section.
  1. Remove the schedule.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. View the description of the CLI command for updating a [workflow](../../../concepts/workflows/workflow.md):

      ```bash
      yc serverless workflow update --help
      ```

  1. {% include [get-workflows-list](../../../../_includes/serverless-integrations/get-workflows-list.md) %}
  1. Remove a schedule:

      ```bash
      yc serverless workflow update <workflow_name_or_ID> \
        --remove-schedule
      ```

      Result:

      ```text
      id: dfqai557kgv0********
      folder_id: b1g681qpemb4********
      specification:
        spec_yaml: ...
      created_at: "2025-09-19T09:11:38.826207Z"
      name: cron-flow
      status: ACTIVE
      log_options:
        folder_id: b1g681qpemb4********
      service_account_id: ajelprpohp7r********
      ```

- API {#api}

  Use the [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md) gRPC API call. In the `schedule` field, specify `null`.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../../concepts/workflows/execution.md)
* [{#T}](get-list.md)
