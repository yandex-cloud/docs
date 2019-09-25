# Изменение алиаса

Алиас привязан к конкретному устройству, поэтому для изменения алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs %}

- CLI
    
    {% include [cli-install](../../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}
    
    Измените алиасы устройства: 
    
    {% note important %}
    
    Существующий набор `topic_aliases` полностью перезаписывается набором, переданным в запросе.
    
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
