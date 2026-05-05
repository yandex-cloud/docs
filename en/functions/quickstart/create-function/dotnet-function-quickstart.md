# Creating a function in .NET Core

Create and run a user welcome [function](../../concepts/function.md) in .NET Core.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Create a function {#create-func}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your function.
    1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Enter the function name: `dotnet-function`.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function, run this command:

    ```bash
    yc serverless function create --name=dotnet-function
    ```

    Result:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: dotnet-function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
    status: ACTIVE
    ```

- API {#api}

    You can create a function using the [create](../../functions/api-ref/Function/create.md).


{% endlist %}

## Create the first version of the function {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Prepare a ZIP archive with the function code {#create-zip}

1. Save the following code to a file named `Handler.cs`:

    ```csharp
    using System;
    using System.Collections.Generic;

    namespace Function;

    public class Request
    {
        public Dictionary<string, string> queryStringParameters { get; set; }
    }

    public class Response
    {
        public Response(int statusCode, Dictionary<string, string> headers, bool isBase64Encoded, string body)
        {
            StatusCode = statusCode;
            Headers = headers;
            IsBase64Encoded = isBase64Encoded;
            Body = body;
        }

        public int StatusCode { get; set; }
        public Dictionary<string, string> Headers { get; set; }
        public bool IsBase64Encoded { get; set; }
        public string Body { get; set; }
    }

    public class Handler
    {
        public Response FunctionHandler(Request request)
        {
            var headers = new Dictionary<string, string>();
            headers.Add("Content-Type", "text/plain");

            string name = request.queryStringParameters["name"];
            return new Response(200, headers, false, string.Format("Hello, {0}!", name));
        }
    }
    ```

1. Add `Handler.cs` to the `hello-dotnet.zip` archive.

    {% include [macos-zip-error](../../../_includes/functions/macos-zip-error.md) %}

### Create a function version {#create-version}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select `dotnet-function`.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}**, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Select the `.NET 8.0` runtime environment.
    1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Configure the version:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: Attach `hello-dotnet.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `Function.Handler`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `3`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function version, run this command:

    ```bash
    yc serverless function version create \
      --function-name=dotnet-function \
      --runtime dotnet8.0 \
      --entrypoint Function.Handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-dotnet.zip
    ```

    Where:

    * `--function-name`: Name of the function whose version you want to create.
    * `--runtime`: Runtime environment.
    * `--entrypoint`: Entry point.
    * `--memory`: Amount of RAM.
    * `--execution-timeout`: Maximum function execution time before timeout.
    * `--source-path`: ZIP archive with the function code and required dependencies.

    Result:

    ```text
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: dotnet8.0
    entrypoint: Function.Handler
    resources:
        memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p********
    ```

- API {#api}

    You can create a function version using the [createVersion](../../functions/api-ref/Function/createVersion.md).


{% endlist %}

{% include [function-invoke](../../../_includes/functions/function-invoke-with-param.md) %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}
