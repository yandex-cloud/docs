---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Удаление алиаса

Алиас привязан к конкретному устройству, поэтому для удаления алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs %}

- Консоль управления

   Чтобы удалить алиас:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить алиас.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Справа от имени нужного устройства нажмите значок ![image](../../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Справа от удаляемого алиаса нажмите значок ![image](../../../../_assets/cross.svg).
   1. Нажмите кнопку **Сохранить**.

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

