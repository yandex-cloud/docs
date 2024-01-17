---
title: "Updating API gateways"
description: "Follow this guide to update an API gateway."
---

# Updating API gateways

After you create an API gateway, you can change any of its parameters and the OpenAPI specification.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to edit an API gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. In the API gateway row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.serverless-functions.gateways.list.button_action-edit }}**.
   1. Edit the API gateway parameters or OpenAPI specification if needed.
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update an API gateway:

   1. If necessary, edit the OpenAPI specification file or create a new one.
   1. View a description of the CLI command for updating an API gateway:

      ```bash
      {{ yc-serverless }} api-gateway update --help
      ```

   1. In the update command, specify the API gateway ID or name and the parameters to update (not all the supported parameters are listed below):

      ```bash
      {{ yc-serverless }} api-gateway update \
        --id <gateway_ID> \
        --new-name <new_gateway_name>
        --spec=<path_to_new_specification_file> \
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To change the name, description, or specification of the API gateway:

   1. Open the {{ TF }} configuration file and change the `name`, `description`, or `spec` parameters.

      Here is an example of the configuration file structure:

      ```hcl
      ...
      resource "yandex_api_gateway" "test-api-gateway" {
        name        = "some_name"
        description = "any description"
        labels      = {
          label       = "label"
          empty-label = ""
        }
        spec = <<-EOT
          openapi: "3.0.0"
          info:
            version: 1.0.0
            title: Test API
          paths:
            /hello:
              get:
                summary: Say hello
                operationId: hello
                parameters:
                  - name: user
                    in: query
                    description: User name to appear in greetings
                    required: false
                    schema:
                      type: string
                      default: 'world'
                responses:
                  '200':
                    description: Greeting
                    content:
                      'text/plain':
                        schema:
                          type: "string"
                x-yc-apigateway-integration:
                  type: dummy
                  http_code: 200
                  http_headers:
                    'Content-Type': "text/plain"
                  content:
                    'text/plain': "Hello again, {user}!\n"
        EOT
      }
      ...
      ```

      For more information about the `yandex_api_gateway` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/api_gateway).

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the API gateway update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc serverless api-gateway get <API_gateway_name>
      ```


- {{ yandex-cloud }} Toolkit

   You can edit the name, description, or specification of an API gateway using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


- API

   To change the API gateway name, description, or specification, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/apigateway_service.md#Update) gRPC API call.

{% endlist %}
