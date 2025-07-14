---
title: How to set up a canary release for an API gateway
description: Follow this guide to set up a canary release for an API gateway.
---

# Setting up a canary release

You can only set up a canary release for [OpenAPI specifications](https://en.wikipedia.org/wiki/OpenAPI_Specification) with variables (see [Specification parameterization](../concepts/extensions/parametrization.md)).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [API gateway](../concepts/index.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the API gateway row, click ![image](../../_assets/options.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.label_section-variables }}**, enable [canary release](../concepts/extensions/canary.md).
  1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-share }}** field, specify the percentage of requests for the canary release to process.
  1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-variables }}** field, list the variables and their values to use in the canary release.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set up a [canary release](../concepts/extensions/canary.md):
  1. Edit the OpenAPI specification file or create a new one, if required.
  1. View the description of the CLI command for updating an [API gateway](../concepts/index.md):

     ```bash
     {{ yc-serverless }} api-gateway update --help
     ```

  1. Specify the API gateway ID or name and the canary release parameters in the command below:

     ```bash
     {{ yc-serverless }} api-gateway update \
       --id <API_gateway_ID> \
       --canary-weight <percentage_of_requests> \
       --canary-variables=<list_of_variables>
     ```

     Where:
     * `--canary-weight`: Percentage of requests for the canary release to process.
     * `--canary-variables`: Variables for the canary release, listed as `key=value`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To set up a [canary release](../concepts/extensions/canary.md):
  1. Open the {{ TF }} configuration file and add the `canary` section to it:

     ```hcl
     resource "yandex_api_gateway" "<API_gateway_name>" {
     ...
     canary {
       weight    = <percentage_of_requests>
       variables = {
         <list_of_variables>
       }
     }
     ```

     Where:
     * `weight`: Percentage of requests for the canary release to process.
     * `variables`: Variables for the canary release, listed as `key=value`.

     For more information about `yandex_api_gateway` properties in {{ TF }}, see [this {{ TF }} article]({{ tf-provider-resources-link }}/api_gateway).
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     The terminal will display a list of resources with their properties. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm the changes.

  You can check the [API gateway](../concepts/index.md) update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

  ```bash
  yc serverless api-gateway get <API_gateway_name>
  ```

- API {#api}

  To set up a [canary release](../concepts/extensions/canary.md), use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md) gRPC API call.

{% endlist %}

## See also

* [What is a canary release?](../concepts/extensions/canary.md)
* [Canary release of a {{ sf-name }} function](../tutorials/canary-release.md)