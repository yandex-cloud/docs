# Interactive debugging of {{ sf-name }} functions

In this tutorial, you will set up a system to interactively debug {{ sf-full-name }} [functions](../../functions/concepts/function.md) by redirecting requests to a local server. For more information about this solution, see the [yc-serverless-live-debug](https://github.com/yandex-cloud/yc-serverless-live-debug) repository.

To set up the interactive function debugging system:

1. [Prepare your cloud](#prepare-cloud).
1. [Install the required utilities](#install-utilities).
1. [Create a service account with the admin privileges for the cloud](#create-account).
1. [Deploy your resources](#create-resources).
1. [Run the debugging service](#run-client).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for function calls and computing resources allocated to execute the functions (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for the number of requests to the API gateway (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).
* Fee for logging operations and log storage (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).


## Install the required utilities {#install-utilities}

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Create a directory named `live-debug-test` and open it:

   ```
   mkdir live-debug-test
   cd live-debug-test
   ```

1. Install the `yc-serverless-live-debug` package:

   ```
   npm i -D @yandex-cloud/serverless-live-debug
   ```

## Create a service account with the admin privileges for the cloud {#create-account}

1. Create a [service account](../../iam/concepts/users/service-accounts.md):

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
      1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account, such as `sa-live-debug`.

         The name format requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      To create a service account, run the following command:

      ```bash
      yc iam service-account create --name sa-live-debug
      ```

      Where `name` is the name of the service account in the following format:

      {% include [name-format](../../_includes/name-format.md) %}

      Result:

      ```yaml
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-03-04T09:03:11.665153755Z"
      name: sa-live-debug
      ```

   - API

      To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API call.

   - {{ TF }}

      {% include [terraform-install](../../_includes/terraform-install.md) %}

      1. In the configuration file, describe the parameters of the resources you want to create:

         ```hcl
         resource "yandex_iam_service_account" "sa" {
           name        = "sa-live-debug"
           description = "<service_account_description>"
           folder_id   = "<folder_ID>"
         }
         ```

         Where:

         * `name`: Service account name. This is a required parameter.
         * `description`: Service account description. This is an optional parameter.
         * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md). This is an optional parameter. By default, the value specified in the provider settings is used.

         For more information about the `yandex_iam_service_account` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account).

      1. Make sure the configuration files are valid.

         1. In the command line, go to the directory where you created the configuration file.
         1. Run a check using this command:

            ```bash
            terraform plan
            ```

         If the configuration is described correctly, the terminal displays information about the service account. If there are errors in the configuration, Terraform points them out.

      1. Deploy cloud resources.

         1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

   {% endlist %}

1. Assign the service account the `{{ roles-admin }}` [role](../../iam/concepts/access-control/roles.md) for the cloud:

   {% list tabs %}

   - Management console

      1. On the [start page]({{ link-console-main }}) of the management console, select the required cloud.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Find the `sa-live-debug` service account in the list and click ![image](../../_assets/options.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. Click **{{ ui-key.yacloud_components.acl.action.add-role }}** in the window that opens and select the `{{ roles-admin }}` role.
      1. Click **{{ ui-key.yacloud.common.save }}**.

   - CLI

      Run this command:

      ```
      yc resource-manager cloud add-access-binding <cloud_ID> \
         --role {{ roles-admin }} \
         --subject serviceAccount:<service_account_ID>
      ```

      Result:
      ```
      done (1s)
      ```

   - API

      To assign cloud roles to the service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

   - {{ TF }}

      1. In the configuration file, describe the parameters of the resources you want to create:

         ```
         resource "yandex_resourcemanager_cloud_iam_member" "{{ roles-admin }}" {
           cloud_id = "<cloud_ID>"
           role     = "{{ roles-admin }}"
           member   = "serviceAccount:<service_account_ID>"
         }
         ```

         Where:

         * `cloud_id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md). This is a required parameter.
         * `role`: Role being assigned. This is a required parameter.
         * `member`: User or service account the role is being assigned to. It is specified in the following format: `userAccount:<user ID>` or `serviceAccount:<service account ID>`. This is a required parameter.

         For more information about the `yandex_resourcemanager_folder_iam_member` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_member).

      1. Make sure the configuration files are valid.

         1. In the command line, go to the directory where you created the configuration file.
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

   {% endlist %}

## Deploy your resources {#create-resources}

1. Set up the CLI profile to execute operations on behalf of the service account:

   {% list tabs %}

   - CLI

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the service account and save it to the file:

         ```
         yc iam key create \
           --service-account-id <service_account_ID> \
           --folder-id <folder_ID> \
           --output key.json
         ```

         Where:
         * `service-account-id`: `sa-live-debug` ID.
         * `folder-id`: ID of the folder the service account was created in.
         * `output`: Name of the file with the authorized key.

         Result:

         ```
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8********
         created_at: "2023-03-04T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Create a CLI profile to execute operations on behalf of the service account:

         ```
         yc config profile create sa-live-debug
         ```

         Result:

         ```
         Profile 'sa-live-debug' created and activated
         ```

      1. Set the profile configuration:

         ```
         yc config set service-account-key key.json
         yc config set cloud-id <cloud_ID>
         ```

         Where:
         * `service-account-key`: File with the service account authorized key
         * `cloud-id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md)

      1. Add the credentials to the environment variables:

         ```
         export YC_TOKEN=$(yc iam create-token)
         export YC_CLOUD_ID=$(yc config get cloud-id)
         ```

   {% endlist %}

1. Deploy the resources in the cloud by running this command:

   ```
   npx serverless-live-debug deploy
   ```

   As a result, the command will create a `live-debug` folder in the cloud and deploy all the required resources there.

## Run the debugging service {#run-client}

1. In the `live-debug-test` directory, create a `live-debug.config.ts` file:

   ```
   nano live-debug.config.ts
   ```

1. Copy the code with the following configuration to the `live-debug.config.ts` file:

   ```
   import { defineConfig } from '@yandex-cloud/serverless-live-debug';
   import { Handler } from '@yandex-cloud/function-types';

   export default defineConfig({
     handler: <Handler.Http>(event => {
       console.log('got request', event);
       return {
         statusCode: 200,
         body: `Hello from local code!`,
       };
     })
   });
   ```

1. Start the debugging service by running the following command:

   ```
   npx serverless-live-debug run
   ```

   Result:

   ```
   Using config: live-debug.config.ts
   Running local client...
   Starting child...
   Child started
   Watching changes in: live-debug.config.ts
   WS connection opened
   Local client ready.
   Check url: https://d5ddt4ltdvh7********.apigw.yandexcloud.net
   Waiting requests...
   ```

   Where `Check url` is the public address of the {{ api-gw-name }} [API gateway](../../api-gateway/concepts/index.md).

1. Make sure the debug code is working properly. To do this, open another terminal and run this command:

   ```
   curl https://d5ddt4ltdvh7********.apigw.yandexcloud.net
   ```

   Result:

   ```
   Hello from local code!
   ```

For more information about usage examples, see the [yc-serverless-live-debug](https://github.com/yandex-cloud/yc-serverless-live-debug) repository.

## How to delete the resources you created {#clear-out}

Delete the folder with the resources required for interactive debugging of {{ sf-name }} functions:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-cloud }}), select `live-debug`.
   1. Click ![image](../../_assets/options.svg) next to the folder and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the **{{ ui-key.yacloud.component.iam-delete-folder-or-cloud-dialog.field_folder-delete-after }}** field, select `{{ ui-key.yacloud.component.iam-delete-folder-or-cloud-dialog.label_delete-now }}`.
   1. Click **{{ ui-key.yacloud.common.delete }}**.

- API

   To delete a folder, use the [delete](../../resource-manager/api-ref/Folder/delete.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/Delete](../../resource-manager/api-ref/grpc/folder_service.md#Delete) gRPC API call.

{% endlist %}