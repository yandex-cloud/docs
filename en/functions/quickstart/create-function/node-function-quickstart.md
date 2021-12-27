# Creating a function in Node.js

Create and execute a [function](../../concepts/function.md) in Node.js that welcomes the user.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Create a function {#create-func}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create a function.
    1. Open **{{ sf-name }}**.
    1. Click **Create function**.
    1. Enter a name for the function: `nodejs-function`.
    1. Click **Create**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function, run the command:

    ```
    yc serverless function create --name=nodejs-function
    ```

    Result:

    ```
    id: b09bhaokchn9pnbrlseb
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-14T10:03:37.475Z"
    name: nodejs-function
    log_group_id: eolm8aoq9vcppsieej6h
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
    status: ACTIVE
    ```

- API

    You can create a function using the [create](../../functions/api-ref/Function/create.md) API method.

- Yandex.Cloud Toolkit

    You can create a function using the [Yandex.Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Create the first version of the function {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Prepare a ZIP archive with the function code {#create-js-zip}

1. Save the following code to a file named `hello.js`:

    ```js
    exports.handler = async function (event, context) {
        name = event.queryStringParameters.name
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': false,
            'body': `Hello, ${name}!`
        }
    };
    ```

1. Add the `hello.js` file to the `hello-js.zip` archive.

### Create a function version {#create-version}

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where the function is located.
    1. Select **{{ sf-name }}**.
    1. Select `nodejs-function`.
    1. Under **Latest version**, click **Create in editor**.
    1. Set the version parameters:
        * **Runtime environment:** `nodejs12`.
        * **Method:** ZIP archive.
        * **File:** `hello-js.zip`.
        * **Entry point:** `hello.handler`.
        * **Timeout, seconds:** 3.
        * **RAM:** 128 MB.
        * **Service account:** Not selected.
    1. Click **Create version**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function version, run the command:

    ```
    yc serverless function version create \
    --function-name=nodejs-function \
    --runtime nodejs12 \
    --entrypoint hello.handler \
    --memory 128m \
    --execution-timeout 3s \
    --source-path ./hello-js.zip
    ```

    where:
    * `--function-name`: The name of the function you want to create a version of.
    * `--runtime`: The runtime environment.
    * `--entrypoint`: The entry point specified in <function file name>.<handler name> format.
    * `--memory`: The amount of RAM.
    * `--execution-timeout`: The maximum function execution time before the timeout is reached.
    * `--source-path`: ZIP archive with the function code and required dependencies.

    Result:

    ```
    done (1s)
    id: d4evvn8obisajd51plaq
    function_id: d4elpv8pft639ku7k0u6
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs12
    entrypoint: hello.handler
    resources:
        memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p40gmr9gn
    ```

- API

    You can create a function version using the [createVersion](../../functions/api-ref/Function/createVersion.md) API method.

- Yandex.Cloud Toolkit

    You can create a function version using the [Yandex.Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

{% include [function-invoke](../../../_includes/functions/function-invoke-with-param.md) %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}

