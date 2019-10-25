# Updating an alias

Aliases are linked to specific devices. To update an alias, you need [the device ID or name](../device-list.md).

{% list tabs %}

- CLI

    {% include [cli-install](../../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

    Update device aliases:

    {% note important %}

    The existing set of `topic_aliases` is completely replaced by the provided set.

    {% endnote %}

    ```
    $ yc iot device update first  --topic-aliases 'events=$devices/areqjd6un3afc3cefcvm/events,commands=$devices/areqjd6un3afc3cefcvm/commands'
    id: areqjd6un3afc3cefcvm
    registry_id: arenou2oj4ct42eq8g3n
    created_at: "2019-09-16T10:41:06.489Z"
    name: first
    topic_aliases:
      commands: $devices/areqjd6un3afc3cefcvm/commands
      events: $devices/areqjd6un3afc3cefcvm/events
    ```

{% endlist %}

