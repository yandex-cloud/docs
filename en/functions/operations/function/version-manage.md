# Managing function versions

With function versioning, you can:

- [Create a version](version-manage.md#func-version-create).
- [Get information about a function version](version-manage.md#version-info).
    - [Get a list of function versions](version-manage.md#version-list).
    - [Get detailed information about a function version](version-manage.md#version-get).
- [Manage version tags](function-update.md#manage-tags).

You can change the function code using the [Code editor](function-editor.md).

{% note info %}

To ensure the integrity of version links, you can't update or delete function versions. For more information about relationships between resources, see [{#T}](../../concepts/function.md).

{% endnote %}

## Getting a list of functions {#function-list}

For function versioning, you need to know the name or unique ID of the function that the version belongs to. To find them out, get a list of functions.

{% include [function-list](../../../_includes/functions/function-list.md) %}

## Creating a function version {#func-version-create}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Preparing a ZIP archive with the function code {#zip-archive}

1. Save the following code to a file named `index.js`:

    ```
    exports.handler = async function (event, context) {
        let name = 'World';
        if (event.queryStringParameters && event.queryStringParameters.name) {
            name = event.queryStringParameters.name
        }
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

1. Add `index.js` to the `hello-js.zip` archive.

### Creating a function version {#version-create}

When creating a version, set the following parameters:

- _Runtime environment_: Provides additional libraries and environment variables that can be accessed from the function code. It corresponds to the programming language that your function is written in.
- _Entry point_: The name of the function to be called as a handler. To read more about the handler, see [Programming model](../../concepts/function.md#programming-model).
- _Timeout_: The maximum function execution time, after which the service will terminate its execution without waiting for a response. It includes the time of the first initialization when the function is first run.

{% list tabs %}

- Management console

    Create the function version:
    1. Open **{{ sf-name }}** in the folder where you want to create the function version.
    1. Select the function to create the version for.
    1. Under **Latest version**, click **Create in editor**.
    1. Set the version parameters:
       - Runtime environment: `nodejs`.
       - Timeout: 5 sec.
       - RAM: 128 MB.
       - Service account: None selected.
    1. Prepare the function code:
       - Method: ZIP archive.
       - File: `hello-js.zip`.
       - Entry point: `index.handler`.
    1. Click **Create version**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Create the function version:

    ```
    $ yc serverless function version create \
    --function-name=my-nodejs-function \ # Function name.
    --runtime nodejs12 \ # Runtime environment.
    --entrypoint index.handler \ The handler, specified in <function file name>.<handler name> format.
    --memory 128m \ # Amount of RAM.
    --execution-timeout 5s \ # The maximum function execution time before the timeout is reached.
    --source-path ./hello-js.zip # ZIP archive with the function code and all required dependencies.
    ```

    Result:

    ```
    done (1s)
    id: d4evvn8obisajd51plaq
    function_id: d4elpv8pft639ku7k0u6
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs12
    entrypoint: index.handler
    resources:
    memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p40gmr9gn
    ```

{% endlist %}

## Getting information about a function version {#version-info}

### Getting a list of function versions {#version-list}

{% include [version-list](../../../_includes/functions/version-list.md) %}

### Getting detailed information about a function version {#version-get}

{% include [version-get](../../../_includes/functions/version-get.md) %}

## Adding environment variables {#version-env}

When you add environment variables, a new version of the function is created. You can't add variables to an existing version.

{% list tabs %}

- Management console
    1. Select **{{ sf-name }}** in [management console]({{ link-console-main }}).
    1. Click ![image](../../../_assets/vertical-ellipsis.svg) in the row of the function whose version you want to add an environment variable for.
    1. Open the **Editor** section.
    1. In the window that opens, under **Parameters**, add an environment variable in the **Environment variables** field and click **Add environment variable**. You can add multiple variables.
    1. Click **Create version** in the upper-right corner. A new version of the function with the specified environment variables is created.

- CLI

    Run the command:

    ```
    $ yc serverless function version create \
    --function-name=<function name> \ # Name of the function.
    --runtime <runtime environment> \ # Runtime environment.
    --entrypoint <handler> \ # The handler specified in <function file name>.<handler name> format.
    --memory 128m \ # Amount of RAM.
    --execution-timeout 5s \ # The maximum function execution time before the timeout is reached.
    --source-version-id <version ID> \ # ID of the version to copy executable code from.
    --environment <environment variables> # Environment variables in key=value format. You can specify multiple pairs separated by commas.
    ```

    If the previous version contained environment variables, this command overwrites them.

{% end list %}

## Managing version tags {#manage-tags}

When a new version is created, it is assigned the default [tag](../../concepts/function.md#) (`$latest`). You can [add](version-manage.md#set-tag) and [remove](version-manage.md#remove-tag) version tags.

To access the function version, use its unique ID. For information about how to find the unique version ID, see [Getting a list of function versions](version-manage.md#version-list).

### Adding a tag {#set-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Add a version tag:

    ```
    $ yc serverless function version set-tag --id <version ID> --tag <tag>
    ```

    Result:

    ```
    id: b09ch6pmpohfc9sogj5f
    function_id: b097d9ous3gep99khe83
    created_at: "2019-06-13T09:12:38.464Z"
    runtime: python37
    entrypoint: test.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - beta
    - first
    log_group_id: eolv6578frac08uh5h6s
    ```

{% endlist %}

### Removing a tag {#remove-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Remove a version tag:

    ```
    $ yc serverless function version remove-tag --id <version ID> --tag <tag>
    ```

    Result:

    ```
    id: b09ch6pmpohfc9sogj5f
    function_id: b097d9ous3gep99khe83
    created_at: "2019-06-13T09:12:38.464Z"
    runtime: python37
    entrypoint: test.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - beta
    log_group_id: eolv6578frac08uh5h6s
    ```

{% endlist %}

