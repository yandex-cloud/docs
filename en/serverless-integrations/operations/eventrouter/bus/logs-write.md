---
title: Writing to the execution log in {{ er-full-name }}
description: Follow this guide to configure bus logging.
---

# Writing to the bus execution log

{% include [logging-note](../../../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [bus](../../../concepts/eventrouter/bus.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the bus row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.logging.label_title }}**:

      1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
      1. In the **{{ ui-key.yacloud.logging.label_destination }}** field, select:

         * `{{ ui-key.yacloud.common.folder }}`: To write logs to the default log group for the folder containing the bus.
         * {% include [log-group](../../../../_includes/functions/log-group.md) %}

      1. Optionally, select the minimum logging level.

  1. Click **{{ ui-key.yacloud.common.save }}**.

  {% include [min-log-level](../../../../_includes/serverless-integrations/bus-min-log-level.md) %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  ## Enabling logging {#enabled}
  
  To write logs when [creating](create.md) or [updating](update.md) a [bus](../../../concepts/eventrouter/bus.md), specify the `--enable-logging` parameter.
  
  ## Logging destination {#destination}
  
  For logging to the [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder)'s default [log group](../../../../logging/concepts/log-group.md), provide that folder's ID in the `folder-id` subparameter under `--log-options`. If the bus resides in another folder, the [account](../../../../iam/concepts/users/accounts.md) used to run the command must have the `logging.editor` [role](../../../../logging/security/index.md#logging-editor) or higher for that folder.
  
  For logging to a custom log group, provide that log group's ID in the `log-group-id` subparameter under `--log-options`. The log group may reside in a different folder. The account used to run the command must have the `logging.editor` role or higher for that folder.

  ## Minimum logging level {#log-level}

  To set the minimum logging level, specify it in the `min-level` parameter when creating or updating a bus.

  {% include [min-log-level](../../../../_includes/serverless-integrations/bus-min-log-level.md) %}

  ## Disabling logging {#disabled}

  To disable logging, specify the `--disable-logging` parameter when updating the bus.

  ## Command example {#example}

  For logging to a custom log group, run this command:

  ```
  {{ yc-serverless }} eventrouter bus update <bus_name_or_ID> \
    --enable-logging \
    --log-options log-group-id=<log_group_ID>,min-level=<minimum_logging_level>
  ```

  Where:

  * `--log-options`: Logging parameters:
    * `log-group-id`: Log group ID.
    * `min-level`: Minimum logging level. This is an optional setting.

  Result:

  ```text
  id: f66302237ren********
  folder_id: b1g0ijbfaqsn********
  cloud_id: b1gia87mbaom********
  created_at: "2025-07-13T16:47:31.559209Z"
  name: my-bus
  status: ACTIVE
  logging_enabled: true
  log_options:
    log_group_id: e23uimb4tabs********
    min_level: DEBUG
  ```

- API {#api}

  For logging to the bus execution log, use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Bus/update.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [Bus/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/update.md) gRPC API call.

{% endlist %}