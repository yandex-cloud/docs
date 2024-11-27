# Canary release of a {{ sf-name }} function


Create a canary release of a {{ sf-name }} function using {{ api-gw-short-name }}.

To create a canary release:
1. [Prepare your cloud](#before-begin).
1. [Create a service account](#create-account).
1. [Create a {{ sf-name }} function](#create-functions).
1. [Add tags](#add-tag).
1. [Create an API gateway](#create-api-gw).
1. [Test your application](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of resources to support a web application includes:
* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for the number of function calls, computing resources allocated to a function, and outgoing traffic (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).


## Create a service account {#create-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account: `canary-sa`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `editor` role.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `canary-sa`:

      ```bash
      yc iam service-account create --name canary-sa
      ```

      Result:

      ```
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-09-21T10:36:29.726397755Z"
      name: canary-sa
      ```

      Save the ID of the `canary-sa` service account (`id`) and the ID of the folder where it was created (`folder_id`).

  1. Assign the service account the `editor` role for the folder:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```
      done (1s)
      ```

- {{ TF }} {#tf}


  If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  1. In the configuration file, describe the service account parameters:

      ```hcl
      resource "yandex_iam_service_account" "canary-sa" {
        name        = "canary-sa"
        folder_id   = "<folder_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "<folder_ID>"
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.canary-sa id}"
      }
      ```

      Where:

      * `name`: Service account name. This is a required parameter.
      * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md). This is an optional parameter. By default, the value specified in the provider settings is used.
      * `role`: Role you want to assign.

      For more information about the `yandex_iam_service_account` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iam_service_account).

  1. Make sure the configuration files are correct.

      1. In the command line, go to the folder where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is specified correctly, the terminal will display information about the service account. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

           ```bash
           terraform apply
           ```

      1. Confirm creating the service account: type `yes` in the terminal and press **Enter**.

           The service account will then be created. You can check the new service account using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

           ```bash
           yc iam service-account list
           ```

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the `editor` role for the folder to the service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}

## Create a {{ sf-name }} function {#create-functions}

[Create two function versions](../../functions/operations/index.md#create-function):
* Version for the current release.
* Version for the canary release to be tested on a certain percentage of requests.

You can use a custom function or create [any function from the list](../../functions/quickstart/create-function/index.md).

## Add tags {#add-tag}

Add the `stable` tag to the first function version and the `canary` tag to the second one.

{% list tabs group=instructions %}

- CLI {#cli}

    To add a version tag, run the command:

    ```
    yc serverless function version set-tag --id <version_ID> --tag <tag>
    ```

    Result:

    ```
    id: b09ch6pmpohf********
    function_id: b097d9ous3ge********
    created_at: "2023-08-22T09:12:38.464Z"
    runtime: python311
    entrypoint: test.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
      - $latest
      - stable
    ```

- {{ TF }} {#tf}

    To add a version tag:

    1. In the configuration file, add the `tags` section for the `yandex_function` resource and specify the list of tags in `tags = ["<tag_name>"]` format.

       Example function description in the {{ TF }} configuration:
      
        ```
        resource "yandex_function" "test-function" {
            name               = "canary-function"
            user_hash          = "canary-function"
            runtime            = "python311"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<service_account_ID>"
            tags               = ["my_tag"]
            content {
                zip_filename = "<path_to_ZIP_archive>"
            }
        }
        ``` 

        For more information about the `yandex_function` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/function).

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
      
    You can check the new tags using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

    ```
    yc serverless function version list --function-name <function_name>
    ```

- API {#api}

    To add a function version tag, use the [setTag](../../functions/functions/api-ref/Function/setTag.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/SetTag](../../functions/functions/api-ref/grpc/Function/setTag.md) gRPC API call.

{% endlist %}

## Create an API gateway {#create-api-gw}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
    1. In the **{{ ui-key.yacloud.common.name }}** field, enter `canary`.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** section, add the specification:
    
        ```yaml
        openapi: 3.0.0
        info:
          title: Sample API
          version: 1.0.0

        x-yc-apigateway:
          variables:
            function.tag:
              default: "stable"
              enum:
                - "stable"
                - "canary"

        paths:
          /:
            get:
              x-yc-apigateway-integration:
                type: cloud_functions
                function_id: <function_ID>
                tag: "${var.function.tag}"
                service_account_id: <service_account_ID>
        ```
    1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.label_section-variables }}**, switch the **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-release }}** toggle to on.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-share }}** field, specify `50`.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-variables }}** field, specify `function.tag`=`canary`.
    1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
    
- CLI {#cli}

    1. Save the following specification to the `spec.yaml` file:
        
        ```yaml
        openapi: 3.0.0
        info:
          title: Sample API
          version: 1.0.0

        x-yc-apigateway:
          variables:
            function.tag:
              default: "stable"
              enum:
                - "stable"
                - "canary"

        paths:
          /:
            get:
              x-yc-apigateway-integration:
                type: cloud_functions
                function_id: <function_ID>
                tag: "${var.function.tag}"
                service_account_id: <service_account_ID>
        ```
    1. Run this command:

        ```bash
        yc serverless api-gateway create --name canary --spec=spec.yaml --canary-weight=50 --canary-variables function.tag=canary
        ```

        Where:
       
        * `--name`: API gateway name.
        * `--spec`: Specification file.
        * `--canary-weight`: Percentage of requests in the canary release.
        * `--canary-variables`: Variables for the canary release.

        Result:

        ```text
        done (5s)
        id: d5d1ud9bli1e********
        folder_id: b1gc1t4cb638********
        created_at: "2023-09-25T16:01:48.926Z"
        name: canary
        status: ACTIVE
        domain: d5d1ud9bli1e********.apigw.yandexcloud.net
        log_group_id: ckgefpleo5eg********
        connectivity: {}
        log_options:
          folder_id: b1gc1t4cb638********
        canary:
          weight: "50"
          variables:
            function.tag:
              string_value: canary
        ```

- {{ TF }} {#tf}

  To create an API gateway:

  1. Describe the parameters of the `yandex_api_gateway` resource in the configuration file:

     ```hcl
     resource "yandex_api_gateway" "canary-api-gateway" {
       name        = "canary"
       canary {
         weight    = 50
         variables = {
           function.tag = "canary"
         }
       }
       spec = <<-EOT
         openapi: 3.0.0
          info:
            title: Sample API
            version: 1.0.0

          x-yc-apigateway:
            variables:
              function.tag:
                default: "stable"
                enum:
                  - "stable"
                  - "canary"

          paths:
            /:
              get:
                x-yc-apigateway-integration:
                  type: cloud_functions
                  function_id: <function_ID>
                  tag: "${var.function.tag}"
                  service_account_id: <service_account_ID>
       EOT
     }
     ```

     Where:
     * `name`: API gateway name. The name format is as follows:

        {% include [name-format](../../_includes/name-format.md) %}

     * `canary.0.weight`: Percentage of requests in the canary release.
     * `canary.0.variables`: Variables for the canary release.
     * `spec`: API gateway specification.

     For more information about the resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/api_gateway).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or these [CLI](../../cli/quickstart.md) commands:

        ```
        yc serverless api-gateway get <API_gateway_name>
        ```

- API {#api}

  To create an API gateway, use the [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md) gRPC API call.

{% endlist %}

## Test the application {#test}

Make several requests to the created API gateway. About one half of requests should be handled by the function version tagged `canary`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
1. [Delete the function](../../functions/operations/function/function-delete.md).
