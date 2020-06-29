# Удаление алиаса

Алиас привязан к конкретному устройству, поэтому для удаления алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs %}

- Консоль управления

   Для удаления алиаса:

   1. В [консоли управления](https://console.cloud.yandex.ru/) выберите каталог, из которого вы хотите удалить алиас.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Нажмите значок ![image](../../../../_assets/horizontal-ellipsis.svg) справа от имени нужного устройства, в выпадающем списке выберите **Редактировать**.
   1. Нажмите значок ![image](../../../../_assets/cross.svg) справа от удаляемого алиаса.
   
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

