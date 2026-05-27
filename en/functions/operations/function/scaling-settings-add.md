---
title: How to configure function scaling in {{ sf-full-name }}
description: Follow this guide to configure function scaling.
---

# Adding function scaling settings

You can set the following:

{% include [scaling](../../../_includes/functions/scaling.md) %}

{% include [provisioned-instances-price](../../../_includes/functions/provisioned-instances-price.md) %}

You can configure different scaling settings for different function [versions](../../concepts/function.md#version) using [tags](../../concepts/function.md#tag). Scaling settings will apply to the function version with the specified tag assigned. Function versions are scaled independently of each other.

The scaling settings must be within the [quotas](../../concepts/limits.md#functions-quotas).

{% note info %}

{% include [provisioned-instances-time](../../../_includes/functions/provisioned-instances-time.md)%}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, hover over the version tag (e.g., ![image](../../../_assets/console-icons/gear.svg) or `$latest`) of the function you want to add scaling settings for.
    1. In the pop-up window, click **{{ ui-key.yacloud.common.add }}**.
    1. In the window that opens, specify the following:
        * **zone_instances_limit**: Number of function instances per availability zone.
        * **zone_requests_limit**: Number of concurrent function calls per availability zone.
        * **provisioned_instances_count**: Number of provisioned instances.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    To configure scaling settings, run this command:

    ```bash
    yc serverless function set-scaling-policy \
      --id=<function_ID> \
      --tag=\$latest \
      --zone-instances-limit=1 \
      --zone-requests-limit=2 \
      --provisioned-instances-count=3
    ```

    Where:

    * `--id`: Function ID. To find out the ID, [get](./function-list.md) the list of functions.
    * `--tag`: Function version [tag](../../concepts/function.md#tag).
    * `--zone-instances-limit`: Number of function instances.
    * `--zone-requests-limit`: Number of calls in progress.
    * `--provisioned-instances-count`: Number of provisioned instances.

    Result:

    ```bash
    function_id: d4eokpuol55h********
    tag: $latest
    zone_instances_limit: "1"
    zone_requests_limit: "2"
    provisioned_instances_count: "3"
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}  

    To add scaling settings:

    1. In the configuration file, describe the resources you want to create:

       * `yandex_function`: Description of the function being created and its source code.
         * `name`: Function name.
         * `user_hash`: Any string to identify the function version. When you change the function, update this string as well. Updating this string triggers a function update.
         * `runtime`: Function [runtime](../../concepts/runtime/index.md).
         * `entrypoint`: Entry point in `<file_name_without_extension>.<handler_name>` format.
         * `memory`: Amount of memory allocated to the function, in MB.
         * `execution_timeout`: Maximum function execution time before timeout.
         * `service_account_id`: ID of the service account you want to use to invoke the function.
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
            runtime            = "<runtime>"
            entrypoint         = "<entry_point>"
            memory             = "128"
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

        For more information about resource properties, see [yandex_function_scaling_policy]({{ tf-provider-resources-link }}/function_scaling_policy).

    1. Validate your configuration using this command:
        
       ```
       terraform validate
       ```

       If the configuration is valid, you will get this message:
        
       ```
       Success! The configuration is valid.
       ```

    1. Run this command:

       ```
       terraform plan
       ```

       You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors in the configuration. 

    1. Apply the configuration changes:

       ```
       terraform apply
       ```
    1. Type `yes` and press **Enter** to confirm the changes.

    You can check that the scaling settings are added using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:
    
    ```
    yc serverless function list-scaling-policies <function_name_or_ID>
    ```

- API {#api}

    To set scaling settings, use the [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/SetScalingPolicy](../../functions/api-ref/grpc/Function/setScalingPolicy.md) gRPC API call.



{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}
