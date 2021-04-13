# Managing function versions

With function versioning, you can:

- [Create a version](version-manage.md#func-version-create).
- [Get information about a function version](version-manage.md#version-info).
    - [Get a list of function versions](version-manage.md#version-list).
    - [Get detailed information about a function version](version-manage.md#version-get).
- [Add environment variables](version-manage.md#version-env).
- [Manage version tags](version-manage.md#manage-tags).

You can change the function code using the [Code editor](function-editor.md).

{% note info %}

To ensure the integrity of version links, you can't update or delete function versions. For more information about relationships between resources, see [{#T}](../../concepts/function.md).

{% endnote %}

## Getting a list of functions {#function-list}

For function versioning, you need to know the name or unique ID of the function that the version belongs to. To find them, get a list of functions.

{% include [function-list](../../../_includes/functions/function-list.md) %}

## Creating a function version {#func-version-create}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Preparing a ZIP archive with the function code {#zip-archive}

{% include [create-js-zip](../../../_includes/functions/create-js-zip.md) %}

### Creating a function version {#version-create}

When creating a version, set the following parameters:

- _Runtime environment_: Provides additional libraries and environment variables that can be accessed from the function code. It corresponds to the programming language that your function is written in.
- _Entry point_: The function to be invoked as a handler. To read more about the handler, see [Programming model](../../concepts/function.md#programming-model).
- _Timeout_: The maximum function execution time, after which the service will terminate its execution without waiting for a response. It includes the time of the first initialization when the function is first run.

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where the function is located.
    1. Open **{{ sf-name }}**.
    1. Select the function to create a version of.
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

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function version, run the command:

    ```
    yc serverless function version create \
    --function-name=my-nodejs-function \
    --runtime nodejs12 \
    --entrypoint index.handler \
    --memory 128m \
    --execution-timeout 5s \
    --source-path ./hello-js.zip
    ```

    where:

    `--function-name`: The function you want to create a version of.
`--runtime`: The runtime environment.
`--entrypoint`: The entry point specified in <function file name>.<handler name> format.
`--memory`: The amount of RAM.
`--execution-timeout`: The maximum function execution time before the timeout is reached.
`--source-path`: ZIP archive with the function code and required dependencies.

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

- API

    You can create a function version using the [createVersion](../../functions/api-ref/Function/createVersion.md) API method.

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
    1. In the [management console]({{ link-console-main }}), go to the folder where the function is located.
    1. Open **{{ sf-name }}**.
    1. Select the function whose version you want to add an environment variable for.
    1. Go to the **Editor** tab.
    1. In the window that opens, under **Parameters**, specify the environment variable and click **Add environment variable**. You can add multiple environment variables.
    1. Click **Create version**. A new version of the function with the specified environment variables is created.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To add environment variables, run the command:

    {% note warning %}

    If the previous version contained environment variables, this command overwrites them.

    {% endnote %}

    ```
    yc serverless function version create \
    --function-name=<function name> \
    --runtime <runtime environment> \
    --entrypoint <entry point> \
    --memory 128m \
    --execution-timeout 5s \
    --source-version-id <version ID> \
    --environment <environment variables>
    ```

    where:

    `--function-name`: The function name.
`--runtime`: The runtime environment.
`--entrypoint`: The entry point specified in <function file name>.<handler name> format.
`--memory`: The amount of RAM.
`--execution-timeout`: The maximum function execution time before the timeout is reached.
`--source-version-id`: The ID of the function version to copy the code of.
`--environment`: Environment variables in key=value format. You can specify multiple pairs separated by commas.

- API

    You can add environment variables using the [createVersion](../../functions/api-ref/Function/createVersion.md) API method.

{% end list %}

## Managing version tags {#manage-tags}

When a new version is created, it is assigned the default [tag](../../concepts/function.md#) (`$latest`). You can [add](version-manage.md#set-tag) and [remove](version-manage.md#remove-tag) version tags.

To access the function version, use its unique ID. For information about how to find the unique version ID, see [Getting a list of function versions](version-manage.md#version-list).

### Adding a tag {#set-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To add a version tag, run the command:

    ```
    yc serverless function version set-tag --id <version ID> --tag <tag>
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

- API

    You can add a tag using the [setTag](../../functions/api-ref/Function/setTag.md) API method.

{% endlist %}

### Removing a tag {#remove-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To remove a version tag, run the command:

    ```
    yc serverless function version remove-tag --id <version ID> --tag <tag>
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

- API

    You can remove a tag using the [removeTag](../../functions/api-ref/Function/removeTag.md) API method.

{% endlist %}

