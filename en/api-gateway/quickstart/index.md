---
title: "Getting started with Yandex API Gateway (API gateways)"
description: "In this tutorial, you will create and test different types of extensions. First, you configure the API gateway to receive a static response, and then add the integration to call the function."
---

# Getting started with {{ api-gw-name }}

Using these instructions, you'll create and test different types of extensions: first, you'll set up an API gateway for getting [static responses](../concepts/extensions/dummy.md) and then add integration for [invoking functions](../concepts/extensions/cloud-functions.md).

## Before you begin {#before-you-begin}

To get started in {{ yandex-cloud }}:
1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
   {% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
   {% endif %}
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Create an API gateway {#create-api-gw}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create an API gateway.
   1. In the list of services, select **{{ api-gw-name }}**.
   1. Click Create **API gateway**.
   1. In the **Name** field, enter `numbers`.
   1. (optional) In the **Description** field, enter a description.
   1. In the **Specification** section, add a specification:

      ```
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
      ```
   1. Click **Create**.

- Terraform

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-create](../../_includes/api-gateway/terraform-create.md) %}

{% endlist %}

## Access the API gateway {#api-gw-test}

1. In the [management console]({{ link-console-main }}), select the folder containing the API gateway.
1. In the list of services, select **{{ api-gw-name }}** and click the name of the created API gateway.
1. Copy the **Domain** field value and create a link in the format: `https://<domain>/hello?user=API`. The resulting link should look like this:

   ```
   https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello?user=API
   ```

1. Access the API gateway using [curl](https://curl.haxx.se) with one of the commands:

   ```bash
   curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello?user=API
   curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello
   ```

   Result:

   ```
   Hello, API!
   Hello, world!
   ```

## Add an integration with the function {#functions}

### Create a function {#function}

Create a function to get a list of numbers. Read more about functions in the [{{ sf-name }}](../../functions/) documentation.

{% list tabs %}

- Management console

   To create a function:
   1. Create a function:
      1. In the [management console]({{ link-console-main }}), select the folder to create your function in.
      1. Click **Create resource**.
      1. Select **Function**.
      1. In the **Name** field, specify `list`.
      1. Click **Create**.
      1. [Make](../../functions/operations/function-public.md#public) your function public.
   1. Create the function version:
      1. In the window that opens, select the function you created.
      1. Under **Latest version**, click **Create in editor**.
      1. In the window that opens, in the **Runtime environment** field, select `nodejs12`.
      1. In the **Method** field, select the code editor.
      1. Click **Create file** in the editor below.
         1. In the window that opens, enter the `index.js` file name.
         1. Click **Create**.
      1. Paste the following code in the `index.js` file:

         ```
         module.exports.handler = async (event) => {
             return {
                 "statusCode": 200,
                 "headers": {"content-type": "application/json"},
                 "body": "[0, 1, 2]"
             };
         };
         ```
      1. In the **Entry point** field, enter `index.handler`.
      1. Click **Create version**.

- Terraform

   To create a function:

   1. Prepare a ZIP archive with the function code:
      1. Save the following code to a file named index.js:

         ```js
         module.exports.handler = async (event) => {
             return {
                 "statusCode": 200,
                 "headers": {"content-type": "application/json"},
                 "body": "[0, 1, 2]"
             };
         };
         ```

      1. Add `index.js` to the `hello-js.zip` archive.

   1. Describe the `yandex_function` resource parameters in the configuration file:

      ```hcl
      resource "yandex_function" "test-function" {
        name               = "test-function"
        description        = "Test function"
        user_hash          = "first-function"
        runtime            = "nodejs12"
        entrypoint         = "index.handler"
        memory             = "128"
        execution_timeout  = "10"
        service_account_id = "<Service account ID>"
        tags               = ["my_tag"]
        content {
          zip_filename = "<path to ZIP archive>"
        }
      }
      ```

      Where:

      * `name`: Function name.
      * `description`: Text description of the function.
      * `user_hash`: An arbitrary string that identifies the function version. When the function changes, update this string, too. The function will update when this string is updated.
      * `runtime`: The function [runtime environment](../../functions/concepts/runtime/index.md).
      * `entrypoint`: Function name in the source code that will serve as an entry point to the applications.
      * `memory`: The amount of memory allocated for function execution, in MB.
      * `execution_timeout`: Function execution timeout.
      * `service_account_id`: ID of the service account that should be used to invoke the function.
      * `tags`: Function tags.
      * `content`: Function source code.
      * `content.0.zip_filename`: Path to the ZIP archive containing the function source code.

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-link }}/function).

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
         yc serverless function list
         ```

{% endlist %}

### Extend the API gateway specification {#update}

Add function information to the API gateway specification.

{% list tabs %}

- Management console

   To update an API gateway specification:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to update an API gateway.
   1. In the window that opens, select the API gateway and click ![image](../../_assets/options.svg).
   1. In the menu that opens, click **Edit**.
   1. Under **Specification**, add an extended version of the specification

      The `/numbers` method, which uses the `cloud_functions` type `x-yc-apigateway-integration` extension, invokes a function by ID.

      To ensure that the API gateway works properly, in the `function_id` parameter, specify the ID of the function to invoke.
      To let the API gateway access a private function, in the `service_account_id` parameter, specify a service account that has the rights to invoke the function.

      ```
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
        /numbers:
          get:
            summary: List some numbers
            operationId: listNumbers
            responses:
              '200':
                description: Another example
                content:
                  'application/json':
                     schema:
                       type: "array"
                       items:
                         type: "integer"
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <function ID >
              service_account_id: <service account ID>
      ```

- Terraform

   To add function information to the API gateway specification:

   1. Open the Terraform configuration file and add the `/numbers` method that uses the `cloud_functions` type `x-yc-apigateway-integration` extension to invoke a function by ID. Under `spec`, change the API gateway specification by specifying the following parameters:

      * `function_id`: Function ID.
      * `service_account_id`: ID of the service account with rights to invoke a function.

      Extended API gateway specification:

      ```hcl
      ...

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
            /numbers:
              get:
                summary: List some numbers
                operationId: listNumbers
                responses:
                  '200':
                    description: Another example
                    content:
                      'application/json':
                        schema:
                          type: "array"
                          items:
                            type: "integer"
                x-yc-apigateway-integration:
                  type: cloud_functions
                  function_id: <function ID>
                  service_account_id: <service account ID>
        EOT
      }
      ```

      For more information about the resource parameters in Terraform, see the [provider documentation]({{ tf-provider-link }}/api_gateway).

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

{% endlist %}

### Access the function via the {#api-gw} API gateway

{% note info %}

For the API gateway to be able to invoke a function, [make](../../functions/operations/function-public.md#public) it public or [specify](../concepts/extensions/cloud-functions.md) in the specification the service account that has rights to invoke a function.

{% endnote %}

Access the API gateway:

```bash
curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/numbers
```

Result:

```
[0, 1, 2]
```

#### See also {#see-also}

* [Concepts when using the service](../concepts/index.md).
* [Step-by-step instructions for managing API gateways](../operations/index.md).
