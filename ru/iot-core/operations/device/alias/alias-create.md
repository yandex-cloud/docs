# Создание алиаса

Алиас привязан к конкретному устройству, поэтому для создания алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs %}

- CLI
    
    {% include [cli-install](../../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}
    
    Создайте алиас: 
    
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

    Также вы можете добавить алиас при [создании устройства](../device-create.md). Для этого вместо уникального идентификатора в топике устройства указывается `{id}`, так как уникальный идентификатор еще неизвестен:
    
    ```
    $ yc iot device create 
    --registry-name <имя реестра> 
    --name <имя устройства> 
    --topic-aliases <имя алиаса>='$devices/{id}/<events или commands>'
    ```
    
{% endlist %}
