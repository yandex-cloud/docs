To create an API gateway:

1. Describe `yandex_api_gateway` properties in the configuration file:

   * `name`: API gateway name. Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

   * `description`: API gateway description.
   * `labels`: [Labels](../../resource-manager/concepts/labels.md) for the API gateway. Specify a key-value pair.
   * `execution_timeout`: Request execution timeout. The value is specified in seconds and must not exceed the set [limit](../../api-gateway/concepts/limits.md#api-gw-limits). This is an optional parameter. The default value is `300` seconds.
   * `spec`: API gateway specification.

   Here is an example of the configuration file structure:

   ```hcl
   resource "yandex_api_gateway" "test-api-gateway" {
     name        = "<API_gateway_name>"
     description = "<API_gateway_description>"
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
                 'text/plain': "Hello, {user}!\n"
     EOT
   }
   ```

   For more information about resource properties in {{ TF }}, see the [relevant {{ TF }} documentation]({{ tf-provider-resources-link }}/api_gateway).

1. Make sure the configuration files are correct.

   1. In the command line, go to the directory where you created the configuration file.
   1. Run a check using this command:

      ```
      terraform plan
      ```

   If the configuration is correct, the terminal will display a list of new resources with their properties. If the configuration contains any errors, {{ TF }} will point them out.

1. Deploy the cloud resources.

   1. If the configuration does not contain any errors, run this command:

      ```
      terraform apply
      ```

   1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or these [CLI](../../cli/quickstart.md) commands:

      ```
      yc serverless api-gateway get <API_gateway_name>
      ```