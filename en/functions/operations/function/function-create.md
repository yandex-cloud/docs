# Creating a function

{% list tabs %}

- Management console

    1. In the management console, select the folder to create your function in.

    1. Click **Create resource**.

    1. Choose **Function**.

    1. Enter a function name.

        {% include [name-format](../../../_includes/name-format.md) %}

    1. Click **Create**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Create a function:

    ```
    $ yc serverless function create --name=my-python-function
    .done
    id: b09bhaokchn9pnbrlseb
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-14T10:03:37.475Z"
    name: my-python-function
    log_group_id: eolm8aoq9vcppsieej6h
    http_invoke_url: https://functions.cloud-preprod.yandex.net/b09bhaokchn9pnbrlseb
    ```

{% endlist %}

