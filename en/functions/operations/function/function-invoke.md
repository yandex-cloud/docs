# Invoking a function

{% note info %}

To allow any user to invoke (call) a function, [make it public](../function-public.md). For more information about access rights, see [{#T}](../../security/index.md).

{% endnote %}

{% include [yc-function-list](../../../_includes/functions/function-list.md) %}

As an example, we use the function described in [{#T}](version-manage.md#func-version-create).

{% list tabs %}

- HTTP

    {% note info %}

    For security reasons, the function can only be called using TLS protocol.

    {% endnote %}

    Call the function as a regular HTTP request, such as by entering the function call link in your browser address bar. Call link format:

    ```
    {{ sf-url }}/<function ID>
    ```

    The function call link is also shown in the `http_invoke_url` parameter when [creating a function](function-create.md).

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

- CLI

    Call the function by specifying in the parameter a name for еру greeting:

    ```
    $ yc serverless function invoke b09bhaokchn9pnbrlseb -d '{"queryStringParameters": {"name": "Username"}}'
    
    {"statusCode": 200, "headers": {"Content-Type": "text/plain"}, "isBase64Encoded": false, "body": "Hello, Username!"}
    ```

{% endlist %}

For more information about the structure of functions called in different ways (HTTP or CLI), see [{#T}](../../concepts/function-invoke.md).

