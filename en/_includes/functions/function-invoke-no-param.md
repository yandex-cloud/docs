## Invoke the function {#invoke}

{% note info %}

To allow any user to invoke your function, [make it public](../../functions/operations/function/function-public.md). For more information about access rights, see [{#T}](../../functions/security/index.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function.
   1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
   1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** field, specify `$latest` to invoke the latest function version.
   1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}** field, select `{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}`.
   1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
   1. You will see the testing status under **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}** in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field. **Important**: Maximum function execution time before [timeout](../../functions/operations/function/version-manage.md) (including original initialization at first call) is 10 minutes.
   1. You will see the function execution result in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To invoke a function, run the command:

   ```
   yc serverless function invoke <function_ID>
   ```

   The function version with the `$latest` tag is invoked by default.


- HTTPS {#https}

   You can view the function invocation link on the **{{ ui-key.yacloud.common.overview }}** tab, in the **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** field.

   For security reasons, you can only invoke a function via HTTPS. Invoke it as a regular HTTP request by inserting the function invocation link in the browser address bar:

   ```
   https://{{ sf-url }}/<function_ID>
   ```

   The following response will appear on the page:

   ```
   Hello, World!
   ```


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

   You can invoke a function using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}