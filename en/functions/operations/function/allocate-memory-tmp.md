---
title: Allocating memory for the /tmp directory
description: In this tutorial, you will learn how to allocate some RAM within a function for the /tmp directory.
---

# Allocating memory for the /tmp directory

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function.
   1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
   1. In the **Memory** section under **Additional settings**, enable **Allocate memory for the /tmp directory**.
   1. In the **Allocated memory** field, specify the amount of memory to allocate.
   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To allocate some RAM for the `/tmp` directory, run the command:

   ```bash
   yc serverless function version create \
     --function-name=<function_name> \
     --runtime <runtime_environment> \
     --entrypoint <entry_point> \
     --memory <RAM_amount> \
     --source-version-id <version_ID> \
     --tmpfs-size <RAM_amount_for_tmp>
   ```

   Where:

   * `--function-name`: Function name.
   * `--runtime`: Runtime environment.
   * `--entrypoint`: Entry point specified in the `<function_file_name>.<handler_name>` format.
   * `--memory`: RAM amount.
   * `--source-version-id`: ID of the function version you want to copy the code of.
   * `--tmpfs-size`: RAM you want to allocate for the `/tmp` directory.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To allocate some RAM for the `/tmp` directory:

   1. In the configuration file, add the `tmpfs_size` argument for the `yandex_function` resource and specify the amount of RAM to allocate.

      Example function description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_function" "test-function" {
          name               = "<function_name>"
          user_hash          = "<hash>"
          runtime            = "<runtime_environment>"
          entrypoint         = "<entry_point>"
          memory             = "<RAM_amount>"
          tmpfs_size         = "<RAM_amount_for_tmp>"

          content {
              zip_filename = "<ZIP_archive_path>"
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

   You can use the [management console]({{ link-console-main }}) to check memory allocation for the `/tmp` directory.

- API {#api}

   To allocate some RAM for the `/tmp` directory, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.

{% endlist %}

## See also {#see-also}

* [User files](../../concepts/runtime/environment-variables.md#files)
