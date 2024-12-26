---
title: Deleting an API gateway label
description: Follow this guide to delete an API gateway label.
---

# Deleting an API gateway label

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go the folder containing the API gateway.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. In the API gateway row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, select the appropriate label and click ![cross](../../_assets/console-icons/xmark.svg) next to its name.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete an API gateway label, update its current labels by removing the labels you do not need. Run this command:

  {% include [labels-rewrite-warning](../../_includes/labels-rewrite-warning.md) %}

  {% include [labels-cli](../../_includes/api-gateway/labels-cli.md) %}

  To delete all API gateway labels, provide an empty value:

  ```bash
  yc serverless api-gateway update <API_gateway_name> --labels ""
  ```

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete an API gateway label:

  1. Open the {{ TF }} configuration file and delete the label you no longer need in the `labels` section.

      {% include [labels-terraform](../../_includes/api-gateway/labels-terraform.md) %}

  1. Update resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- API {#api}

  To delete an API gateway label, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md) gRPC API call.

{% endlist %}
