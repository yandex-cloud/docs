# Updating an alias

Aliases are linked to specific devices. To update an alias, you [need the device ID or name](../device-list.md).

{% list tabs %}

- Management console

   To update an alias:

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to update an alias.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. Click ![image](../../../../_assets/horizontal-ellipsis.svg) to the right of the name of the device you need and select **Edit** from the drop-down list.
   1. Update the values of the alias fields.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

   Update device aliases:

   {% note warning %}

   The existing set of `topic_aliases` is completely replaced by the provided set.

   {% endnote %}

   ```
   yc iot device update first  --topic-aliases 'events=$devices/areqjd6un3afc3cefcvm/events,commands=$devices/areqjd6un3afc3cefcvm/commands'
   ```

   Result:
   ```
   	id: areqjd6un3afc3cefcvm
   registry_id: arenou2oj4ct42eq8g3n
   created_at: "2019-09-16T10:41:06.489Z"
   name: first
   topic_aliases:
     commands: $devices/areqjd6un3afc3cefcvm/commands
     events: $devices/areqjd6un3afc3cefcvm/events
   ```

{% endlist %}
