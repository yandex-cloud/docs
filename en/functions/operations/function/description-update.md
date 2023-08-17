# Updating the description of a function

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you want to change the [function](../../concepts/function.md) description.
   1. Select **{{ sf-name }}**.
   1. Select a function.
   1. In the top-right corner, click **Edit**.
   1. In the window that opens, enter the description of the function.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To change the function description, run the command:

   ```
   yc serverless function update <function name> --description "<function description>"
   ```

   Result:

   ```
   id: b097d9ous3gep99khe83
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   description: My beta function.
   labels:
     test: test
   log_group_id: eolv6578frac08uh5h6s
   http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
   status: ACTIVE
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the function description:

   1. Open the {{ TF }} configuration file and edit the `description` field in the fragment with the function description.

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
          content {
              zip_filename = "<path to ZIP archive>"
          }
      }
      ```

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify the change to the function description using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function get <function_name>|<function_ID>
   ```

- API

   To update a function description, use the [update](../../functions/api-ref/Function/update.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Update](../../functions/api-ref/grpc/function_service.md#Update) gRPC API call.

- {{ yandex-cloud }} Toolkit

   You can update the function description using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).

{% endlist %}
