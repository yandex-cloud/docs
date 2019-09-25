# Deleting a function

{% include [yc-function-list](../../_includes/functions/function-list.md) %}

{% list tabs %}

- Management console

    To delete a [function](../concepts/function.md):
    1. Open the **{{ sf-name }}** section in the folder where you want to delete the function.
    1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of the function you want to delete.
    1. In the menu that opens, click **Delete**.
    1. In the window that opens, click **Delete**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    Delete the function:

    ```
    $ yc serverless function delete my-functions
    
    id: b09kk2ujb8js23f73b06
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-13T13:21:40.022Z"
    name: my-functions
    log_group_id: eolq9ac97486t34iut5q
    http_invoke_url: https://functions.cloud-preprod.yandex.net/b09kk2ujb8js23f73b06
    ```

{% endlist %}

