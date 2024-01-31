---
title: "How to set up a canary release for an API gateway"
description: "Follow this guide to set up a canary release for an API gateway."
---

# Setting up a canary release

You can only set up a canary release for OpenAPI specifications with variables (see [Specification parameterization](../concepts/extensions/parametrization.md)).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing the API gateway.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. In the API gateway row, click ![image](../../_assets/options.svg) and select **{{ ui-key.yacloud.serverless-functions.gateways.list.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.label_section-variables }}**, enable [canary release](../concepts/extensions/canary.md).
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-share }}** field, specify the percentage of requests to be processed by the canary release.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-variables }}** field, list the variables and their values to be used in the canary release.
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set up a canary release:

   1. If necessary, edit the OpenAPI specification file or create a new one.
   1. View a description of the CLI command for updating an API gateway:

      ```bash
      {{ yc-serverless }} api-gateway update --help
      ```

   1. Specify the API gateway ID or name and the canary release parameters in the command below:

      ```bash
      {{ yc-serverless }} api-gateway update \
         --id <gateway_ID> \
         --canary-weight <percentage_of_requests> \
         --canary-variables=<list_of_variables>
      ```

      Where:

      * `--canary-weight`: Percentage of requests to be handled by the canary release.
      * `--canary-variables`: Variables for the canary release listed as `key=value`.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To set up a canary release:

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

      * `weight`: Percentage of requests to be processed by the canary release.
      * `variables`: Variables for the canary release listed as `key=value`.

      For more information about the `yandex_api_gateway` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/api_gateway).

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check that the API gateway has been updated using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc serverless api-gateway get <API_gateway_name>
      ```

- API {#api}

   To set up a canary release, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/apigateway_service.md#Update) gRPC API call.

{% endlist %}

## See also

* [What is a canary release?](../concepts/extensions/canary.md)
* [Canary release of a {{ sf-name }} function](../tutorials/canary-release.md).
