To provide a [function](../../functions/concepts/function.md) with access to the [secret](../../lockbox/concepts/secret.md), in the function parameters, specify a [service account](../../iam/concepts/users/service-accounts.md) with the following [roles](../../iam/concepts/access-control/roles.md):
* `{{ roles-lockbox-payloadviewer }}` to access the secret (see [Granting permissions to access a secret](../../lockbox/operations/secret-access.md)).
* `kms.keys.encrypterDecrypter` to access the encryption [key](../../kms/concepts/key.md) if the secret was created using a [{{ kms-full-name }}](../../kms/) key (see [Granting permissions to access an encryption key](../../kms/operations/key-access.md)).

A [{{ lockbox-full-name }}](../../lockbox/) secret provided to a function is cached in [{{ sf-full-name }}](../../functions/). As soon as the service account can no longer access the secret, the function may store it for up to 5 minutes.

A new version of a function is created when secrets are transmitted. You cannot transmit secrets to an existing version.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the function.
  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the function to transmit a {{ lockbox-name }} secret to.
  1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
     * In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, the service account with the `{{ roles-lockbox-payloadviewer }}` role.
     * In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** field:
       * Name of the environment variable that will store the secret.
       * Secret ID.
       * Secret version ID.
       * Key of one of the key-value pairs in the secret version.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.

     You can transmit multiple secrets to a function. To do this, click **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**. A new version of the function with the specified secrets will be created.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  To transmit a {{ lockbox-name }} secret to a function, run this command:

  {% note warning %}

  If the secrets were already sent to the previous function version, they will be overwritten.

  {% endnote %}

  ```bash
  yc serverless function version create \
    --function-name=test \
    --runtime nodejs16 \
    --entrypoint index.main \
    --memory 128m \
    --execution-timeout 5s \
    --source-version-id vfdsdeqa1s2d3******** \
    --service-account-id bfbtfcp0o9i8******** \
    --secret environment-variable=KEY,id=fc3q4aq3w5e6********,version-id=fc3gvvz4x5c6********,key=secret-key
  ```

  Where:
  * `--function-name`: Function name.
  * `--runtime`: Runtime environment.
  * `--entrypoint`: Entry point in `<function_file_name>`.`<handler_name>` format.
  * `--memory`: Amount of RAM.
  * `--execution-timeout`: Maximum function running time before the timeout is reached.
  * `--source-version-id`: ID of the function version from which you want to copy the code.
  * `--service-account-id`: ID of the service account with the `{{ roles-lockbox-payloadviewer }}` role.
  * `--secret`:
    * `environment-variable`: Name of the environment variable that will store the secret.
    * `id`: Secret ID.
    * `version-id`: Secret version ID.
    * `key`: Key of one of the key-value pairs in the secret version.

    You can transmit multiple secrets to a function. To do this, specify the `--secret` parameter as many times as needed.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `secrets` section to the function description:

     ```hcl
     resource "yandex_function" "test-function" {
       name               = "test-function"
       description        = "Test function"
       user_hash          = "first-function"
       runtime            = "python37"
       entrypoint         = "main"
       memory             = "128"
       execution_timeout  = "10"
       service_account_id = "<service_account_ID>"
       tags               = ["my_tag"]
       secrets {
         id                   = "<secret_ID>"
         version_id           = "<secret_version_ID>"
         key                  = "<secret_1_key>"
         environment_variable = "<environment_variable_1_name>"
       }
       secrets {
         id                   = "<secret_ID>"
         version_id           = "<secret_version_ID>"
         key                  = "<secret_2_key>"
         environment_variable = "<environment_variable_2_name>"
       }

        content {
          zip_filename = "<path_to_ZIP_archive>"
        }
     }
     ```

     Where:
     * `secrets`: Section with secret settings. It contains the following parameters:
       * `id`: Secret ID. This is a required parameter.
       * `version_id`: Secret version ID. This is a required parameter.
       * `key`: Key of one of the secret version's key-value pairs that will be stored in the environment variable. This is a required parameter.
       * `environment_variable`: Name of the environment variable that will store the secret. This is a required parameter.
  
     For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the function's update settings in the [management console]({{ link-console-main }}).

- API {#api}

  To transmit a {{ lockbox-name }} secret to a function, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionsService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}