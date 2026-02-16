---
title: Deleting a connector label
description: Follow this tutorial to delete a connector label.
---

# Deleting a connector label

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to add a label to a [connector](../../../concepts/eventrouter/connector.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. In the left-hand panel, click ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Select the [bus](../../../concepts/eventrouter/bus.md) you need.
  1. Navigate to the ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** tab.
  1. In the line with the connector you need, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, select the appropriate label and click ![image](../../../../_assets/console-icons/xmark.svg) next to its name.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  To delete a [connector](../../../concepts/eventrouter/connector.md) label, update its current labels by removing those you do not need. Run this command:

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

  To delete all connector labels, provide an empty value:

  ```bash
  yc serverless eventrouter connector update <connector_name_or_ID> \
    --labels ""
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  To delete a [connector](../../../concepts/eventrouter/connector.md) label:

  1. Open the {{ TF }} configuration file and delete labels you do not need in the `labels` section.

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

  To delete a [connector](../../../concepts/eventrouter/connector.md) label, use the [Update](../../../../serverless-integrations/eventrouter/api-ref/Connector/update.md) REST API method for the [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) resource or the [Connector/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/update.md) gRPC API call.

{% endlist %}