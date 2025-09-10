# Creating a function in Kotlin

Create and run a user welcome [function](../../concepts/function.md) in Kotlin.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Create a function {#create-func}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Enter the function name: `kotlin-function`.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function, run the command:

    ```bash
    yc serverless function create --name=kotlin-function
    ```

    Result:

    ```text
    id: d4eek526ai42********
    folder_id: b1gt6g8ht345********
    created_at: "2024-12-19T20:02:56.039Z"
    name: kotlin-function
    http_invoke_url: https://{{ sf-url }}/d4eek526ai42********
    status: ACTIVE
    ```

- API {#api}

    You can create a function using the [create](../../functions/api-ref/Function/create.md).


{% endlist %}

## Create the first version of the function {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Prepare a ZIP archive with the function code {#create-zip}

1. Save the following code to a file named `Handler.kt`:

    ```kotlin
    data class Request(
        val httpMethod: String?,
        val headers: Map<String, String> = mapOf(),
        val body: String = ""
    )

    data class Response(
        val statusCode: Int,
        val body: String
    )

    fun handle(request: Request): Response {
        return Response(200, "Hello World!")
    }
    ```

1. Add `Handler.kt` to the `hello-kotlin.zip` archive.

### Create a function version {#create-version}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the `kotlin-function` function.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}**, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Select the `{{ kotlin-full-ver }}` runtime environment.
    1. Disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Set the version parameters:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: Attach `hello-kotlin.zip`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `Handler`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `3`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function version, run the command:

    ```bash
    yc serverless function version create \
      --function-name=kotlin-function \
      --runtime {{ kotlin-cli-ver }} \
      --entrypoint Handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-kotlin.zip
    ```

    Where:

    * `--function-name`: Name of the function whose version you want to create.
    * `--runtime`: Runtime environment.
    * `--entrypoint`: Entry point in `<function_file_name>.<handler_name>` format.
    * `--memory`: Amount of RAM.
    * `--execution-timeout`: Maximum function running time before timeout.
    * `--source-path`: ZIP archive with the function code and required dependencies.

    Result:

    ```text
    done (10s)
    id: d4ektme8jo2d********
    function_id: d4e9arrf01oh********
    created_at: "2024-12-19T20:22:15.942Z"
    runtime: {{ kotlin-cli-ver }}
    entrypoint: Handler
    resources:
      memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
      - $latest
    log_options:
      folder_id: b1gt6g8ht345********
    concurrency: "1"
    ```

- API {#api}

    You can create a function version using the [createVersion](../../functions/api-ref/Function/createVersion.md).


{% endlist %}

## Invoke the function {#invoke}

{% note info %}

To allow any user to invoke your function, [make it public](../../operations/function/function-public.md). For more information about access rights, see [{#T}](../../security/index.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select a function.
    1. Navigate to the ![CirclePlay](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** field, specify `$latest` to invoke the latest function version.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}** field, select `{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}`.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** field, enter:

       ```
       {}
       ```
    1. Click ![PlayFill](../../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
    1. You will see the testing status under **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}** in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field. **Important**: Maximum function execution time before [timeout](../../operations/function/version-manage.md) (including original initialization at first invocation) is 10 minutes.
    1. You will see the function execution result in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field:

       ```
       {
           "statusCode": 200,
           "body": "Hello World!"
       }
       ```

- CLI {#cli}

    To invoke a function, run this command:

    ```
    yc serverless function invoke <function_ID> -d '{}'
    ```

    Result:

    ```
    {"statusCode":200,"body":"Hello World!"}
    ```

    The function version with the `$latest` tag is invoked by default.

- HTTPS {#https}

    You can view the function invocation link on the **{{ ui-key.yacloud.common.overview }}** tab, in the **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** field.

    For security reasons, you can only invoke a function via HTTPS. Invoke it as a regular HTTP request by pasting the link into the browser address bar and adding the `name` parameter to the URL:

    ```
    https://{{ sf-url }}/<function_ID>
    ```

    The following response will appear on the page:

    ```
    Hello World!
    ```


{% endlist %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}