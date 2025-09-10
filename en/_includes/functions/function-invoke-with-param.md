## Invoke the function {#invoke}

{% note info %}

To allow any user to invoke your function, [make it public](../../functions/operations/function/function-public.md). For more information about access permissions, see [{#T}](../../functions/security/index.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select a function.
    1. Navigate to the ![CirclePlay](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** field, select `$latest` to invoke the latest function version.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}** field, select `{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}`.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** field, enter:
       ```
       {"queryStringParameters": {"name": "Username"}}
       ```
    1. Click ![PlayFill](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
    1. You will see the testing status under **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}** in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field. **Important**: Maximum function execution time before [timeout](../../functions/operations/function/version-manage.md) (including original initialization at first call) is 10 minutes.
    1. You will see the function execution result in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field:
       ```
       {
         "statusCode": 200,
         "headers": {
           "Content-Type": "text/plain"
         },
         "isBase64Encoded": false,
         "body": "Hello, Username!"
       }
       ```

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To invoke a function, run this command:

    ```
    yc serverless function invoke <function_ID> -d '{"queryStringParameters": {"name": "Username"}}'
    ```

    Result:

    ```
    {"statusCode":200,"headers":{"Content-Type":"text/plain"},"isBase64Encoded":false,"body":"Hello, Username!"}
    ```

    The function version with the `$latest` tag is invoked by default.

- HTTPS {#https}

	You can view the function invocation link on the **{{ ui-key.yacloud.common.overview }}** tab, in the **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** field.

	For security reasons, you can only invoke a function via HTTPS. Invoke it as a regular HTTP request by pasting the link into the browser address bar and adding the `name` parameter to the URL:

	```
	https://{{ sf-url }}/<function_ID>?name=Username
	```

	The following response will appear on the page:

	```
	Hello, Username!
	```


{% endlist %}