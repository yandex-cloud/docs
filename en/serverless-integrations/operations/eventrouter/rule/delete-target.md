---
title: How to delete a target
description: Follow this guide to delete a target.
---

# Deleting a target

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a [target](../../../concepts/eventrouter/rule.md#target).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}** tab.
  1. In the [rule](../../../concepts/eventrouter/rule.md) row, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Next to the target to delete, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To delete a [target](../../../concepts/eventrouter/rule.md#target) from a [rule](../../../concepts/eventrouter/rule.md), update the list of its targets by removing those you do not need. To do this, run the following command specifying the rule name or ID and the targets you need to keep:

  {% include [targets-rewrite-warning](../../../../_includes/serverless-integrations/targets-rewrite-warning.md) %}

  {% include [update-three-targets](../../../../_includes/serverless-integrations/update-three-targets.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To delete a [target](../../../concepts/eventrouter/rule.md#target) from a [rule](../../../concepts/eventrouter/rule.md):

  1. Open the {{ TF }} configuration file and delete the sections with descriptions of targets you do not need.

      Example of a rule description in the {{ TF }} configuration file:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<bus_ID>"
        jq_filter = "<jq_expression>"

        ymq {
          queue_arn            = "<queue_ARN>"
          service_account_id   = "<service_account_ID>"
        }

        workflow {
          workflow_id        = "<workflow_ID>"
          service_account_id = "<service_account_ID>"
        }

        yds {
          database           = "<path_to_database>"
          stream_name        = "<stream_name>"
          service_account_id = "<service_account_ID>"
        }

        name        = "<rule_name>"
        description = "<rule_description>"

        labels = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
          <key_n> = "<value_n>"
        }
      }
      ```

      For more information about the `yandex_serverless_eventrouter_rule` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  To delete a [target](../../../concepts/eventrouter/rule.md#target) from a [rule](../../../concepts/eventrouter/rule.md), use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Rule/update.md) REST API method for the [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [Rule/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/update.md) API call.

{% endlist %}