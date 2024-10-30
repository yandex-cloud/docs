# Deploying a fault-tolerant architecture with preemptible VMs


In this tutorial, you will create a [{{ sf-full-name }}](../../functions/) [function](../../functions/concepts/function.md) in [Node.js](../../functions/lang/nodejs/index.md) that will be invoked on a schedule and restart a stopped [preemptible {{ compute-full-name }} VM](../../compute/concepts/preemptible-vm.md).

The architecture described here is suitable for [VMs](../../compute/concepts/vm.md) with non-critical loads. It allows you to use cost advantages of preemptible VMs and, in the event of a VM shutdown, ensures idle time of under one minute.

To deploy a fault-tolerant architecture with a preemptible VM:
1. [Prepare the environment](#prepare).
1. [Prepare a ZIP archive with the function code](#zip-archive).
1. [Create a function](#func-create).
1. [Create a trigger](#trigger-create).
1. [Test the function](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for VM computing resources (see [{{ compute-name }} pricing](../../compute/pricing.md#prices-instance-resources)).
* Fee for VM [disks](../../compute/concepts/disk.md) (see [{{ compute-name }} pricing](../../compute/pricing.md#prices-storage)).
* Fee for using a dynamic or static [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* [Secret](../../lockbox/concepts/secret.md) storage and request fees (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).
* Fee for the number of function calls, computing resources allocated to a function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for logging operations and data storage in a [log group](../../logging/concepts/log-group.md) (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)) if using [{{ cloud-logging-name }}](../../logging/).

## Prepare the environment {#prepare}

1. [Create](../../iam/operations/sa/create.md) a [service account](../../iam/concepts/users/service-accounts.md) that will be used to invoke the function and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `{{ roles-functions-invoker }}` and `{{ roles-lockbox-payloadviewer }}` [roles](../../iam/concepts/access-control/roles.md).
1. [Create](../../compute/operations/vm-create/create-preemptible-vm.md#create-preemptible) a preemptible VM.

## Create a secret {#create-secret}

Create a {{ lockbox-name }} [secret](../../lockbox/quickstart.md) to store an [OAuth token](../../iam/concepts/authorization/oauth-token.md).

{% note info %}

Use an [OAuth token](../../iam/concepts/authorization/oauth-token.md) if you cannot request an [IAM token](../../iam/concepts/authorization/iam-token.md) automatically. The IAM token is updated more frequently and is therefore more secure.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a secret in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret, e.g., `oauth-token`.
  1. Under **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**:
     * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `key_token`.
     * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the OAuth token value required for function authorization.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  To create a secret, run this command:

  ```bash
  yc lockbox secret create --name oauth-token \
    --payload "[{'key': 'key_token', 'text_value': '<OAuth_token>'}]"
  ```

  Where `text_value` is the OAuth token value required for function authorization.

  Result:

  ```text
  done (1s)
  id: e6qu9ik259lb********
  folder_id: b1g9d2k0itu4********
  ...
    status: ACTIVE
    payload_entry_keys:
      - key_token
  ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the secret parameters:

     ```hcl
     resource "yandex_lockbox_secret" "oauth-token" {
       name = "oauth-token"
     }

     resource "yandex_lockbox_secret_version" "my_version" {
       secret_id = yandex_lockbox_secret.my_secret.id
       entries {
         key        = "key_token"
         text_value = "<OAuth token>"
       }
     }
     ```

     Where:

     * `name`: Secret name
     * `key`: Key of the secret.
     * `text_value`: OAuth token value required for function authorization.

     {% include [secret-version-tf-note](../../_includes/lockbox/secret-version-tf-note.md) %}

     For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

     * [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret).
     * [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version).

  1. Make sure the configuration files are correct.
     1. In the command line, go to the folder where you created the configuration file.
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

     1. Confirm the secret creation: type `yes` in the terminal and press **Enter**.

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

{% endlist %}

## Prepare a ZIP archive with the function code {#zip-archive}

1. Save the following code to a file named `index.js`:

   ```javascript
   import { serviceClients, Session, cloudApi } from '@yandex-cloud/nodejs-sdk';

   const {
     compute: {
       instance_service: {
         ListInstancesRequest,
         GetInstanceRequest,
         StartInstanceRequest,
       },
       instance: {
         IpVersion,
       },
     },
   } = cloudApi;

   const FOLDER_ID = process.env.FOLDER_ID;
   const INSTANCE_ID = process.env.INSTANCE_ID;
   const OAUTHTOKEN = process.env.OAUTHTOKEN;

   export const handler = async function (event, context) {
     const session = new Session({ oauthToken: OAUTHTOKEN });
     const instanceClient = session.client(serviceClients.InstanceServiceClient);
     const list = await instanceClient.list(ListInstancesRequest.fromPartial({
       folderId: FOLDER_ID,
     }));
     const state = await instanceClient.get(GetInstanceRequest.fromPartial({
       instanceId: INSTANCE_ID,
     }));

     var status = state.status

     if (status == 4){
       const startcommand = await instanceClient.start(StartInstanceRequest.fromPartial({
         instanceId: INSTANCE_ID,
       }));
     }

     return {
       statusCode: 200,
       body: {
         status
       }
     };
   };
   ```

1. Save the following code to a file named `package.json`:

   ```json
   {
     "name": "my-awesome-package",
     "version": "1.0.0",
     "type": "module",
     "dependencies": {
       "@yandex-cloud/nodejs-sdk": "latest"
     }
   }
   ```

1. Add the `index.js` and `package.json` files into the `function-js.zip` archive.

## Create a function {#func-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:
     1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
     1. In the window that opens, enter `function-restart-vms` as the function name.
     1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a [function version](../../functions/concepts/function.md#version):
     1. Select the `nodejs18` runtime environment, disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
     1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** field, click **Attach file** and select the `function-js.zip` archive you created earlier.
     1. Specify the entry point: `index.handler`.
     1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `3`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: Select the previously created service account with rights to invoke the function.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
          * `FOLDER_ID`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) you want to start the stopped VM instances in.
          * `INSTANCE_ID`: [ID of the VM instance](../../compute/operations/vm-info/get-info.md#outside-instance) you want to start at interruption.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:
          * In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-env-key }}** field, specify `OAUTHTOKEN`.
          * In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-id }}** field, select the previously created `oauth-token` secret.
          * In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-version-id }}** field, select a version for the secret.
          * In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-key }}** field, select `key_token` as the key name.
        * If you want to avoid logging and paying for {{ cloud-logging-name }}, disable logging by selecting `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-unset }}` in the **{{ ui-key.yacloud.logging.label_destination }}** field under **{{ ui-key.yacloud.logging.label_title }}**.
     1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a function named `function-restart-vms`:

     ```bash
     yc serverless function create --name function-restart-vms
     ```

     Result:

     ```text
     id: d4ebrmenrr7l********
     folder_id: b1g9d2k0itu4********
     created_at: "2023-10-28T17:26:58.200799757Z"
     name: function-restart-vms
     http_invoke_url: https://functions.yandexcloud.net/d4ebrmenrr7l********
     status: ACTIVE
     ```

  1. Create a [version](../../functions/concepts/function.md#version) of the `function-restart-vms` function:

     ```bash
     yc serverless function version create \
       --function-name function-restart-vms \
       --memory=128m \
       --execution-timeout=3s \
       --runtime=nodejs18 \
       --entrypoint=index.handler \
       --service-account-id=<service_account_ID> \
       --environment FOLDER_ID=<folder_ID>,INSTANCE_ID=<VM_ID> \
       --secret name=oauth-token,version-id=<secret_version_ID>,key=key_token,environment-variable=OAUTHTOKEN \
       --source-path=./function-js.zip \
       --no-logging
     ```

     Where:
     * `--function-name`: Name of the function a version of which you are creating.
     * `--memory`: Amount of RAM.
     * `--execution-timeout`: Maximum function running time before the timeout is reached.
     * `--runtime`: Runtime environment.
     * `--entrypoint`: Entry point.
     * `--service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the service account with the permissions to invoke the function.
     * `--environment`: Environment variables:
       * `FOLDER_ID`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) you want to start the stopped VM instances in.
       * `INSTANCE_ID`: [ID of the VM instance](../../compute/operations/vm-info/get-info.md#outside-instance) you want to start at interruption.
     * `--secret`: {{ lockbox-name }} secret data:
       * `name`: Secret name
       * `version-id`: [Secret version](../../lockbox/concepts/secret.md#version) ID.
       * `key`: Key of the secret.
       * `environment-variable`: Environment variable the secret will be kept in.
     * `--source-path`: Path to the `function-js.zip` archive you created earlier.
     * (Optional) `--no-logging`: Set this flag to avoid logging and paying for {{ cloud-logging-name }}.

     Result:

     ```text
     done (16s)
     id: d4etv5f4sjet********
     function_id: d4ebrmenrr7l********
     ...
     log_options:
       disabled: true
       folder_id: b1g9d2k0itu4********
     ```

- {{ TF }} {#tf}

  If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. In the configuration file, describe the `function-restart-vms` function parameters and its [versions](../../functions/concepts/function.md#version):

     ```hcl
     resource "yandex_function" "function-restart-vms" {
       name               = "function-restart-vms"
       user_hash          = "first function"
       runtime            = "nodejs18"
       entrypoint         = "index.handler"
       memory             = "128"
       execution_timeout  = "3"
       service_account_id = "<service_account_ID>"
       folder_id = "<folder_ID>"
       environment = {
         FOLDER_ID = "<folder_ID>"
         INSTANCE_ID = "<VM_ID>"
       }
       secrets {
         id = "<secret_ID>"
         version_id = "<secret_version_ID>"
         key = "key_token"
         environment_variable = "OAUTHTOKEN"
       }
       content {
         zip_filename = "./function-js.zip"
       }
     }
     ```

     Where:
     * `name`: Function name.
     * `user_hash`: Any string to identify the function version.
     * `runtime`: Function [runtime environment](../../functions/concepts/runtime/index.md).
     * `entrypoint`: Entry point.
     * `memory`: Amount of memory allocated for the function, in MB.
     * `execution_timeout`: Function execution timeout.
     * `service_account_id`: [ID](../../iam/operations/sa/get-id.md) of the service account with the permissions to invoke the function.
     * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) you are creating the function in.
     * `environment`: Environment variables:
       * `FOLDER_ID`: ID of the folder you want to start the stopped VM instances in.
       * `INSTANCE_ID`: [ID of the VM instance](../../compute/operations/vm-info/get-info.md#outside-instance) you want to start at interruption.
     * `secrets`: {{ lockbox-name }} secret data:
       * `id`: Secret ID.
       * `version_id`: [Secret version](../../lockbox/concepts/secret.md#version) ID.
       * `key`: Key of the secret.
       * `environment_variable`: Environment variable the secret will be kept in.
     * `zip_filename`: Path to the `function-js.zip` archive you created earlier.

     For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).
  1. Make sure the configuration files are correct.
     1. In the command line, go to the folder where you created the configuration file.
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

     1. Confirm creating the function: type `yes` in the terminal and press **Enter**.

        This will create a function named `function-restart-vms` in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

        ```bash
        yc serverless function get function-restart-vms
        ```

        Result:

        ```text
        id: d4ees84gsdsd********
        folder_id: b1g9d2k0itu4********
        created_at: "2023-08-09T10:11:40.740Z"
        name: function-restart-vms
        log_group_id: ckgjitlio5aj********
        http_invoke_url: https://functions.yandexcloud.net/d4ees84gsdsd********
        status: ACTIVE
        ```

- API {#api}

  To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call.

  To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}

## Create a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [trigger](../../functions/concepts/trigger/index.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Enter a name for the trigger: `timer`.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}**, enter `* * ? * * *` or select `{{ ui-key.yacloud.common.button_cron-1min }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select `function-restart-vms` and specify the following:
     * [**{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}**](../../functions/concepts/function.md#tag): `$latest`.
     * Previously created service account with rights to invoke the function.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  To create a [trigger](../../functions/concepts/trigger/index.md) that invokes a function, run this command:

  ```bash
  yc serverless trigger create timer \
    --name timer \
    --cron-expression '* * ? * * *' \
    --invoke-function-name function-restart-vms \
    --invoke-function-service-account-id <service_account_ID>
  ```

  Where:
  * `--name`: Trigger name.
  * `--cron-expression`: Function invocation schedule specified as a [cron expression](../../functions/concepts/trigger/timer.md#cron-expression).
  * `--invoke-function-name`: Name of the function being invoked.
  * `--invoke-function-service-account-id`: ID of the service account with the permissions to invoke the function.

  Result:

  ```text
  id: a1sv54ekvknb********
  folder_id: b1g9d2k0itu4********
  created_at: "2023-08-08T19:46:22.860681482Z"
  ...
        function_tag: $latest
        service_account_id: ajeh2dukocg3********
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  To create a [trigger](../../functions/concepts/trigger/index.md) that launches a function:
  1. In the configuration file, describe the `timer` trigger parameters:

     ```hcl
     resource "yandex_function_trigger" "timer" {
       name        = "timer"
       timer {
         cron_expression = "* * ? * * *"
       }
       function {
         id = "<function_ID>"
         service_account_id = "<service_account_ID>"
       }
     }
     ```

     Where:
     * `name`: Trigger name.
     * `cron_expression`: Function invocation schedule specified as a [cron expression](../../functions/concepts/trigger/timer.md#cron-expression).
     * `id`: ID of the function for the trigger to invoke.
     * `service_account_id`: ID of the service account with the permissions to invoke the function.

     For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).
  1. Make sure the configuration files are correct.
     1. In the command line, go to the folder where you created the configuration file.
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

        This will create a trigger named `timer` in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

        ```bash
        yc serverless trigger get timer
        ```

        Result:

        ```text
        id: a1s4bvdvmod0********
        folder_id: b1g9d2k0itu4********
        created_at: "2023-08-09T10:19:12.356Z"
        ...
              function_id: d4ebrmenrr7l********
              service_account_id: ajeh2dukocg3********
        status: ACTIVE
        ```

- API {#api}

  To create a timer, use the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Test the function {#test}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder your preemptible VM was created in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the VM name and select **{{ ui-key.yacloud.common.stop }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**. The VM status will change to `Stopped`.
  1. Check the VM status in about one minute or later. The VM status should change to `Running`.

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the trigger](../../functions/operations/trigger/trigger-delete.md).
1. [Delete the function](../../functions/operations/function/function-delete.md).
1. [Delete the secret](../../lockbox/operations/secret-delete.md).
1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. If you logged data to a log group, [delete the group](../../logging/operations/delete-group.md).