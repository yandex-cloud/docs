# Authorization using {{ sf-name }} functions in Ory Kratos

In this tutorial, you will deploy a [{{ cloud-apps-full-name }} application](../../cloud-apps/kratos.md) for authentication, authorization, and user account management based on [Ory Kratos](https://www.ory.sh/docs/kratos/ory-kratos-intro). You will also write a {{ sf-name }} [function](../../functions/concepts/function.md) that will run the deployed request authorization service and provide it with a session key received from Ory Kratos after successful authentication. Finally, you will connect the created function to API Gateway as an authorizer.

To deploy an infrastructure:

1. [Prepare the environment](#prepare).
1. [Download and build a project](#download-project).
1. [Create service accounts](#create-sa).
1. [Deploy Identity Server based on Ory Kratos](#deploy-kratos).
1. [Create an authorization function](#create-function).
1. [Create an API gateway](#create-api-gw).
1. [Check the result](#check).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Payment for computing resources, the amount of storage and backups for a {{ PG }} cluster (see [{{ mpg-full-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for incoming traffic processed by a network load balancer and for the number of network load balancers (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).
* Payment for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for the number of container calls, computing resources allocated to execute the application, and outgoing traffic (see [{{ serverless-containers-full-name }} pricing](../../serverless-containers/pricing.md)).
* Secret storage and request fees (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for logging operations and log storage (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).

## Prepare the environment {#prepare}

1. [Get](../../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys) an SSH key pair to connect to a VM.
1. Request from your email service provider the data required to connect to the SMTP server, including the SMTP server address and port, username and password to access the SMTP server. This data will be used for authorization in the service sending emails.
1. [Create](../../vpc/operations/network-create.md) a cloud network {{ vpc-name }}.

## Download and build a project {#download-project}

1. Clone the repository with the project:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-apigw-function-authorizer-kratos.git
   ```

1. Go to the folder with the project files: `yc-serverless-apigw-function-authorizer-kratos`.
1. Install [Node.js](https://nodejs.org/ru/download/package-manager/) by running the command below:

   ```bash
   curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - \
   sudo apt-get install -y nodejs
   ```

1. Install dependencies by running the command below:

   ```bash
   npm install
   ```

1. Build the project by running the command below:

   ```bash
   npm run build
   ```

1. Go to the `yc-serverless-apigw-function-authorizer-kratos/build` folder and add a file named `index.js` to the `index-js.zip` archive.

## Create service accounts {#create-sa}

1. Create the `sa-for-kratos` [service account](../../iam/concepts/users/service-accounts.md), under which the resources for Identity Server based on Ory Kratos will be created:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
      1. Go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter the service account name: `sa-for-kratos`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `{{ roles-admin }}` role.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Create the `sa-for-kratos` service account:

         ```bash
         yc iam service-account create --name sa-for-kratos
         ```

         Result:

         ```
         id: nfersamh4sjq********
         folder_id: b1gc1t4cb638********
         created_at: "2023-03-21T10:36:29.726397755Z"
         name: sa-for-kratos
         ```

         Save the `id` of the `sa-for-kratos` service account and that of the folder where it was created (`folder_id`).

      1. Assign the service account the role `{{ roles-admin }}` for the folder.

         ```bash
         yc resource-manager folder add-access-binding <folder_ID> \
           --role admin \
           --subject serviceAccount:<service_account_ID>
         ```

         Result:

         ```
         done (1s)
         ```

   - {{ TF }}

      
      If you do not have {{ TF }} yet, [install it and configure the provider {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


      1. In the configuration file, describe the service account parameters:

         ```hcl
         resource "yandex_iam_service_account" "sa-for-kratos" {
           name        = "sa-for-kratos"
           folder_id   = "<folder_ID>"
         }

         resource "yandex_resourcemanager_folder_iam_member" "admin" {
           folder_id = "<folder_ID>"
           role      = "admin"
           member    = "serviceAccount:${yandex_iam_service_account.sa-for-kratos id}"
         }
         ```

         Where:

         * `name`: Service account name. Required parameter.
         * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md). Optional parameter. By default, the value specified in the provider settings is used.
         * `role`: Role being assigned.

         For more information about the `yandex_iam_service_account` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account).

      1. Make sure the configuration files are valid.

         1. In the command line, go to the directory where you created the configuration file.
         1. Run the check using this command:

            ```bash
            terraform plan
            ```

         If the configuration is described correctly, the terminal displays information about the service account. If the configuration contains any errors, {{ TF }} will point them out.

      1. Deploy cloud resources.

         1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

         1. Confirm the service account creation by typing `yes` in the terminal and pressing **Enter**.

            The service account will then be created. You can check the new service account using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

            ```bash
            yc iam service-account list
            ```

   - API

      To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API call.

      To assign the service account the `{{ roles-admin }}` role for the folder, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

   {% endlist %}

1. Follow the same steps to create an `sa-func-authorizer` service account with the `{{ roles-functions-ivoker }}` role. This service account will be used to invoke the function.

## Deploy Identity Server based on Ory Kratos {#deploy-kratos}

Deploy the Identity Server based on Ory Kratos application using {{ cloud-apps-full-name }}.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.cloud-apps.label_marketplace }}**.
   1. Select `Identity Server based on Ory Kratos` and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
   1. Specify the following:

      * Application name.
      * `sa-for-kratos` service account.
      * ID of the [cloud network](../../vpc/concepts/network.md#network) that you [previously created](#prepare).
      * CIDR for [subnets](../../vpc/concepts/network.md#subnet) in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-c` [availability zones](../../overview/concepts/geo-scope.md). The subnets will be automatically created in the specified cloud network during the application installation.
      * Number of VM instances for the Ory Kratos API.
      * Username to use to access the VM instances via SSH.
      * Public SSH key that you [obtained earlier](#prepare).
      * Username and password to access the DB. Come up with your username and password yourself. Password must be at least eight characters long.
      * Password to access the private Ory Kratos API. Come up with the password yourself.
      * [Previously obtained](#prepare) SMTP server address and port, username and password to access the SMTP server.
      * Sender username and email address to specify in emails from Identity Server based on Ory Kratos.

   1. Click **{{ ui-key.yacloud.cloud-apps.button_install }}** and wait for the installation to complete.
   1. Save the application login link:

      1. Select the application you created.
      1. Under **{{ ui-key.yacloud.cloud-apps.section_resources }}**, select the created API gateway.
      1. Save the value of the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field from the **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_base }}** section.

         Use the `/public`, `/admin`, or `/ui` path to access the public API, private API, or GUI, respectively.

{% endlist %}

## Create an authorization function {#create-function}

Create a function that will run Identity Server based on Ory Kratos for user authorization.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**
   1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. Enter the function name: `kratos-authorizer`.
      1. Click **{{ ui-key.yacloud.common.create }}**.

   1. Create the function version:

      1. Select the `Node.js` runtime environment, disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Specify the `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` upload method and select the `index-js.zip` archive created in the [build project](#download-project) step.
      1. Specify the entry point: `index.js`.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
         * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `sa-func-authorizer`.
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

            * `KRATOS_API_BASE_PATH`: `https://<kratos_api_gw_domain>/public`, where `<kratos_api_gw_domain>` is the API gateway service domain that you saved in the [Deploy Identity Server based on Ory Kratos](#deploy-kratos) step.

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI

   1. Create a function named `kratos-authorizer`:

      ```bash
      yc serverless function create --name=kratos-authorizer
      ```

      Result:

      ```
      id: b09bhaokchn9pn******
      folder_id: aoek49ghmknnpj******
      created_at: "2023-03-21T10:03:37.475Z"
      name: kratos-authorizer
      log_group_id: eolm8aoq9vcpps******
      http_invoke_url: https://{{ sf-url }}/b09bhaokchn9pn******
      status: ACTIVE
      ```

   1. Create a version of `kratos-authorizer`:

      ```bash
      yc serverless function version create \
        --function-name kratos-authorizer \
        --memory=128m \
        --execution-timeout=5s \
        --runtime=nodejs16 \
        --entrypoint=index.js \
        --service-account-id=<service_account_ID> \
        --environment KRATOS_API_BASE_PATH=https://<kratos_api_gw_domain>/public \
        --source-path=./index-js.zip
      ```

      Where:

      * `--function-name`: Name of the function a version of which you are creating.
      * `--memory`: RAM amount.
      * `--execution-timeout`: Maximum function execution time before the timeout is reached.
      * `--runtime`: Runtime environment.
      * `--entrypoint`: Entry point.
      * `--service-account-id`: ID of the `sa-func-authorizer` service account.
      * `--environment`: Environment variables.  `<kratos_api_gw_domain>`: API gateway service domain that you saved in the [Deploy Identity Server based on Ory Kratos](#deploy-kratos) step.
      * `--source-path`: Path to the `index-js.zip` archive.

      Result:

      ```
      done (1s)
      id: d4e6qqlh53nuh5******
      function_id: d4emc80mnp5n96******
      created_at: "2023-03-22T16:49:41.800Z"
      runtime: nodejs16
      entrypoint: index.js
      resources:
        memory: "134217728"
      execution_timeout: 5s
      service_account_id: aje20nhregkcvu******
      image_size: "4096"
      status: ACTIVE
      tags:
        - $latest
      log_group_id: ckgmc3l93cl0lf******
      environment:
        KRATOS_API_BASE_PATH: https://******/public
      log_options:
        folder_id: b1g86q4m5vej8l******
      ```

- {{ TF }}

   1. In the configuration file, describe the function parameters:

      ```
      resource "yandex_function" "kratos-authorizer" {
        name               = "kratos-authorizer"
        user_hash          = "first function"
        runtime            = "nodejs16"
        entrypoint         = "index.js"
        memory             = "128"
        execution_timeout  = "5"
        service_account_id = "<service_account_ID>"
        environment = {
          KRATOS_API_BASE_PATH = https://<kratos_api_gw_domain>/public
        }
        content {
          zip_filename = "./index-js.zip"
        }
      }
      ```

      Where:

      * `name`: Function name.
      * `user_hash`: Arbitrary string that identifies the function version.
      * `runtime`: Function [runtime environment](../../functions/concepts/runtime/index.md).
      * `entrypoint`: Entry point.
      * `memory`: Amount of memory allocated for function execution, in MB.
      * `execution_timeout`: Function execution timeout.
      * `service_account_id`: ID of the `sa-func-authorizer` service account.
      * `environment`: Environment variables. `<kratos_api_gw_domain>`: API gateway service domain that you saved in the [Deploy Identity Server based on Ory Kratos](#deploy-kratos) step.
      * `content`: Path to the `index-js.zip` archive with the function source code.

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the function creation: type `yes` in the terminal and press **Enter**.

- API

   To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/function_service.md#Create) gRPC API call.

   To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.

{% endlist %}

## Create an API gateway {#create-api-gw}

Create an API gateway that will be protected through authorization using the authorizer function created in the previous step.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the Identity Server based on Ory Kratos application is deployed.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** field, enter `for-kratos-authorization`.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, add the specification from the `openapi-example.yaml` file located in the project folder:

      ```yaml
      openapi: 3.0.0
      info:
        title: API with Ory Kratos Authorization
        version: 1.0.0

      paths:
        /authorized/api:
          get:
            summary: Authorized operation, needs session cookie from Ory Kratos
            operationId: cookieAuthApi
            security:
              - cookieAuth: [ ]
            x-yc-apigateway-integration:
              type: dummy
              content:
                '*': "Authorized!"
              http_code: 200
              http_headers:
                'Content-Type': "text/plain"
      components:
        securitySchemes:
          cookieAuth:
            type: apiKey
            in: cookie
            name: ory_kratos_session
            x-yc-apigateway-authorizer:
              type: function
              function_id: <function_ID>
              service_account_id: <service_account_ID>
      ```

      Where:

      * `function_id`: ID of the `kratos-authorizer` function.
      * `service_account_id`: ID of the `sa-func-authorizer` service account.

   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
   1. Save the value of the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field from the **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_base }}** section.

- CLI

   1. Save the following specification to `kratos.yaml`:

      ```yaml
      openapi: 3.0.0
      info:
        title: API with Ory Kratos Authorization
        version: 1.0.0

      paths:
        /authorized/api:
          get:
            summary: Authorized operation, needs session cookie from Ory Kratos
            operationId: cookieAuthApi
            security:
              - cookieAuth: [ ]
            x-yc-apigateway-integration:
              type: dummy
              content:
                '*': "Authorized!"
              http_code: 200
              http_headers:
                'Content-Type': "text/plain"
      components:
        securitySchemes:
          cookieAuth:
            type: apiKey
            in: cookie
            name: ory_kratos_session
            x-yc-apigateway-authorizer:
              type: function
              function_id: <function_ID>
              service_account_id: <service_account_ID>
      ```

      Where:

      * `function_id`: ID of the `kratos-authorizer` function.
      * `service_account_id`: ID of the `sa-func-authorizer` service account.

   1. Create an API gateway:

      ```bash
      yc serverless api-gateway create \
        --name for-kratos-authorization \
        --spec=kratos.yaml \
        --description "ory kratos auth"
      ```

      Result:

      ```bash
      done (41s)
      id: d5delqeel34qjj******
      folder_id: b1g86q4m5vej8l******
      created_at: "2023-03-08T14:07:32.134Z"
      name: for-kratos-authorization
      description: ory kratos auth
      status: ACTIVE
      domain: d5delqeel34qjj******.apigw.yandexcloud.net
      log_group_id: ckg2hdmevnvcng******
      ```

   1. Save the value of the `domain` field.

{% endlist %}

## Check the result {#check}

1. In your browser, open the Identity Server based on Ory Kratos test console page at `https://<kratos_api_gw_domain>/ui/`, where `<kratos_api_gw_domain>` is the API gateway service domain that you saved in the [Deploy Identity Server based on Ory Kratos](#deploy-kratos) step.
1. Register a user.
1. Log in with user credentials: `https://<kratos_api_gw_domain>/ui/login`.
1. Open the developer console in your browser and copy the value of the `ory_kratos_session` cookie.
1. Try to access the `for-kratos-authorization` API gateway:

   ```bash
   curl 'https://<authorized_api_gw_domain>/authorized/api' -H 'Cookie: ory_kratos_session=<ory_kratos_cookie>'
   ```

   Where:

   * `<authorized_api_gw_domain>`: Service domain of the `for-kratos-authorization` API gateway.
   * `<ory_kratos_cookie>`: Value of the `ory_kratos_session` cookie you copied in the previous step.

The `Authorized!` response means that a user session is active and the API was successfully called after checking the authorization cookie.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* Delete the Identity Server based on Ory Kratos application.
* [Delete](../../functions/operations/function/function-delete.md) the {{ sf-full-name }} function.
* [Delete](../../api-gateway/operations/api-gw-delete.md) the {{ api-gw-full-name }} API gateway.
