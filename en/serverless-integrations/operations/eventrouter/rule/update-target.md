---
title: How to update a target
description: Follow this guide to update a target.
---

# Updating a target

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to update a [target](../../../concepts/eventrouter/rule.md#target).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}** tab.
  1. In the [rule](../../../concepts/eventrouter/rule.md) row, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the target parameters.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To update a [target](../../../concepts/eventrouter/rule.md#target) in a [rule](../../../concepts/eventrouter/rule.md), run the following command, specifying the name or the ID of the rule and a list of targets with parameters:

  {% include [targets-rewrite-warning](../../../../_includes/serverless-integrations/targets-rewrite-warning.md) %}

  {% include [update-three-targets](../../../../_includes/serverless-integrations/update-three-targets.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To update a [target](../../../concepts/eventrouter/rule.md#target) in a [rule](../../../concepts/eventrouter/rule.md):

  1. Open the {{ TF }} configuration file and edit the fragments describing the targets of interest.

      Example of a rule description in the {{ TF }} configuration file:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<bus_ID>"
        jq_filter = "<jq_template>"

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
          stream_name        = "<data_stream_name>"
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

      For more information about `yandex_serverless_eventrouter_rule` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates in the [management console]({{ link-console-main }}) or using this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  To update a [target](../../../concepts/eventrouter/rule.md#target) in a [rule](../../../concepts/eventrouter/rule.md), use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Rule/update.md) REST API method for the [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [Rule/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/update.md) API call.

{% endlist %}