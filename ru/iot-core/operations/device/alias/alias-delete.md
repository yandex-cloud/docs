# Удаление алиаса

Алиас привязан к конкретному устройству, поэтому для удаления алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs %}

- CLI
    
    {% include [cli-install](../../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}
    
    Удалите алиас: 
    
    ```
    $ yc iot device remove-topic-aliases arenak5ciqss6pbas6js --topic-aliases commands
    id: arenak5ciqss6pbas6js
    registry_id: arenou2oj4ct42eq8g3n
    created_at: "2019-09-16T12:32:48.911Z"
    name: second
    ``` 

{% endlist %}

