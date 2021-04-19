{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where the function is located.
    1. Open **{{ sf-name }}**.
    1. Go to the **Functions** tab.
    1. Select the function to get a list of versions for.
    1. Under **Version history**, you can find the list of function versions and their details.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To get a list of function versions, run the command:

    ```
    yc serverless function version list --function-name <function name>
    ```

    Result:

    ```
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT  |  TAGS   |     CREATED AT      |
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    | b09u830mb1n32a7rj0n8 | b097d9ous3gep99khe83 | python37 | test.handler | $latest | 2019-06-13 09:23:23 |
    | b09ch6pmpohfc9sogj5f | b097d9ous3gep99khe83 | python37 | test.handler | beta    | 2019-06-13 09:12:38 |
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    ```

- API

    You can get a list of function versions using the [listVersions](../../functions/functions/api-ref/Function/listVersions.md) API method.

{% endlist %}

