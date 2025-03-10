---
title: Updating a bus label
description: Follow this guide to update a bus label.
---

# Updating a bus label

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To update a [bus](../../../concepts/eventrouter/bus.md) label, run this command:

  {% include [labels-rewrite-warning](../../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc serverless eventrouter bus update <bus_name_or_ID> \
    --labels <label_list>
  ```

  Where `--labels` is a list of labels. You can specify one label or multiple labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

  Result:

  ```text
  id: f66aevm4ithv********
  folder_id: b1g681qpemb4********
  cloud_id: b1gia87mbaom********
  created_at: "2025-02-13T12:36:59.497985Z"
  name: my-bus-43
  description: this is my bus
  labels:
    owner: admin
    version: beta
  deletion_protection: true
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To update a [bus](../../../concepts/eventrouter/bus.md) label:

  1. Open the {{ TF }} configuration file and edit the `labels` section.

      Example of a bus description in the {{ TF }} configuration file:

      ```hcl
      resource "yandex_serverless_eventrouter_bus" "example_bus" {
        name                = "my-bus"
        description         = "this is my bus"
        deletion_protection = true

        labels = {
          key1 = "value1"
          key2 = "value2"
        }
      }
      ```

      For more information about the `yandex_serverless_eventrouter_bus` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_eventrouter_bus).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  To update a [bus](../../../concepts/eventrouter/bus.md) label, use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Bus/update.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [Bus/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/update.md) gRPC API call.

{% endlist %}