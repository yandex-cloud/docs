---
title: Writing to the execution log in {{ sw-full-name }}
description: Follow this guide to configure workflow logging.
---

# Writing to the workflow execution log

{% include [logging-note](../../../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [workflow](../../../concepts/workflows/workflow.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the workflow row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Expand **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}** and find **{{ ui-key.yacloud.logging.label_title }}**.

      1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
      1. In the **{{ ui-key.yacloud.logging.label_destination }}** field, select:

         * `{{ ui-key.yacloud.common.folder }}`: To write logs to the default log group of the folder containing the workflow.
         * {% include [log-group](../../../../_includes/functions/log-group.md) %}

      1. (Optional) Select the minimum logging level.

  1. Click **{{ ui-key.yacloud.common.save }}**.

  {% include [min-log-level](../../../../_includes/serverless-integrations/min-log-level.md) %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  ### Logging destination {#destination}

  If a custom [log group](../../../../logging/concepts/log-group.md) is not specified in the workflow parameters or logging is not turned off, the workflow automatically writes all logs to the default log group of the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder) it resides in.

  For logging to another folder's default log group, provide that folder's ID in the `--log-folder-id` parameter when [creating](create-yawl.md) or [updating](update.md) a workflow. The [account](../../../../iam/concepts/users/accounts.md) used to run the command must have the `logging.editor` [role](../../../../logging/security/index.md#logging-editor) or higher for the folder.

  For logging to a custom log group, provide that log group's ID in the `--log-group-id` parameter when creating or updating a workflow. The log group may reside in a different folder. The account used to run the command must have the `logging.editor` role or higher for the folder.

  ### Minimum logging level {#log-level}

  To set the minimum logging level, specify it in the `--min-log-level` parameter when creating or updating the workflow.

  {% include [min-log-level](../../../../_includes/serverless-integrations/min-log-level.md) %}

  ### Disabling logging {#disabled}

  To disable logging, set the `--no-logging` parameter when creating or updating the workflow.

  ### Command example {#example}

  For logging to a custom log group, run this command:

  ```
  yc serverless workflow update <workflow_name_or_ID> \
    --yaml-spec <specification_file> \
    --log-group-id <log_group_ID> \
    --min-log-level <minimum_logging_level>
  ```

  Where:

  * `--yaml-spec`: Path to the [YaWL specification](../../../concepts/workflows/yawl/index.md) file for the workflow, e.g., `./yawl-spec.json`.
  * `--log-group-id`: ID of the log group to write logs to.
  * `--min-log-level`: Minimum logging level. This is an optional parameter.

  Result:

  ```text
  id: dfqjl5hh5p90********
  folder_id: b1g681qpemb4********
  specification:
    spec_yaml: "yawl: ..."
  created_at: "2025-03-11T09:27:51.691990Z"
  name: my-workflow
  description: created via cli
  labels:
    owner: "admin"
    version: "alpha"
  status: ACTIVE
  log_options:
    log_group_id: e23u2vn449av********
    min_level: DEBUG
  service_account_id: aje4tpd9coa********
  network_id: enpm8v48ehcl********
  ```

- API {#api}

  For logging to the workflow execution log, use the [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) REST API method for the [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) resource or the [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md) gRPC API call.

{% endlist %}