---
title: Updating an API gateway
description: Follow this guide to update an API gateway.
---

# Updating an API gateway

After you create an [API gateway](../concepts/index.md), you can change any of its parameters and the [OpenAPI specification](https://en.wikipedia.org/wiki/OpenAPI_Specification).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update an API gateway.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the API gateway row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the API gateway parameters or OpenAPI specification, if needed.

      {% include [add-extentions-constructor](../../_includes/api-gateway/add-extentions-constructor.md) %}

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update an API gateway:
  1. Edit the OpenAPI specification file or create a new one, if required.
  1. View the description of the CLI command for updating an API gateway:

     ```bash
     {{ yc-serverless }} api-gateway update --help
     ```

  1. In the update command, specify the API gateway ID or name and the parameters to update (not all the supported parameters are listed below):

     ```bash
     {{ yc-serverless }} api-gateway update \
       --id <API_gateway_ID> \
       --new-name <new_API_gateway_name> \
       --execution-timeout <request_execution_timeout> \
       --spec=<path_to_new_specification_file>
     ```

     Where:
     * `--id`: ID of the API gateway you need to update.
     * `--name`: New name for the API gateway. This is an optional parameter. Follow these naming requirements:

         {% include [name-format](../../_includes/name-format.md) %}
     * `--execution-timeout`: Request execution timeout. The value is specified in seconds and must not exceed the specified [limit](../concepts/limits.md#api-gw-limits). This is an optional parameter. The default value is `300` seconds.
     * `--spec`: Path to the file with the updated API gateway specification.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To change the name, description, or specification of the API gateway:
  1. Open the {{ TF }} configuration file and edit the `name`, `description`, `execution_timeout`, or `spec` properties, respectively.

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
       execution_timeout = "<request_execution_timeout>"
       spec              = <<-EOT
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
                   description: User name to appear in greetings.
                   required: false
                   schema:
                     type: string
                     default: 'world'
               responses:
                 '200':
                   description: Greeting.
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

     For more information about `yandex_api_gateway` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/api_gateway).
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

     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.
  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm the changes.

     You can check the API gateway update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc serverless api-gateway get <API_gateway_name>
     ```

- API {#api}

  To change the API gateway name, description, or specification, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md) gRPC API call.


{% endlist %}