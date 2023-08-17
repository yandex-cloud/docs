# Deleting a function label

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete a function label, run this command:

   ```
   yc serverless function remove-labels <function name> --labels <key>
   ```

   Result:

   ```
   id: b097d9ous3gep99khe83
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   description: My beta function.
   labels:
     version: beta
   log_group_id: eolv6578frac08uh5h6s
   http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
   status: ACTIVE
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a function label:

   1. Open the {{ TF }} configuration file and delete the unnecessary label in the `labels` section.

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
          labels = {
            <key1>:"<value1>",
            <key2>:"<value2>"
          }
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

   You can verify the deletion of the function labels using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function get <function_name>|<function_ID>
   ```

- API

   To delete a function label, use the [update](../../functions/api-ref/Function/update.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Update](../../functions/api-ref/grpc/function_service.md#Update) gRPC API call.

{% endlist %}
