---
title: Updating an API gateway label
description: Follow this guide to update an API gateway label.
---

# Updating an API gateway label

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update an API gateway label, run this command:

  {% include [labels-rewrite-warning](../../_includes/labels-rewrite-warning.md) %}

  {% include [labels-cli](../../_includes/api-gateway/labels-cli.md) %}

  You can specify multiple `<key>=<value>` pairs separated by commas.

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To update an API gateway label:

  1. Open the {{ TF }} configuration file and edit the `labels` section.

      {% include [labels-terraform](../../_includes/api-gateway/labels-terraform.md) %}

  1. Update resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- API {#api}

  To update an API gateway label, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md) gRPC API call.

{% endlist %}