# Managing function versions

For function versioning, you need to know the name or unique ID of the function that the version belongs to.

{% include [yc-function-list](../../../_includes/functions/function-list.md) %}

With function versioning, you can:

- [Create a version](version-manage.md#func-version-create)
- [Get information about a function version](version-manage.md#info)
    - [Get a list of function versions](version-manage.md#version-list)
    - [Get detailed information about a function's version](version-manage.md#version-get)
- [Manage version tags](function-update.md#manage-tags)

{% note info %}

To ensure the integrity of version links, you can't update or delete function versions. For more information about resource relationships, see [{#T}](../../concepts/function.md).

{% endnote %}

## Creating a function version {#func-version-create}

To create a [version](../../concepts/function.md#version) of a function, you need a ZIP archive with the function and all required dependencies.

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
- _Entry point_: The name of the function to be called as a handler. For more information about handlers, see [Programming model](../../concepts/function.md#programming-model).
- _Timeout_: The maximum function execution time, after which the service will terminate its execution without waiting for a response. It includes the time of the first initialization when the function is first run.

{% list tabs %}

- Management console
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
  --runtime nodejs10 \ # Runtime environment.
  --entrypoint index.handler \ The handler, specified in <function file name>.<handler name> format.
  --memory 128m \ # Amount of RAM. 
  --execution-timeout 5s \ # The maximum function execution time before the timeout is reached.
  --source-path ./hello-js.zip # ZIP archive with the function code and all required dependencies.
  ```

{% endlist %}

## Getting information about a function version {#version-info}

### Getting a list of function versions {#version-list}

{% list tabs %}

- Management console
    1. Open **{{ sf-name }}** in the folder containing the function that you need to get the list of versions for.
    1. Select the function to get a list of versions for.
    1. Under **Version history**, you can find the list of function versions and their details.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    ```
    $ yc serverless function version list --function-name my-beta-function
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT  |  TAGS   |     CREATED AT      |
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    | b09u830mb1n32a7rj0n8 | b097d9ous3gep99khe83 | python37 | test.handler | $latest | 2019-06-13 09:23:23 |
    | b09ch6pmpohfc9sogj5f | b097d9ous3gep99khe83 | python37 | test.handler | beta    | 2019-06-13 09:12:38 |
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    ```

{% endlist %}

### Getting detailed information about a function version {#version-get}

{% list tabs %}

- Management console
    1. Open **{{ sf-name }}** in the folder containing the function that you need to get the list of versions for.
    1. Select the function to get a list of versions for.
    1. Under **Version history**, you can find the list of function versions and their details.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    To access the version, use the `ID` or `TAGS` parameters from the [previous](version-manage.md#version-list) section.

    - Get details of a version using its **unique ID**:

        ```
        $ yc serverless function version get b09u830mb1n32a7rj0n8
        
        id: b09u830mb1n32a7rj0n8
        function_id: b097d9ous3gep99khe83
        description: test2
        created_at: "2019-06-13T09:23:23.383Z"
        runtime: python37
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - $latest
        log_group_id: eolv6578frac08uh5h6s
        

    - Get details of a version using its **tag**:

        ````
        $ yc serverless function version get-by-tag --function-name my-beta-function --tag beta
        
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

## Managing version tags {#manage-tags}

When creating a new version, it's assigned the default `$latest` [tag](../../concepts/function.md#). You can [add](version-manage.md#set-tag) and [remove](version-manage.md#remove-tag) version tags.

To access the function version, use its unique ID. For information about how to find the unique version ID, see [Getting a list of function versions](version-manage.md#version-list).

### Adding a tag {#set-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Add a version tag:

    ```
    $ yc serverless function version set-tag --id b09ch6pmpohfc9sogj5f --tag first
    
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
    $ yc serverless function version remove-tag --id b09ch6pmpohfc9sogj5f --tag first
    
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

