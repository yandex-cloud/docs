---
title: How to create a bus
description: Follow this guide to create a bus.
---

# Creating a bus

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bus](../../../concepts/eventrouter/bus.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, select ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-event-router.button_create-bus }}**. In the window that opens:

      1. Enter a name and description for the [bus](../../../concepts/eventrouter/bus.md). The naming requirements are as follows:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      1. Optionally, add labels:

          1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Enter a label in `key: value` format.
          1. Press **Enter**.

      1. (Optional) Enable deletion protection. You cannot delete a bus with this option enabled.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create a [bus](../../../concepts/eventrouter/bus.md):

      ```bash
      yc serverless eventrouter bus create --help
      ```

  1. Create a bus:

      ```bash
      yc serverless eventrouter bus create \
        --name <bus_name> \
        --description "<description>" \
        --labels <label_list> \
        --deletion-protection
      ```

      Where:

      * `--name`: Bus name. The naming requirements are as follows:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description`: Bus description. This is an optional parameter.
      * `--labels`: List of labels. This is an optional parameter.

          You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

      * `--deletion-protection`: Bus deletion protection. You cannot delete a bus with this option enabled. To disable deletion protection, specify `--no-deletion-protection`. This is an optional parameter.

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
      deletion_protection: true
      status: ACTIVE
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To create a [bus](../../../concepts/eventrouter/bus.md):

  1. In the configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_serverless_eventrouter_bus" "example_bus" {
        name                = "<bus_name>"
        description         = "<description>"
        deletion_protection = <true|false>

        labels = {
          <key_1> = "<value_1>"
          <key_2> = "<value_2>"
          ...
          <key_n> = "<value_n>"
        }
      }
      ```

      Where:

      * `name`: Bus name. The naming requirements are as follows:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `description`: Bus description. This is an optional parameter.
      * `deletion-protection`: Bus deletion protection, `true` or `false`. You cannot delete a bus with this option enabled. This is an optional parameter.
      * `labels`: List of labels. Provide labels in `<key> = "<value>"` format. This is an optional parameter.

      For more information about the `yandex_serverless_eventrouter_bus` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_eventrouter_bus).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../../cli/) command:

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  To create a [bus](../../../concepts/eventrouter/bus.md), use the [Create](../../../../serverless-integrations/eventrouter/api-ref/Bus/create.md) REST API method for the [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) resource or the [Bus/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/create.md) gRPC API call.

{% endlist %}