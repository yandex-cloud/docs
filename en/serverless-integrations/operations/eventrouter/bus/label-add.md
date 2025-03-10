---
title: Adding a label to a bus
description: Follow this guide to add a label to a bus.
---

# Adding a label to a bus

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to add a label to a [bus](../../../concepts/eventrouter/bus.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Click ![image](../../../../_assets/console-icons/ellipsis.svg) in the [bus](../../../concepts/eventrouter/bus.md) row and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Enter the key and the value, and press **Enter**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To add a label to a [bus](../../../concepts/eventrouter/bus.md), run this command:

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

  To add a label to a [bus](../../../concepts/eventrouter/bus.md), follow these steps:

  1. Open the {{ TF }} configuration file. Under `labels`, enlist the labels in `key = "value"` format.

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

      For more information about the `yandex_serverless_eventrouter_bus` resource parameters, see [this Terraform article]({{ tf-provider-resources-link }}/serverless_eventrouter_bus).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  To add a label to a [bus](../../../concepts/eventrouter/bus.md), use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Bus/update.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [Bus/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/update.md) gRPC API call.

{% endlist %}