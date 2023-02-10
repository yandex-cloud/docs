# Deleting API gateways

{% list tabs %}

- Management console

   To delete an API gateway:
   1. In the [management console]({{ link-console-main }}), select the folder where you wish to delete an API gateway.
   1. In the list of services, select **{{ api-gw-name }}**.
   1. In the API gateway's row, click ![image](../../_assets/options.svg) and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   To delete an API gateway, run the command below:

   ```
   yc serverless api-gateway delete --id <API gateway ID>
   ```

   Where `id` is the ID of the API gateway.

   Result:

   ```
   done (18s)
   ```

- API

   You can delete an API gateway using the delete API [method](../apigateway/api-ref/ApiGateway/delete.md).

- Terraform

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete an API gateway created using Terraform:

   1. Open the Terraform configuration file and delete the fragment with the API gateway description.

      Example API gateway description in the Terraform configuration:

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

   1. In the command line, go to the directory with the Terraform configuration file.

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc serverless api-gateway list
      ```

- Yandex Cloud Toolkit

   You can delete an API gateway using the [Yandex Cloud Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the family of IDEs on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
