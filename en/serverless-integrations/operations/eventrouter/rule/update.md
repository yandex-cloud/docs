---
title: How to update a rule
description: Follow this tutorial to update a rule.
---

# Editing a rule

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to update a [rule](../../../concepts/eventrouter/rule.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}** tab.
  1. In the row with the required rule, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the rule parameters.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating [rule](../../../concepts/eventrouter/rule.md) parameters:

      ```bash
      yc serverless eventrouter rule update --help
      ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}
  1. In the command, specify the parameters to update, such as the rule name:

      ```bash
      yc serverless eventrouter rule update \
        --name <rule_name> \
        --new-name <new_rule_name>
      ```

      Result:

      ```text
      id: f66aa46qtt1l********
      bus_id: f66epjc9llqt********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-26T10:30:59.611601Z"
      name: renamed-rule
      labels:
        owner: admin
        version: beta
      targets:
        - ymq:
            queue_arn: yrn:yc:ymq:{{ region-id }}:b1g681qpemb4********:dlq-42
            service_account_id: ajelprpohp7r********
          status: ENABLED
      status: ENABLED
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To update a [rule](../../../concepts/eventrouter/rule.md):

  1. Open the {{ TF }} configuration file and edit the part with the `yandex_serverless_eventrouter_rule` resource description.

      Example of a rule description in the {{ TF }} configuration file:

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

      For more information about `yandex_serverless_eventrouter_rule` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates in the [management console]({{ link-console-main }}) or using this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  To update a [rule](../../../concepts/eventrouter/rule.md), use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Rule/update.md) REST API method for the [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [Rule/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/update.md) gRPC API call.

{% endlist %}