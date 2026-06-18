---
title: How to set the number of calls to be processed concurrently by a single function instance in {{ sf-full-name }}
description: Follow this guide to set the number of calls to be processed concurrently by a single function instance.
---

# Setting the number of concurrent function instance calls

Number of calls processed concurrently by a single function instance (`concurrency`) cannot exceed the relevant [quota](../../concepts/limits.md#functions-quotas). This setting is only available in specific runtime environments. For more information, see [{#T}](../../concepts/function.md#concurrency).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function.
    1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-additional-parameters }}**, in the **{{ ui-key.yacloud.serverless-functions.item.editor.label_concurrency }}** section, check **{{ ui-key.yacloud.serverless-functions.item.editor.field_concurrency-enable }}** and enter the number of concurrent function instance calls.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    To set the number of calls to be processed concurrently by a single function instance, run this command:

    ```bash
    yc serverless function version create \
      --function-name=<function_name> \
      --runtime <runtime_environment> \
      --entrypoint <entry_point> \
      --concurrency 2 \
      --execution-timeout 3s \
      --source-path <path_to_ZIP_archive>
    ```

    Where:

    * `--function-name`: Name of the function whose version you want to create.
    * `--runtime`: Function [runtime](../../concepts/index.md).
    * `--entrypoint`: Entry point in `<file_name_without_extension>.<handler_name>` format.
    * `--concurrency`: Maximum number of calls processed concurrently by a single function instance.
    * `--execution-timeout`: Maximum function execution time before timeout.
    * `--source-path`: ZIP archive with the function code and required dependencies.

    Result:

    ```bash
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs18
    entrypoint: index.handler
    resources:
    memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_options:
    folder_id: b1g681qpemb4********
    concurrency: "2"
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}  

    To set the number of calls to be processed concurrently by a single function instance, set its `concurrency` as follows:

    1. In the configuration file, specify the properties of the resources you want to create:

       * `yandex_function`: Description of the function being created and its source code.
         * `name`: Function name.
         * `user_hash`: Any string to identify the function version. When you change the function, update this string as well. Updating this string triggers a function update.
         * `runtime`: Function [runtime](../../concepts/runtime/index.md).
         * `entrypoint`: Entry point in `<file_name_without_extension>.<handler_name>` format.
         * `memory`: Amount of memory allocated for the function, in MB.
         * `concurrency`: [Maximum number of calls processed concurrently by a single function instance](../../concepts/function.md#concurrency).
         * `execution_timeout`: Maximum function execution time before timeout.
         * `service_account_id`: ID of the service account you want to use to invoke the function.
         * `content`: Function source code.
           * `content.0.zip_filename`: Name of the ZIP archive containing the function source code.

        Here is an example of the configuration file structure:

        ```hcl
        resource "yandex_function" "test-function" {
          name               = "<function_name>"
          user_hash          = "<hash>"
          runtime            = "<runtime>"
          entrypoint         = "<entry_point>"
          memory             = "128"
          concurrency        = "2"
          execution_timeout  = "10"
          service_account_id = "<service_account_ID>"
          content {
            zip_filename = "<path_to_ZIP_archive>"
          }
        }
        ```

        For more information about resource properties, see [yandex_function]({{ tf-provider-resources-link }}/function).

    1. Validate your configuration using this command:
        
       ```bash
       terraform validate
       ```

       If the configuration is valid, you will get this message:
        
       ```text
       Success! The configuration is valid.
       ```

    1. Run this command:

       ```bash
       terraform plan
       ```

       You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors in the configuration. 

    1. Apply the configuration changes:

       ```bash
       terraform apply
       ```
    1. Type `yes` and press **Enter** to confirm the changes.

    You can check that the `concurrency` parameter was added using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:
    
    ```bash
    yc serverless function version get <version_ID>
    ```

- API {#api}

    To set the number of calls to be processed concurrently by a single function instance, create a function version using the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md) gRPC API call. Add the `concurrency` field to the request body.


{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}
