---
title: Updating a connector label
description: Follow this guide to update a connector label.
---

# Updating a connector label

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To update a [connector](../../../concepts/eventrouter/connector.md) label, run this command:

  {% include [labels-rewrite-warning](../../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc serverless eventrouter connector update <connector_name_or_ID> \
    --labels <label_list>
  ```

  Where `--labels` is a list of labels. You can specify one label or multiple labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

  Result:

  ```text
  id: f66g4h59ih2g********
  bus_id: f66qn4p7uk6p********
  folder_id: b1g681qpemb4********
  cloud_id: b1gia87mbaom********
  created_at: "2025-02-20T15:30:05.248052Z"
  name: renamed-ydb
  description: consumer-one
  labels:
    owner: admin
    version: beta
  ...
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To update a [connector](../../../concepts/eventrouter/connector.md) label:

  1. Open the {{ TF }} configuration file and edit the `labels` section.

      Example of a connector description in the {{ TF }} configuration file:

      ```hcl
      resource "yandex_serverless_eventrouter_connector" "example_connector" {
        bus_id              = "<bus_ID>"
        name                = "<connector_name>"
        description         = "<connector_description>"
        deletion_protection = <true|false>

        labels = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
          <key_n> = "<value_n>"
        }
        ...
      }
      ```

      For more information about the `yandex_serverless_eventrouter_connector` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  To edit a [connector](../../../concepts/eventrouter/connector.md) label, use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Connector/update.md) REST API method for the [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [Connector/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/update.md) gRPC API call.

{% endlist %}