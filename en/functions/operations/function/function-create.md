---
title: Create function
description: Follow this guide to create a function.
---

# Creating a function

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Enter a name and description for the function. Follow these naming requirements:

        {% include [name-format](../../../_includes/name-format.md) %}

    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function, run the command:

    ```bash
    yc serverless function create --name=<function_name>
    ```

    Result:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: python_function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. In the {{ TF }} configuration file, describe the resources you want to create:

        ```hcl
        resource "yandex_function" "my-function" {
          name       = "<function_name>"
          user_hash  = "<function_version_hash>"
          runtime    = "<runtime_environment>"
          entrypoint = "<entry_point>"
          memory     = "<memory_size>"
          content {
            zip_filename = "<path_to_ZIP_archive>"
          }
        }
        ```

        Where:

        * `name`: Function name.
        * `user_hash`: Custom string to define the function version. When the function changes, update this string, too. The function will update when this string is updated.
        * `runtime`: Function [runtime environment](../../concepts/runtime/index.md).
        * `entrypoint`: Function name in the source code that will serve as an entry point to applications.
        * `memory`: Amount of memory allocated for the function, in MB.
        * `content`: Function source code:
            * `zip_filename`: Path to the ZIP archive containing the function source code and relevant dependencies.

        For more information about `yandex_function` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/function).

    1. Create the resources:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

        {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

        ```bash
        yc serverless function list
        ```

- API {#api}

    To create a function, use the [create](../../functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/api-ref/grpc/Function/create.md) gRPC API call.


{% endlist %}
