---
title: Getting started with {{ api-gw-full-name }} (API gateways)
description: Follow this guide to create and test different types of extensions. First, you will set up an API gateway for getting static responses and then add integration for invoking functions.
---

# Getting started with {{ api-gw-name }}

Follow this guide to create and test different types of extensions. First, you will set up an [API gateway](../concepts/index.md) to get a [static response](../concepts/extensions/dummy.md) and then add an integration for [invoking a function](../concepts/extensions/cloud-functions.md). You will need [curl](https://curl.haxx.se) to access the API gateway.

## Getting started {#before-you-begin}

To get started in {{ yandex-cloud }}:

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` [status](../../billing/concepts/billing-account-statuses.md). If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md).

## Create an API gateway {#create-api-gw}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** field, enter `numbers`.
   1. (Optional) In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_description }}** field, enter a description.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** section, add the specification:

      ```yaml
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

   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-create](../../_includes/api-gateway/terraform-create.md) %}

{% endlist %}

## Access the API gateway {#api-gw-test}

1. In the [management console]({{ link-console-main }}), select the folder containing the API gateway.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}** and click the name of the created API gateway.
1. Save the value of the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field.
1. Install [curl](https://curl.haxx.se).
1. Access the API gateway using curl with one of the commands:

   * ```bash
     curl <service_domain>/hello?user=API
     ```

   * ```bash
     curl <service_domain>/hello
     ```

   Where `<service_domain>` is the value of the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field you saved earlier.

   For example:

   ```bash
   curl https://d5dm1lba80md********.apigw.yandexcloud.net/hello?user=API
   ```

   Result:

   * ```text
     Hello, API!
     ```

   * ```text
     Hello, world!
     ```

## Add an integration with the function {#functions}

### Create a function {#function}

Create a [function](../../functions/concepts/function.md) to get a list of numbers. Read more about functions in the [{{ sf-full-name }}](../../functions/) documentation.

{% list tabs group=instructions %}

- Management console {#console}

   To create a function:

   1. Create a function:
      1. In the [management console]({{ link-console-main }}), select the folder to create your function in.
      1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.value_serverless-functions }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, specify `list`.
      1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Create a function version:
      1. Select the `nodejs18` runtime environment.
      1. Enable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}** in the editor below.
         1. In the window that opens, enter the `index.js` file name.
         1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Paste the following code in the `index.js` file:

         ```js
         module.exports.handler = async (event) => {
           return {
             "statusCode": 200,
             "headers": {"content-type": "application/json"},
             "body": "[0, 1, 2]"
           };
         };
         ```

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `index.handler`.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
   1. [Make](../../functions/operations/function/function-public.md) your function public.

- {{ TF }} {#tf}

   To create a function:

   1. Prepare a ZIP archive with the function code:

      1. Save the following code to a file named `index.js`:

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
        runtime            = "nodejs18"
        entrypoint         = "index.handler"
        memory             = "128"
        execution_timeout  = "10"
        service_account_id = "<service_account_ID>"
        tags               = ["my_tag"]
        content {
          zip_filename = "<path_to_ZIP_archive>"
        }
      }
      ```

      Where:

      * `name`: Function name.
      * `description`: Text description of the function.
      * `user_hash`: Any string to identify the function version. When the function changes, update this string, too. The function will update when this string is updated.
      * `runtime`: Function [runtime environment](../../functions/concepts/runtime/index.md).
      * `entrypoint`: Function name in the source code that will serve as an entry point to the applications.
      * `memory`: Amount of memory allocated for the function, in MB.
      * `execution_timeout`: Function execution timeout.
      * `service_account_id`: ID of the [service account](../../iam/concepts/users/service-accounts.md) to invoke the function under.
      * `tags`: Function tags.
      * `content`: Function source code.
      * `content.0.zip_filename`: Path to the ZIP archive containing the function source code.

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or these [CLI](../../cli/) commands:

         ```bash
         yc serverless function list
         ```

{% endlist %}

### Extend the API gateway specification {#update}

Add function information to the API gateway specification.

{% list tabs group=instructions %}

- Management console {#console}

   To update an API gateway specification:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to update an API gateway.
   1. In the window that opens, select the API gateway and click ![image](../../_assets/console-icons/ellipsis.svg).
   1. In the menu that opens, click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}**, add an extended version of the specification.

      The `/numbers` method, which uses the `cloud_functions` type `x-yc-apigateway-integration` extension, invokes a function by ID.

      To ensure that the API gateway works properly, in the `function_id` parameter, specify the ID of the function to invoke. To enable the API gateway to access a private function, in the `service_account_id` parameter, specify a [service account](../../iam/concepts/users/service-accounts.md) that has permissions to invoke the function.

      ```yaml
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
              function_id: <function_ID >
              service_account_id: <service_account_ID>
      ```

- {{ TF }} {#tf}

   To add function information to the API gateway specification:

   1. Open the {{ TF }} configuration file and add the `/numbers` method, which uses the `cloud_functions` type `x-yc-apigateway-integration` extension to invoke a function by ID. Under `spec`, change the API gateway specification by specifying the following parameters:

      * `function_id`: Function ID.
      * `service_account_id`: ID of the service account with permissions to invoke the function.

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
                    description: User name to appear in greetings.
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
                    description: Another example.
                    content:
                      'application/json':
                        schema:
                          type: "array"
                          items:
                            type: "integer"
                x-yc-apigateway-integration:
                  type: cloud_functions
                  function_id: <function_ID>
                  service_account_id: <service_account_ID>
        EOT
      }
      ```

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/api_gateway).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configurations using the [management console]({{ link-console-main }}) or these CLI commands:

         ```bash
         yc serverless api-gateway get <API_gateway_name>
         ```

{% endlist %}

### Access the function via the {#api-gw} API gateway

{% note info %}

To allow the API gateway to access the function, [make](../../functions/operations/function/function-public.md) it public or [specify](../concepts/extensions/cloud-functions.md) in the specification a [service account](../../iam/concepts/users/service-accounts.md) that has permissions to invoke the function.

{% endnote %}

Access the API gateway:

```bash
curl <service_domain>/numbers
```

Where `<service_domain>` is the value of the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field you saved [earlier](#api-gw-test).

For example:

```bash
curl https://d5dm1lba80md********.apigw.yandexcloud.net/numbers
```

Result:

```text
[0, 1, 2]
```

#### See also {#see-also}

* [Service usage concepts](../concepts/index.md).
* [Step-by-step guides on managing API gateways](../operations/index.md).