# Removing a function version tag

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To remove a version tag, run the command:

   ```
   yc serverless function version remove-tag --id <version ID> --tag <tag>
   ```

   Result:

   ```
   id: b09ch6pmpohfc9sogj5f
   function_id: b097d9ous3gep99khe83
   created_at: "2019-06-13T09:12:38.464Z"
   runtime: python37
   entrypoint: test.handler
   resources:
     memory: "134217728"
   execution_timeout: 5s
   image_size: "4096"
   status: ACTIVE
   tags:
   - beta
   log_group_id: eolv6578frac08uh5h6s
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a version tag:

   1. Open the {{ TF }} configuration file and delete the string with the unnecessary tag in the `tags` section.

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

   You can verify that the tags have been deleted in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function version list --function-name <function name>
   ```

- API

   To remove a function version tag, use the [removeTag](../../functions/api-ref/Function/removeTag.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/RemoveTag](../../functions/api-ref/grpc/function_service.md#RemoveTag) gRPC API call.

- {{ yandex-cloud }} Toolkit

   You can delete a tag using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).

{% endlist %}
