---
title: How to disable a rule
description: Follow this guide to disable a rule.
---

# Disabling a rule

When a [rule](../../../concepts/eventrouter/rule.md) is disabled, it stops forwarding events to the specified targets.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to disable a [rule](../../../concepts/eventrouter/rule.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}** tab.
  1. In the rule row, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/toggle-off.svg) **{{ ui-key.yacloud.common.disable }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for disabling a [rule](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule disable --help
      ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}
  1. Disable the rule:

      ```bash
      yc serverless eventrouter rule disable <rule_name_or_ID>
      ```

      Result:

      ```text
      id: f66aa46qtt1l********
      bus_id: f66epjc9llqt********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-26T10:30:59.611601Z"
      name: renamed-rule
      ...
      status: DISABLED
      ```

- API {#api}

  To disable a [rule](../../../concepts/eventrouter/rule.md), use the [Disable](../../../../serverless-integrations/eventrouter/api-ref/Rule/disable.md) REST API method for the [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [Rule/Disable](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/disable.md) gRPC API call.

{% endlist %}