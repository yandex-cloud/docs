---
title: How to get a list of rules
description: Follow this tutorial to view a list of available {{ er-full-name }} rules.
---

# Getting a list of rules

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to view a list of [rules](../../../concepts/eventrouter/rule.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}** tab. The **{{ ui-key.yacloud.serverless-event-router.label_rules }}** page will show a list of rules.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../../cli/) command for viewing a list of [rules](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule list --help
      ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}

- API {#api}

  To view the list of [rules](../../../concepts/eventrouter/rule.md), use the [list](../../../../serverless-integrations/eventrouter/api-ref/Rule/list.md) REST API method for the [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [RuleService/List](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/list.md) gRPC API call.

{% endlist %}