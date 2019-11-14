# Creating an alias

Aliases are linked to specific devices. To create an alias, you need [the device ID or name](../device-list.md).

{% list tabs %}

- CLI

    {% include [cli-install](../../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

    Create an alias:

    ```
    $ yc iot device add-topic-aliases arenak5ciqss6pbas6js
    --topic-aliases commands='$devices/arenak5ciqss6pbas6js/commands'
    
    id: arenak5ciqss6pbas6js
    registry_id: arenou2oj4ct42eq8g3n
    created_at: "2019-09-16T12:32:48.911Z"
    name: second
    topic_aliases:
      commands: $devices/arenak5ciqss6pbas6js/commands
    ```

    You can also add an alias when [creating a device](../device-create.md). To do this, instead of a unique ID, specify the `{id}` in the device topic, since the unique ID is not yet known:

    ```
    $ yc iot device create 
    --registry-name <registry name> 
    --name <device name> 
    --topic-aliases <alias name>='$devices/{id}/<events or commands>'
    ```

{% endlist %}

