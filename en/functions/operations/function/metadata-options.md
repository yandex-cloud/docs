# Configuring metadata service parameters for a function

You can configure metadata service parameters when [creating a function version](version-manage.md).

{% include [metadata-options](../../../_includes/functions/metadata-options.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [function](../../concepts/function.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select a function.
  1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
  1. Expand the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-additional-parameters }}** section.
  1. Under **Metadata service parameters**, configure the parameters of the function metadata service: `{{ ui-key.yacloud.serverless-functions.item.editor.label_gce_http_endpoint }}` and `{{ ui-key.yacloud.serverless-functions.item.editor.label_aws_v1_http_endpoint }}`.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  To configure metadata service parameters for a function, run this command:

  ```bash
  yc serverless function version create \
    --function-id=<function_ID> \
    --runtime <runtime_environment> \
    --entrypoint <entry_point> \
    --source-version-id <version_ID> \
    --metadata-options <option>=<enabled_or_disabled>
  ```

  Where:

  * `--function-id`: ID of the function a new version of which you want to create. To find out the function ID, [get a list of functions](function-list.md) in the folder.
  * `--runtime`: Runtime environment.
  * `entrypoint`: Entry point in `<function_file_name>.<handler_name>` format.
  * `--source-version-id`: ID of the function version from which you want to copy the code. To find out the ID, [get a list of function versions](version-list.md).
  * `--metadata-options`: Settings for the metadata service parameters, e.g., `aws-v1-http-endpoint=disabled`.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    To configure metadata service parameters for a function:

    1. Open the Terraform configuration file and add the `metadata_options` section to the function description:
      
        ```hcl
        resource "yandex_function" "metadata_function" {
          name               = "<function_name>"
          user_hash          = "<function_hash>"
          runtime            = "<runtime_environment>"
          entrypoint         = "<entry_point>"
          memory             = "<RAM_size>"
          execution_timeout  = "<execution_timeout>"
          service_account_id = "<service_account_ID>"
          content {
            zip_filename = "<path_to_ZIP_archive>"
          }

          metadata_options {
            metadata_options.0.gce_http_endpoint = "0_or_1_or_2"
            metadata_options.0.aws_v1_http_endpoint = "0_or_1_or_2"
          }
        }
        ```

        Where:

        * `metadata_options`: Settings for the metadata service parameters, e.g., `metadata_options.0.gce_http_endpoint = "1"`. Specify the following:
            * `0` if you want to keep the default value.
            * `1` to enable the parameter.
            * `2` to disable the parameter.

        For more information about the `yandex_function` resource parameters, see [this Terraform article]({{ tf-provider-resources-link }}/function).

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   You can check the function update and its new configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc serverless function version get <function_version_ID>
   ```

- API {#api}

  To create a function version, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}
