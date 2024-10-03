---
title: Adding a function label
description: Follow this guide to add a function label.
---

# Adding a function label

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function.
   1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.list.button_action-edit }}**.
   1. In the **{{ ui-key.yacloud.component.label-set.label_labels }}** field, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
   1. Specify the key and value and press **Enter**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add a label to a function, run the command:

   ```
   yc serverless function add-labels <function_name> --labels <key>=<value>
   ```

   Result:

   ```
   id: b097d9ous3ge********
   folder_id: aoek49ghmknn********
   created_at: "2019-06-06T11:36:48.688Z"
   name: my-beta-function
   description: My beta function.
   labels:
     test: test
     version: beta
   log_group_id: eolv6578frac********
   http_invoke_url: https://{{ sf-url }}/b097d9ous3ge********
   status: ACTIVE
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To add a function label:

   1. In the {{ TF }} configuration file, add the `labels` section and specify a list of labels in it in `<key>:"<value>"` format.

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
          service_account_id = "<service_account_ID>"
          tags               = ["my_tag"]
          labels = {
            <key_1>:"<value_1>",
            <key_2>:"<value_2>"
          }
          content {
              zip_filename = "<ZIP_archive_path>"
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

   You can check the addition of function labels using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function get <function_name_or_ID>
   ```

- API {#api}

   To add a label to a function, use the [update](../../functions/api-ref/Function/update.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Update](../../functions/api-ref/grpc/function_service.md#Update) gRPC API call.

{% endlist %}
