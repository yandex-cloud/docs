# Creating a function in Python

Create and run a user welcome [function](../../concepts/function.md) in Python.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Create a function {#create-func}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Enter the function name: `python-function`.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function, run this command:

    ```bash
    yc serverless function create --name=python-function
    ```

    Result:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2023-08-16T19:01:37.475Z"
    name: python-function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
    status: ACTIVE
    ```

- API {#api}

    You can create a function using the [create](../../functions/api-ref/Function/create.md) API method.


{% endlist %}

## Create the first version of your function {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Create a ZIP archive with the function code {#create-zip}

1. Save the following code to a file named `hello.py`:
    ```python
    def handler(event, context):
        name = event['queryStringParameters']['name']

        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': False,
            'body': 'Hello, {}!'.format(name)
        }
    ```

1. Add `hello.py` to the `hello-py.zip` archive.

    {% include [macos-zip-error](../../../_includes/functions/macos-zip-error.md) %}

### Create a function version {#create-version}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the `python-function` function.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}**, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Select the `{{ python-full-ver }}` runtime.
    1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Configure the version:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: Attach `hello-py.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `hello.handler`.
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
      --function-name=python-function \
      --runtime {{ python-cli-ver }} \
      --entrypoint hello.handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-py.zip
    ```

    Where:

    * `--function-name`: Name of the function whose version you want to create.
    * `--runtime`: Runtime.
    * `--entrypoint`: Entry point in `<function_file_name>.<handler_name>` format.
    * `--memory`: Amount of RAM.
    * `--execution-timeout`: Maximum function execution time before timeout.
    * `--source-path`: ZIP archive with the function code and required dependencies.

    Result:

    ```text
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2023-08-16T19:09:19.531Z"
    runtime: {{ python-cli-ver }}
    entrypoint: hello.handler
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

    You can create a function version using the [createVersion](../../functions/api-ref/Function/createVersion.md) API method.


{% endlist %}

{% include [function-invoke](../../../_includes/functions/function-invoke-with-param.md) %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}