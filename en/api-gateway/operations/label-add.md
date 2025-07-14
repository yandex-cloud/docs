---
title: Adding a label to an API gateway
description: Follow this guide to add an API gateway label.
---

# Adding a label to an API gateway

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing the API gateway.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the API gateway row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Enter the key and the value, and press **Enter**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add an API gateway label, run this command:

  {% include [labels-rewrite-warning](../../_includes/labels-rewrite-warning.md) %}

  {% include [labels-cli](../../_includes/api-gateway/labels-cli.md) %}

  You can specify multiple `<key>=<value>` pairs separated by commas.

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To add an API gateway label:

  1. In the {{ TF }} configuration file, add the `labels` section to list labels in `<key>:"<value>"` format.

      {% include [labels-terraform](../../_includes/api-gateway/labels-terraform.md) %}

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- API {#api}

  To add an API gateway label, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md) gRPC API call.

{% endlist %}
