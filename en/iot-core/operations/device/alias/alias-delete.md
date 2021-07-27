---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Deleting an alias

Aliases are linked to specific devices. To delete an alias, you need [the device ID or name](../device-list.md).

{% list tabs %}

- Management console

   To delete an alias:
   1. In the [management console]({{ link-console-main }}), select the folder to delete the alias from.
   1. Select **{{ iot-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. To the right of the device name, click ![image](../../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. To the right of the alias to delete, click ![image](../../../../_assets/cross.svg).
   1. Click **Save**.

- CLI

    {% include [cli-install](../../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

    Delete an alias:

    ```
    $ yc iot device remove-topic-aliases arenak5ciqss6pbas6js --topic-aliases commands
    id: arenak5ciqss6pbas6js
    registry_id: arenou2oj4ct42eq8g3n
    created_at: "2019-09-16T12:32:48.911Z"
    name: second
    ```

{% endlist %}