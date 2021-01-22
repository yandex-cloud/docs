# Invoking a function

{% note info %}

To allow any user to invoke (call) a function, [make it public](../function-public.md). For more information about rights, see [{#T}](../../security/index.md).

{% endnote %}

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Invoking a function {#invoking-function}

As an example, we'll use the function described in [{#T}](version-manage.md#func-version-create).

{% list tabs %}

- Management console

    Invoke the function:
    1. Select **{{ sf-name }}** in [management console]({{ link-console-main }}).
    1. Click ![image](../../../_assets/vertical-ellipsis.svg) in the row of the function you want to invoke.
    1. In the window that opens, go to **Testing**.
    1. In the **Tag version** field, specify which function version to invoke.
    1. Under **Payload template**, choose one of the options:
        - **Without preset**: Custom data format.
        - **HTTP call**: HTTP call data format for a function acting as an HTTP request handler.
        - **Trigger for {{message-queue-short-name}}**: Data format for the function called by a trigger in order to process messages from the queue.
    1. In the **Input** field, enter the input data to test the function.
    1. Click **Run test**.
    1. You will see the testing status under **Test result** in the **Function status** field. **Important**: The maximum function execution time before [timeout](../../operations/function/version-manage.md#version-create) (including original initialization at first call) is 10 minutes.
    1. You will see the data processed by the function in the **Function output** field.

- HTTP

    {% note info %}

    For security reasons, the function can only be called using TLS protocol.

    {% endnote %}

    Call the function as a regular HTTP request, such as by entering the function call link in your browser address bar. Call link format:

    ```
    {{ sf-url }}/<function ID>
    ```

    The function call link is also shown in the `http_invoke_url` parameter when [creating a function](function-create.md).

    You can call a specific function version using the `tag` parameter. The function with the `$latest` tag is called by default.

    - Example of function call with no additional parameters:

        ```
        {{ sf-url }}/b09bhaokchn9pnbrlseb
        ```

        The response depends on the function you call. In this case, it will be as follows:

        ```
        Hello, World!
        ```

    - Example of function call with the `name` parameter added to the URL:

        ```
        {{ sf-url }}/b09bhaokchn9pnbrlseb?name=<user name>
        ```

        The following response appears on the page:

        ```
        Hello, Username!
        ```

    - Example of calling a specific function version with the `tag` parameter added to the URL:

        ```
        {{ sf-url }}/b09bhaokchn9pnbrlseb?tag=<version tag>
        ```

- CLI

    You can call a specific function version using the `--tag` parameter. The function with the `$latest` tag is called by default.

    - Call the function by specifying in the parameter a name for еру greeting:

        ```
        $ yc serverless function invoke <function ID> -d '{"queryStringParameters": {"name": "Username"}}'
        ```

        Result:

        ```
        {"statusCode": 200, "headers": {"Content-Type": "text/plain"}, "isBase64Encoded": false, "body": "Hello, Username!"}
        ```

    - Use a tag to call a specific function version:

        ```
        $ yc serverless function invoke <function ID> --tag <function version tag>
        ```

{% endlist %}

To learn more about function structure dependence for different invocation methods (HTTP and CLI), see [{#T}](../../concepts/function-invoke.md).

## Authentication when invoking a private function via HTTP {#auth}

To invoke a private function via HTTP, you must authenticate. To do this, get:

* [IAM token](../../../iam/concepts/authorization/iam-token.md):
    * [Instructions](../../../iam/operations/iam-token/create.md) for a Yandex account.
    * [Instructions](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
    * [Instructions](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.

    Pass the obtained IAM token in the `Authorization` header using the following format:

    ```
    Authorization: Bearer <IAM-TOKEN>
    ```

    IAM tokens are valid for 12 hours maximum.

* [API key](../../../iam/operations/api-key/create) for the service account.

    Pass the obtained API key in the `Authorization` header using the following format:

    ```
    Authorization: Api-Key <API key>
    ```

    API keys do not expire. This means that this authentication method is simpler, but less secure. Use it if you can't request an IAM token automatically.

