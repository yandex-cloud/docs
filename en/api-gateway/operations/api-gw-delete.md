---
title: "Deleting API gateways"
description: "Follow this guide to delete an API gateway."
---

# Deleting API gateways

{% list tabs %}

- Management console

   To delete an API gateway:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete an API gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. In the API gateway row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.serverless-functions.gateways.list.button_action-delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.serverless-functions.gateways.list.popup-confirm_button_delete }}**.

- CLI

   To delete an API gateway, run the command below:

   ```
   yc serverless api-gateway delete --id <API gateway ID>
   ```

   Where `--id` is the ID of the API gateway.

   Result:

   ```
   done (18s)
   ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete an API gateway created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the API gateway description.

      Example API gateway description in the {{ TF }} configuration:

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

   1. In the command line, go to the directory with the {{ TF }} configuration file.

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

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc serverless api-gateway list
      ```


- {{ yandex-cloud }} Toolkit

   You can delete an API gateway using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


- API

   To delete an API gateway, use the [delete](../apigateway/api-ref/ApiGateway/delete.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Delete](../apigateway/api-ref/grpc/apigateway_service.md#Delete) gRPC API call.

{% endlist %}
