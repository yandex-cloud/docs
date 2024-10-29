# Creating a function in Bash

Create and execute a [function](../../concepts/function.md) in Bash that welcomes the user.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Create a function {#create-func}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Name the function `bash-function`.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function, run the command:

    ```
    yc serverless function create --name=bash-function
    ```

    Result:

    ```
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: bash-function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
    status: ACTIVE
    ```

- API {#api}

    You can create a function using the [create](../../functions/api-ref/Function/create.md) API method.


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    You can create a function using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}

## Create the first version of the function {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Prepare a ZIP archive with the function code {#create-zip}

1. Save the following code to a file named `hello.sh`:

   ```bash
   #!/bin/bash
   RESPONSE=$(echo '{"statusCode":200, "body":"Hello, World!"}' | jq '.')
   echo $RESPONSE | jq -c '.body |= tostring'
   ```

1. Add the `hello.sh` file to the `hello-sh.zip` archive.

### Create a function version {#create-version}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select `bash-function`.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}**, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Select the `bash` runtime environment and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Set the version parameters:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: Attach `hello-sh.zip`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `hello.sh`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `3`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function version, run the command:


    ```
    yc serverless function version create \
      --function-name=bash-function \
      --runtime bash \
      --entrypoint hello.sh \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-sh.zip
    ```
  
  
    Where:

    * `--function-name`: Name of the function you want to create a version of.
    * `--runtime`: Runtime environment.
    * `--entrypoint`: Entry point specified in the `<function_file_name>.<handler_name>` format.
    * `--memory`: Amount of RAM.
    * `--execution-timeout`: Maximum function execution time before the timeout is reached.
    * `--source-path`: ZIP archive with the function code and required dependencies.

    Result:


    ```
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: bash
    entrypoint: hello.sh
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


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    You can create a function version using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}

{% include [function-invoke](../../../_includes/functions/function-invoke-no-param.md) %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}