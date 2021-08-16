# Creating an alias

Aliases are linked to specific devices. To create an alias, you need [the device ID or name](../device-list.md).

{% include [monitoring-topic](../../../../_includes/iot-core/monitoring-topic.md) %}

{% list tabs %}

- Management console

   To create an alias:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alias.
   1. Select **{{ iot-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. Click ![image](../../../../_assets/horizontal-ellipsis.svg) to the right of the appropriate device name and select **Edit** from the drop-down list.
   1. Add an alias:
      1. Click **Add alias**.
      1. Fill in the fields: enter an alias (for example, `events`) and the topic type after `$devices/<deviceID>` (for example, `events`).<br/>You can use the `events` alias instead of the `$devices/<deviceID>/events` topic.
      1. Repeat the steps for each alias you add.
   1. Click **Save**.

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

    ```bash
    yc iot device create \
    --registry-name <registry name> \
    --name <device name> \
    --topic-aliases <alias name>='$devices/{id}/<events, state, commands, or config>'
    ```

{% endlist %}
