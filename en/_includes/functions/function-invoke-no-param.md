## Invoke the function {#invoke}

{% note info %}

To allow any user to invoke your function, [make it public](../../functions/operations/function/function-public.md). For more information about access permissions, see [{#T}](../../functions/security/index.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function.
    1. Navigate to the ![CirclePlay](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** field, specify `$latest` to invoke the latest function version.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}** field, select `{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}`.
    1. Click ![PlayFill](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
    1. You will see the test status under **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}** in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field. **Note that** the maximum function execution time before [timeout](../../functions/operations/function/version-manage.md), including first call initialization, is ten minutes.
    1. You will see the function execution result in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To invoke a function, run this command:

    ```
    yc serverless function invoke <function_ID>
    ```

    The function version with the `$latest` tag is invoked by default.


- HTTPS {#https}

	You can find the function invocation link on the **{{ ui-key.yacloud.common.overview }}** tab, in the **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** field.

	For security reasons, you can only invoke a function via HTTPS. Invoke it as a regular HTTP request by inserting the function invocation link in the browser address bar:

	```
	https://{{ sf-url }}/<function_ID>
	```

	The following response will appear on the page:

	```
	Hello, World!
	```


{% endlist %}