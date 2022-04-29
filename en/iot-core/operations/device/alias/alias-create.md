# Creating an alias

Aliases are linked to specific devices. To create an alias, you need to [find the device ID or name](../device-list.md).

{% include [monitoring-topic](../../../../_includes/iot-core/monitoring-topic.md) %}

{% list tabs %}

- Management console

   To create an alias:

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to create an alias.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. Click ![image](../../../../_assets/horizontal-ellipsis.svg) to the right of the name of the device you need and select **Edit** from the drop-down list.
   1. Add an alias:
      1. Click **Add alias**.
      1. Complete the fields: enter an alias (such as, `events`) and topic type after `$devices/<deviceID>` (such as, `events`).<br/>You can use the `events` alias to replace `$devices/<deviceID>/events`.
      1. Repeat the steps for each alias you add.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

   Create an alias:

   ```
   yc iot device add-topic-aliases arenak5ciqss6pbas6js
     --topic-aliases commands='$devices/arenak5ciqss6pbas6js/commands'
   ```

   Result:
   ```
   id: arenak5ciqss6pbas6js
   registry_id: arenou2oj4ct42eq8g3n
   created_at: "2019-09-16T12:32:48.911Z"
   name: second
   topic_aliases:
     commands: $devices/arenak5ciqss6pbas6js/commands
   ```

   You can also add an alias when [creating a device](../device-create.md). To do this, instead of a unique ID, specify the `{id}` in the device topic, since the unique ID is not yet known:

   ```
   yc iot device create \
     --registry-name <registry name> \
     --name <device name> \
     --topic-aliases <alias name>='$devices/{id}/<events, state, commands, or config>'
   ```

{% endlist %}
