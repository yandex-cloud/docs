# Adding function environment variables

When you add environment variables, a new version of the function is created. You can't add variables to an existing version.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. Select the function whose version you want to add an environment variable for.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, specify the environment variable and click **Add**. You can add multiple environment variables.
   1. Click **Create version**. A new version of the function with the specified environment variables is created.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add environment variables, run the command:

   {% note warning %}

   If the previous version contained environment variables, this command overwrites them.

   {% endnote %}

   ```
   yc serverless function version create \
     --function-name=<function name> \
     --runtime <runtime environment> \
     --entrypoint <entry point> \
     --memory 128m \
     --execution-timeout 5s \
     --source-version-id <version ID> \
     --environment <environment variables>
   ```

   Where:

   * `--function-name`: The function name.
   * `--runtime`: The runtime environment.
   * `--entrypoint`: The entry point specified in the <function file name>.<handler name> format.
   * `--memory`: The amount of RAM.
   * `--execution-timeout`: The maximum function execution time before the timeout is reached.
   * `--source-version-id`: The ID of the function version to copy the code of.
   * `--environment`: Environment variables in key=value format. You can specify multiple pairs separated by commas.

- API

   You can add environment variables using the [createVersion](../../functions/api-ref/Function/createVersion.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add environment variables:

   1. In the configuration file, add the `environment` section for the `yandex_function` resource and specify the list of environment variables in `<key>:"<value>"` format.

      Example function description in the {{ TF }} configuration:

      ```
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
              <environment_variable_key> = "<environment_variable_name>"
          }
          content {
              zip_filename = "<path to ZIP archive>"
          }
      }
      ```

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-link }}/function).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that the environment variables are there in the [management console]({{ link-console-main }}).

- {{ yandex-cloud }} Toolkit

   You can add environment variables using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## See also

* [Environment variables](../../concepts/runtime/environment-variables.md#env).