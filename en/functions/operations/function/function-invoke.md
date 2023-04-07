---
title: "How to invoke a function in {{ sf-full-name }}"
description: "In this tutorial, you will learn how to invoke functions in {{ sf-full-name }}."
---

# Invoking a function

To allow any user to invoke a function without passing an authorization header, [make it public](./function-public.md). For more information about access rights, see [{#T}](../../security/index.md).

## Invoking a function {#invoking-function}

As an example, we use the function described in [{#T}](../function/version-manage.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.

   1. Select **{{ sf-name }}**.

   1. Select a function.

   1. Go to the **Testing** tab.

   1. In the **Tag version** field, specify which function version to invoke.

   1. Under **Payload template**, choose one of the options:

      * **Without preset**: Custom data format.
      * **HTTPS call**: Data format for a function acting as an HTTPS request handler. For more information, see [Concepts](../../concepts/function-invoke.md).
      * **Trigger for {{ message-queue-short-name }}**: Data format for the function invoked by a trigger in order to process messages from the queue.
      * **Alice's skill**: Data format for a function receiving [requests](https://yandex.ru/dev/dialogs/alice/doc/request.html) from the Yandex.Dialogs platform.

   1. In the **Input field**, enter the input data to test the function.

   1. Click **Run test**.

   1. You will see the testing status under **Test result** in the **Function status** field. **Important**: Maximum function execution time before [timeout](../../operations/function/version-manage.md) (including original initialization at first call) is 10 minutes.

   1. You will see the function execution result in the **Function output** field.

- HTTPS

   You can find the function invocation link in:
   * The **Link to invoke** field. To do this, in the [management console]({{ link-console-main }}), select **{{ sf-name }}** and click the line with the desired function.
   * The `http_invoke_url` parameter. To do this, run the command:
      ```
      yc serverless function get <function name>
      ```

   {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

   For security reasons, you can only invoke the function via HTTPS. Invoke it as a regular HTTP request by inserting the function invoke link in the browser address bar. The link should have the following format:

   ```
   {{ sf-url }}/<function ID>
   ```

   You can invoke a specific function version using the `tag` parameter. The function with the `$latest` tag is invoked by default.

   * Example of function invocation with no additional parameters:

      ```
      {{ sf-url }}/b09bhaokchn9pnbrlseb
      ```

      The following response appears on the page:

      ```
      Hello, World!
      ```

   * Example of function invocation with the `name` parameter added to the URL:

      ```
      {{ sf-url }}/b09bhaokchn9pnbrlseb?name=<username>
      ```

      The following response appears on the page:

      ```
      Hello, Username!
      ```
   * Example of invoking a specific function version with the `tag` parameter added to the URL:

      ```
      {{ sf-url }}/b09bhaokchn9pnbrlseb?tag=<version tag>
      ```

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   You can invoke a specific function version using the `--tag` parameter. The function with the `$latest` tag is invoked by default.

   {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

   * Invoke the function by specifying in the parameter a name for the greeting:

      ```
      yc serverless function invoke <function ID> -d '{"queryStringParameters": {"name": "Username"}}'
      ```

      Result:

      ```
      {"statusCode": 200, "headers": {"Content-Type": "text/plain"}, "isBase64Encoded": false, "body": "Hello, Username!"}
      ```
   * Invoke a specific version of the function using the `--tag` parameter:

      ```
      yc serverless function invoke <function ID> --tag <function version tag>
      ```

- {{ yandex-cloud }} Toolkit

   You can call a function using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).

{% endlist %}

For more information about the structure of functions called in different ways (HTTPS or CLI), see [{#T}](../../concepts/function-invoke.md).