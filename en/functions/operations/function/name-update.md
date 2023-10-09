# Changing the name of a function

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you want to change the name of a [function](../../concepts/function.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function.
   1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.list.button_action-edit }}**.
   1. In the window that opens, enter the desired function name.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To change the function name, run the command:

   ```
   yc serverless function update <function name> --new-name <new function name>
   ```

   Result:
   ```
   id: b097d9ous3ge********
   folder_id: aoek49ghmknn********
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   labels:
    test: test
   log_group_id: eolv6578frac********
   http_invoke_url: https://{{ sf-url }}/b097d9ous3ge********
   status: ACTIVE
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To change the name of a function:

   1. Open the {{ TF }} configuration file and edit the `name` field in the fragment with the function description.

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

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can check the function name update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function list
   ```

- API

   To rename a function, use the [update](../../functions/api-ref/Function/update.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Update](../../functions/api-ref/grpc/function_service.md#Update) gRPC API call.


- {{ yandex-cloud }} Toolkit

   You can update the function name using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}
