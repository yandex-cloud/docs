# Invoking a function

{% note info %}

To allow any user to invoke (call) a function, [make it public](../function-public.md). For more information about rights, see [{#T}](../../security/index.md).

{% endnote %}

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Invoking a function {#invoking-function}

As an example, we'll use the function described in [{#T}](version-manage.md#func-version-create).

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where the function is located.
    1. Select **{{ sf-name }}**.
    1. Select a function.
    1. Go to the **Testing** tab.
    1. In the **Tag version** field, specify which function version to invoke.
    1. Under **Payload template**, choose one of the options:
        - **Without preset**: Custom data format.
        - **HTTP call**: HTTP call data format for a function acting as an HTTP request handler.
        - **Trigger for {{message-queue-short-name}}**: Data format for the function invoked by a trigger in order to process messages from the queue.
    1. In the **Input** field, enter the input data to test the function.
    1. Click **Run test**.
    1. You will see the testing status under **Test result** in the **Function status** field. **Important**: The maximum function execution time before [timeout](../../operations/function/version-manage.md#version-create) (including original initialization at initial launch) is 10 minutes.
    1. You will see the function execution result in the **Function output** field.

- HTTPS

    {% note info %}

    To invoke a private function via HTTPS, you must [authenticate](#auth).

    {% endnote %}

    You can find the function invocation link in:
    * The **Link to invoke** field. To do this, in [management console]({{ link-console-main }}), open **{{ sf-name }}** and select the function.
    * The `http_invoke_url` parameter. To do this, run the command:

        ```
        yc serverless function get <function name>
        ```

    For security reasons, you can only invoke the function via HTTPS. Invoke it as a regular HTTP request by inserting the function invoke link in the browser address bar. Link format:

    ```
    {{ sf-url }}/<function ID>
    ```

    You can invoke a specific function version using the `tag` parameter. The function with the `$latest` tag is invoked by default.

    - Example of function invocation with no additional parameters:

        ```
        {{ sf-url }}/b09bhaokchn9pnbrlseb
        ```

        The following response appears on the page:

        ```
        Hello, World!
        ```

    - Example of function invocation with the `name` parameter added to the URL:

        ```
        {{ sf-url }}/b09bhaokchn9pnbrlseb?name=<user name>
        ```

        The following response appears on the page:

        ```
        Hello, Username!
        ```

    - Example of invoking a specific function version with the `tag` parameter added to the URL:

        ```
        {{ sf-url }}/b09bhaokchn9pnbrlseb?tag=<version tag>
        ```

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    You can invoke a specific function version using the `--tag` parameter. The function with the `$latest` tag is invoked by default.

    - Invoke the function by specifying in the parameter a name for the greeting:

        ```
        yc serverless function invoke <function ID> -d '{"queryStringParameters": {"name": "Username"}}'
        ```

        Result:

        ```
        {"statusCode": 200, "headers": {"Content-Type": "text/plain"}, "isBase64Encoded": false, "body": "Hello, Username!"}
        ```

    - Invoke a specific version of the function using the `--tag` parameter:

        ```
        yc serverless function invoke <function ID> --tag <function version tag>
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

