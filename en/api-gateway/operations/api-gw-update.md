# Updating API gateways

{% list tabs %}

- Management console

   To update an API gateway specification:
   1. In the [management console]({{ link-console-main }}), select the folder where you wish to edit an API gateway.
   1. In the list of services, select **{{ api-gw-name }}**.
   1. In the API gateway's row, click ![image](../../_assets/options.svg) and select **Edit**.
   1. Edit the name, description, or specification of the API gateway.
   1. Click **Save**.

- CLI

   To change the API gateway specification:
   1. Make your changes in the specification file `hello-world.yaml`.
   1. Run the command:

      ```
      yc serverless api-gateway update --id d5dug9gkmu187iojcrtr --spec=hello_world.yaml
      ```

      Where:

      - `id`: ID of the API gateway.
      - `spec`: Updated specification file.

      Result:

      ```
      done (6s)
      id: d5dug9gkmu187iojcrtr
      folder_id: b1g55tflru0ek7omtfu0
      created_at: "2020-06-17T09:20:22.929Z"
      name: hello-world
      description: hello world
      status: ACTIVE
      domain: d5dug9gkmu187iojcpvp.apigw.yandexcloud.net
      log_group_id: ckghq1hm19q7ek5sjnh5
      ```

- API

   You can change the name, description, or specification of an API gateway using the [update](../apigateway/api-ref/ApiGateway/update.md) API method.

- Terraform

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To change the name, description, or specification of the API gateway:

   1. Open the Terraform configuration file and change the `name`, `description`, or `spec` parameters.

      Example configuration file structure:

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

      For more information about the `yandex_api_gateway` resource parameters in Terraform, see the [provider documentation]({{ tf-provider-link }}/api_gateway).

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

      You can verify the change to the API gateway using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc serverless api-gateway get <API gateway name>
      ```

- Yandex Cloud Toolkit

   You can edit the name, the description, or the specification of an API gateway using the [Yandex Cloud Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the family of IDEs on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
