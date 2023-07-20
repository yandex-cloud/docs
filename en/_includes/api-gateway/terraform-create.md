To create an API gateway:

1. Describe the parameters of the `yandex_api_gateway` resource in the configuration file:

   * `name`: API gateway name. Name format:

      {% include [name-format](../../_includes/name-format.md) %}

   * `description`: API gateway description.
   * `labels`: [Labels](../../overview/concepts/services#labels) for the API gateway. Set a key-value pair.
   * `spec`: API gateway specification.

   Example configuration file structure:

   ```hcl
   resource "yandex_api_gateway" "test-api-gateway" {
     name        = "<API gateway name>"
     description = "<API gateway description>"
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
                 'text/plain': "Hello, {user}!\n"
     EOT
   }
   ```

   For more information about the resource parameters in Terraform, see the [provider documentation]({{ tf-provider-resources-link }}/api_gateway).

1. Make sure that the configuration files are correct.

   1. In the command line, go to the directory where you created the configuration file.
   1. Run the check using the command:

      ```
      terraform plan
      ```

   If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

1. Deploy the cloud resources.

   1. If the configuration doesn't contain any errors, run the command:

      ```
      terraform apply
      ```

   1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

      ```
      yc serverless api-gateway get <API gateway name>
      ```
