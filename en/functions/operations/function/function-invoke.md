---
title: How to invoke a function in {{ sf-full-name }}
description: In this guide, you will learn how to invoke a function in {{ sf-full-name }}.
---

# Invoking a function

To allow any user to invoke a function without providing an authorization header, [make it public](./function-public.md). For more information about access permissions, see [{#T}](../../security/index.md).

## Invoking a function {#invoking-function}

In our example, we will use the function described in [{#T}](../function/version-manage.md).

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.

    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. Select the function.

    1. Navigate to the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.

    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** field, specify the function version to invoke.

    1. Under **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}**, select one of these options:

        * **{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}**: Custom data format.
        * **{{ ui-key.yacloud.serverless-functions.item.testing.value_http-request }}**: Data format for a function that handles HTTPS requests. For more information, see [Concepts](../../concepts/function-invoke.md).
        * **{{ ui-key.yacloud.serverless-functions.item.testing.value_ymq-trigger }}**: Data format for a function that is invoked by a trigger to process queue messages.
        * **{{ ui-key.yacloud.serverless-functions.item.testing.value_alice-skill }}**: Data format for invoking a function that receives [requests](https://yandex.ru/dev/dialogs/alice/doc/request.html) from Yandex Dialogs.

    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}**, enter the input data to test the function.

    1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.

    1. You will see the test status under **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}** in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field. **Note that** the maximum function execution time before [timeout](../../operations/function/version-manage.md), including first call initialization, is ten minutes.

    1. You will see the function execution result in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field.

- HTTPS {#https}

    {% include [call-limited-by-access-policies-notice](../../../_includes/functions/call-limited-by-access-policies-notice.md) %}

    You can find the function invocation link:
    * In the **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** field. To get it, [navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** in the [management console]({{ link-console-main }}) and click the function row.
    * In the `http_invoke_url` parameter. To get it, run this command:
        ```
        yc serverless function get <function_name>
        ```

    {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

    For security reasons, you can only call a function via HTTPS. Call it as a regular HTTPS request by pasting the function invocation link into your browser’s address bar. The link should have the following format:

    ```
    https://{{ sf-url }}/<function_ID>
    ```
    
    You can invoke a specific function version using the `tag` parameter. The function with the `$latest` tag is invoked by default.

    * Example of invoking a function with no additional parameters:

        ```
        https://{{ sf-url }}/<function_ID>
        ```

        The following response will appear on the page:

        ```
        Hello, World!
        ```

    * Example of invoking a function by adding the `name` parameter to the URL:

        ```
        https://{{ sf-url }}/<function_ID>?name=<username>
        ```

        The following response will appear on the page:

        ```
        Hello, Username!
        ```
    * Example of invoking a specific function version by adding the `tag` parameter to the URL:
      
        ```
        https://{{ sf-url }}/<function_ID>?tag=<version_tag>
        ```
            
- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    You can invoke a specific function version using the `--tag` parameter. The function with the `$latest` tag is invoked by default.

    {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

    * Invoke the function by specifying a name for the greeting in the parameter:

        ```
        yc serverless function invoke <function_ID> -d '{"queryStringParameters": {"name": "Username"}}'
        ```

        Result:

        ```    
        {"statusCode": 200, "headers": {"Content-Type": "text/plain"}, "isBase64Encoded": false, "body": "Hello, Username!"}
        ```
    * Invoke a specific function version using the `--tag` parameter:
    
        ```
        yc serverless function invoke <function_ID> --tag <version_tag>
        ```


{% endlist %}

To learn more about the function structure required for different invocation methods (HTTPS and CLI), see [{#T}](../../concepts/function-invoke.md).