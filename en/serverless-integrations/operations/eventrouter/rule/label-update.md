---
title: Updating a rule label
description: Follow this guide to update a rule label.
---

# Updating a rule label

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To update a [rule](../../../concepts/eventrouter/rule.md) label, run this command:

  {% include [labels-rewrite-warning](../../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc serverless eventrouter rule update <rule_name_or_ID> \
    --labels <label_list>
  ```

  Where `--labels` is a list of labels. You can specify one label or multiple labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

  Result:

  ```text
  id: f66vfpjrkc35********
  bus_id: f66epjc9llqt********
  folder_id: b1g681qpemb4********
  cloud_id: b1gia87mbaom********
  created_at: "2025-02-26T14:04:47.710918Z"
  name: new-rule
  description: created via cli
  labels:
    owner: admin
    version: beta
  ...
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To update a [rule](../../../concepts/eventrouter/rule.md) label:

  1. Open the {{ TF }} configuration file and edit the `labels` section.

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
        ...
      }
      ```

      For more information about the `yandex_serverless_eventrouter_rule` resource parameters, see [this Terraform article]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  To update a [rule](../../../concepts/eventrouter/rule.md) label, use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Rule/update.md) REST API method for the [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) resource or the [Rule/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/update.md) gRPC API call.

{% endlist %}