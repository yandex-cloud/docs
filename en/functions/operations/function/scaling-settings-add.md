---
title: How to configure function scaling settings in {{ sf-full-name }}
description: Follow this guide to configure function scaling settings.
---

# Adding function scaling settings

You can set the following:

{% include [scaling](../../../_includes/functions/scaling.md) %}

{% include [provisioned-instances-price](../../../_includes/functions/provisioned-instances-price.md) %}

You can configure different scaling settings for different function [versions](../../concepts/function.md#version) using [tags](../../concepts/function.md#tag). Scaling settings will be valid for the function version that the specified tag is assigned to. Function versions are scaled independently of each other.

The scaling settings must be within the [quotas](../../concepts/limits.md#functions-quotas).

{% note info %}

{% include [provisioned-instances-time](../../../_includes/functions/provisioned-instances-time.md)%}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select a function.
    1. To configure:
        * Any scaling setting other than the number of calls processed concurrently by a single function instance (`concurrency`):
            1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, hover over the version tag (e.g., ![image](../../../_assets/console-icons/gear.svg) or `$latest`) of the function you want to add scaling settings for.
            1. In the pop-up window, click **{{ ui-key.yacloud.common.add }}**.
            1. In the window that opens, specify:
                * **zone_instances_limit**: Number of function instances in an availability zone.
                * **zone_requests_limit**: Number of concurrent function calls in an availability zone.
                * **provisioned_instances_count**: Number of provisioned instances.
            1. Click **{{ ui-key.yacloud.common.save }}**.
        * [Number of calls processed concurrently by a single function instance](../../concepts/function.md#concurrency) (`concurrency`):
            1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
            1. Under **Additional settings**, in the **Concurrent function instance calls** section, check **Enable** and enter the number of concurrent function instance calls.
            1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    To configure:

    * Any scaling setting other than the number of calls processed concurrently by a single function instance (`concurrency`), run this command:

        ```bash
        yc serverless function set-scaling-policy \
          --id=<function_ID> \
          --tag=\$latest \
          --zone-instances-limit=1 \
          --zone-requests-limit=2 \
          --provisioned-instances-count=3
        ```

        Where:

        * `--id`: Function ID. To find out the ID, [request](./function-list.md) a list of functions.
        * `--tag`: Function version [tag](../../concepts/function.md#tag).
        * `--zone-instances-limit`: Number of function instances.
        * `--zone-requests-limit`: Number of calls in progress.
        * `--provisioned-instances-count`: Number of ready-to-go instances.

        Result:

        ```bash
        function_id: d4eokpuol55h********
        tag: $latest
        zone_instances_limit: "1"
        zone_requests_limit: "2"
        provisioned_instances_count: "3"
        ```

    * [Number of calls processed concurrently by a single function instance](../../concepts/function.md#concurrency) (`concurrency`), run this command:

        ```bash
        yc serverless function version create \
        --function-name=<function_name> \
        --runtime <runtime_environment> \
        --entrypoint <entry_point> \
        --memory 128m \
        --concurrency 2 \
        --execution-timeout 3s \
        --source-path <path_to_ZIP_archive>
        ```

        Where:

        * `--function-name`: Name of the function whose version you want to create.
        * `--runtime`: Function [runtime environment](../../concepts/index.md).
        * `--entrypoint`: Entry point in the following format: `<file_name_without_extension>.<listener_name>`.
        * `--memory`: Amount of RAM.
        * `--concurrency`: Maximum number of calls processed concurrently by a single function instance.
        * `--execution-timeout`: Maximum function running time before the timeout is reached.
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

    To add scaling settings:

    1. In the configuration file, describe the parameters of the resources you want to create:

       * `yandex_function`: Description of the function being created and its source code.
         * `name`: Function name.
         * `user_hash`: Any string to identify the function version. When the function changes, update this string, too. The function will update when this string is updated.
         * `runtime`: Function [runtime environment](../../concepts/runtime/index.md).
         * `entrypoint`: Entry point in the following format: `<file_name_without_extension>.<listener_name>`.
         * `memory`: Amount of memory allocated for the function, in MB.
         * `concurrency`: [Maximum number of calls processed concurrently by a single function instance](../../concepts/function.md#concurrency).
         * `execution_timeout`: Maximum function running time before the timeout is reached.
         * `service_account_id`: ID of the service account to call the function under.
         * `content`: Function source code.
           * `content.0.zip_filename`: Name of the ZIP archive containing the function source code.
       * `yandex_function_scaling_policy`: Description of function scaling settings.
         * `function_id`: Function ID.
         * `policy`: Scaling settings:
           * `policy.0.tag`: Function version [tag](../../concepts/function.md#tag).
           * `policy.0.zone_instances_limit`: Number of function instances.
           * `policy.0.zone_requests_limit`: Number of calls in progress.

        Here is an example of the configuration file structure:

        ```
        provider "yandex" {
            token     = "<service_account_OAuth_token_or_static_key>"
            folder_id = "<folder_ID>"
            zone      = "{{ region-id }}-a"
        }

        resource "yandex_function" "test-function" {
            name               = "<function_name>"
            user_hash          = "<hash>"
            runtime            = "<runtime_environment>"
            entrypoint         = "<entry_point>"
            memory             = "128"
            concurrency        = "2"
            execution_timeout  = "10"
            service_account_id = "<service_account_ID>"
            content {
                zip_filename = "<path_to_ZIP_archive>"
            }
        }

        resource "yandex_function_scaling_policy" "my_scaling_policy" {
            function_id = "<function_ID>"
            policy {
                tag = "$latest"
                zone_instances_limit = 2
                zone_requests_limit  = 1
            }
        }
        ```

        For more information about resource parameters, see [yandex_function]({{ tf-provider-resources-link }}/yandex_function) and [yandex_function_scaling_policy]({{ tf-provider-resources-link }}/yandex_function_scaling_policy).

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

    You can check that the scaling settings are added using the [management console]({{ link-console-main }}) or these [CLI](../../../cli/quickstart.md) commands:
    
    ```
    yc serverless function list-scaling-policies <function_name_or_ID>

    yc serverless function version get <version_ID>
    ```

- API {#api}

    To configure any function scaling setting other than the number of calls processed concurrently by a single function instance (`concurrency`), use the [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/SetScalingPolicy](../../functions/api-ref/grpc/Function/setScalingPolicy.md) gRPC API call.

    To set the number of calls processed concurrently by a single function instance (`concurrency`), create a function version using the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md) gRPC API call. Add the `concurrency` field to the request body.

- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    You can configure any function scaling setting other than the number of calls processed concurrently by a single function instance (`concurrency`) using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).

{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}
