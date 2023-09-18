{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of functions.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/functions.svg) **Functions**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

    To get a list of functions, run the following command:

    ```
    yc serverless function list
    ```

   Result:

   ```
    +----------------------+--------------------+----------------------+--------+
    |          ID          |        NAME        |      FOLDER ID       | STATUS |
    +----------------------+--------------------+----------------------+--------+
    | b097d9ous3gep99khe83 | my-beta-function   | aoek49ghmknnpj1ll45e | ACTIVE |
    +----------------------+--------------------+----------------------+--------+
    ```

- API

   To get a list of functions, use the [list](../../functions/functions/api-ref/Function/list.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionsService/List](../../functions/functions/api-ref/grpc/function_service.md#List) gRPC API call.


- {{ yandex-cloud }} Toolkit

   You can get a list of versions using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}
