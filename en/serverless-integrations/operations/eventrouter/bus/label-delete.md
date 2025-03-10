---
title: Deleting a bus label
description: Follow this guide to delete a bus label.
---

# Deleting a bus label

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a [bus](../../../concepts/eventrouter/bus.md) label.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the [bus](../../../concepts/eventrouter/bus.md) row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, select the appropriate label and click ![image](../../../../_assets/console-icons/xmark.svg) next to its name.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To delete a [bus](../../../concepts/eventrouter/bus.md) label, update its current labels by removing the labels you do not need. Run this command:

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

  To delete all bus labels, provide an empty value:

  ```bash
  yc serverless eventrouter bus update <bus_name_or_ID> \
    --labels ""
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To delete a [bus](../../../concepts/eventrouter/bus.md) label:

  1. Open the {{ TF }} configuration file and delete labels you do not need in the `labels` section.

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

  To delete a [bus](../../../concepts/eventrouter/bus.md) label, use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Bus/update.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [Bus/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/update.md) gRPC API call.

{% endlist %}