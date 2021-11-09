# Deleting a group

{% note info %}

Name of the [default log group](../concepts/log-group.md): `default`. The group can be deleted. However, if a service or application writes logs and the folder ID is indicated as the destination, the group will be automatically re-created.

{% endnote %}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder to delete a [log group](../concepts/log-group.md) from.
    1. Open **{{ cloud-logging-name }}**.
    1. In the line with the log group, click ![image](../../_assets/horizontal-ellipsis.svg).
    1. In the menu that opens, click **Delete**.
    1. In the window that opens, click **Delete**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To access a log group, use its name or unique ID. To find them, [get](./list.md) a list of log groups in the folder.

    To delete a log group, run the command:

    ```
    yc logging group delete --name=group
    ```

    Result:

    ```
    done (1s)
    id: af3flf29t8**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2021-06-24T09:56:38.970Z"
    name: group
    status: ACTIVE
    retention_period: 3600s
    ```

- API

    You can delete a custom log group using the [delete](../api-ref/LogGroup/delete.md) API method.

{% endlist %}
