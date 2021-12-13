{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of functions.
    1. Open **{{ sf-name }}**.
    1. Go to the **Functions** tab.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To get a list of functions, run the command:

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

    You can get a list of functions using the [list](../../functions/functions/api-ref/Function/list.md) API method.

- Yandex.Cloud Toolkit

    You can get a list of functions using the [Yandex.Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

