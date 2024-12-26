---
title: Setting up variables for API gateway specifications
description: Follow this guide to set up variables for API gateway specifications.
---

# Setting up variables

{{ api-gw-name }} supports [variables in an OpenAPI specification](../concepts/extensions/parametrization.md).

{% cut "Sample specification file with a variable" %}

```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0

x-yc-apigateway:
  variables:
    environment:
      default: "prod"
      enum:
        - "prod"
        - "testing"
        - "dev"
      description: "API Gateway installation."

paths:
  /env/info:
    get:
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': It is ${var.environment} environment!
        http_code: 200
        http_headers:
          Content-Type: text/plain
```

{% endcut %}

By default, variables take the values specified in the `default` field of the [OpenAPI specification](https://en.wikipedia.org/wiki/OpenAPI_Specification). You can override them by providing other values when setting up your [API gateway](../concepts/index.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update an API gateway.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the API gateway row, click ![image](../../_assets/options.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.label_section-variables }}**, list all the variables declared in the specification and their values.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set up your variables:
  1. If necessary, edit the OpenAPI specification file or create a new one.
  1. View a description of the CLI command for updating an API gateway:

     ```bash
     {{ yc-serverless }} api-gateway update --help
     ```

  1. Specify the API gateway ID or name in the command and list all the variables declared in the specification as `key=value`:

     ```bash
     {{ yc-serverless }} api-gateway update \
       --id <API_gateway_ID> \
       --variables <list_of_variables>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To provide the values of the variables declared in the API gateway specification:
  1. Open the {{ TF }} configuration file and add the `variables` section to it:

     ```hcl
     resource "yandex_api_gateway" "<API_gateway_name>" {
       ...
       variables = {
         <list_of_variables>
       }
       ...
     }
     ```

     List the variables in `key = value` format, such as:

     ```hcl
     resource "yandex_api_gateway" "<API_gateway_name>" {
       ...
       variables = {
         environment = "testing"
       }
       ...
     }
     ```

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

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the API gateway update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc serverless api-gateway get <API_gateway_name>
     ```

- API {#api}

  To set up variables for an API gateway specification, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md) gRPC API call.

{% endlist %}

## See also

* [How specification parameterization works](../concepts/extensions/parametrization.md).
* [How to update an API gateway specification](../operations/api-gw-update.md).