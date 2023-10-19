To provide the function with access to the [secret](../../lockbox/concepts/secret.md), specify a [service account](../../iam/concepts/users/service-accounts.md) with the following roles in the function parameters:
* `{{ roles-lockbox-payloadviewer }}` for the secret (see [how to grant access rights to secrets](../../lockbox/operations/secret-access.md)).
* `kms.keys.encrypterDecrypter` for the encryption key if the secret was created using a {{ kms-full-name }} key (see [how to grant access rights to encryption keys](../../kms/operations/key-access.md)).

A new version of a function is created when secrets are transmitted. You cannot transmit secrets to an existing version.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function where you want to transmit a {{ lockbox-name }} secret to.
   1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
      * In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, the service account with the `{{ roles-lockbox-payloadviewer }}` role.
      * In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** field:
         * Name of the environment variable where the secret will be kept.
         * Secret ID.
         * Secret version ID.
         * Non-secret key ID.
   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**. You can transmit multiple secrets to a function.
   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**. A new version of the function with the specified secrets will be created.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To transmit a {{ lockbox-name }} secret to a function, run this command:

   {% note warning %}

   If the secrets were already sent to the previous function version, they will be overwritten.

   {% endnote %}

   ```
   yc serverless function version create \
     --function-name=test \
     --runtime nodejs16 \
     --entrypoint index.main \
     --memory 128m \
     --execution-timeout 5s \
     --source-version-id vfdsde*************** \
     --service-account-id bfbtfc************** \
     --secret environment-variable=KEY,id=fc3q4a**************,version-id=fc3gvv**************,key=key-id
   ```

   Where:

   * `--function-name`: Function name.
   * `--runtime`: Runtime environment.
   * `--entrypoint`: Entry point specified in the <function file name>.<handler name> format.
   * `--memory`: Amount of RAM.
   * `--execution-timeout`: Maximum function execution time before the timeout is reached.
   * `--source-version-id`: ID of the function version to copy the code of.
   * `--service-account-id`: ID of the service account with the `{{ roles-lockbox-payloadviewer }}` role.
   * `--secret`:
      * `environment-variable`: Name of the environment variable where the secret will be kept.
      * `id`: Secret ID.
      * `version-id`: Secret version ID.
      * `key`: Non-secret key ID.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
          key                  = "<secret1_key>"
          environment_variable = "<environment_variable1_name>"
        }
        secrets {
          id                   = "<secret_ID>"
          version_id           = "<secret_version_ID>"
          key                  = "<secret2_key>"
          environment_variable = "<environment_variable2_name>"
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
         * `key`: Non-secret key ID to be stored in an environment variable. This is a required parameter.
         * `environment_variable`: Name of the environment variable where the secret will be kept. This is a required parameter.

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   You can check whether the function and its settings are updated in the [management console]({{ link-console-main }}).

- API

   To transmit a {{ lockbox-name }} secret to a function, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionsService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.

{% endlist %}