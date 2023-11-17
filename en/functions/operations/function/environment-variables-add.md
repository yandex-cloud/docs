# Adding function environment variables

When you add environment variables, a new version of the function is created. You cannot add variables to an existing version.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select the function whose version you want to add an environment variable for.
   1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify the environment variable and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**. You can add multiple environment variables.
   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**. This will create a new version of the function with the specified environment variables.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add environment variables, run the command:

   {% note warning %}

   If the previous version contained environment variables, this command overwrites them.

   {% endnote %}

   ```bash
   yc serverless function version create \
     --function-name=<function_name> \
     --runtime <runtime_environment> \
     --entrypoint <entry_point> \
     --memory 128m \
     --execution-timeout 5s \
     --source-version-id <version_ID> \
     --environment <environment_variables>
   ```

   Where:

   * `--function-name`: Function name.
   * `--runtime`: Runtime environment.
   * `--entrypoint`: Entry point specified in the `<function_file_name>.<handler_name>` format.
   * `--memory`: Amount of RAM.
   * `--execution-timeout`: Maximum function execution time before the timeout is reached.
   * `--source-version-id`: ID of the function version to copy the code of.
   * `--environment`: Environment variables in `key=value` format. You can specify multiple pairs separated by commas.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To add environment variables:

   1. In the configuration file, add the `environment` section for the `yandex_function` resource and specify the list of environment variables in `<key> = "<value>"` format.

      Example function description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_function" "test-function" {
          name               = "test-function"
          description        = "Test function"
          user_hash          = "first-function"
          runtime            = "python37"
          entrypoint         = "main"
          memory             = "128"
          execution_timeout  = "10"
          service_account_id = "<service account ID>"
          tags               = ["my_tag"]
          environment = {
              <environment_variable_key> = "<environment_variable_value>"
          }
          content {
              zip_filename = "<path_to_ZIP_archive>"
          }
      }
      ```

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

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

   You can verify that the environment variables are there in the [management console]({{ link-console-main }}).

- API

   To add environment variables, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.


- {{ yandex-cloud }} Toolkit

   You can add environment variables using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}


## See also

* [Environment variables](../../concepts/runtime/environment-variables.md#env).