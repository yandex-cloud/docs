---
title: How to delete a rule
description: Follow this tutorial to delete a rule.
---

# Deleting a rule

{% note info %}

You cannot delete a rule if deletion protection is enabled. Before deleting the rule, [disable](update.md) the protection.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to delete a [rule](../../../concepts/eventrouter/rule.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}** tab.
  1. In the row with the required rule, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for deleting the [rule](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule delete --help
      ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}
  1. Delete the rule:

      ```bash
      yc serverless eventrouter rule delete <rule_name_or_ID>
      ```

      Result:

      ```text
      done (1s)
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To delete a [rule](../../../concepts/eventrouter/rule.md):

  1. Open the {{ TF }} configuration file and delete the fragment with the `yandex_serverless_eventrouter_rule` resource description:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id      = "<rule_ID>"
        name        = "<rule_name>"
        description = "<rule_description>"

        labels = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
          <key_n> = "<value_n>"
        }

        jq_filter = "<jq_template>"
      
        ...
      }
      ```

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates in the [management console]({{ link-console-main }}) or using this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  To delete a [rule](../../../concepts/eventrouter/rule.md), use the [Delete](../../../../serverless-integrations/eventrouter/api-ref/Rule/delete.md) REST API method for the [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [Rule/Delete](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/delete.md) gRPC API call.

{% endlist %}