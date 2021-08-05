---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Создание алиаса

Алиас привязан к конкретному устройству, поэтому для создания алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% include [monitoring-topic](../../../../_includes/iot-core/monitoring-topic.md) %}

{% list tabs %}

- Консоль управления

   Чтобы создать алиас:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать алиас.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Нажмите значок ![image](../../../../_assets/horizontal-ellipsis.svg) справа от имени нужного устройства, в выпадающем списке выберите **Редактировать**.
   1. Добавьте алиас:
      1. Нажмите кнопку **Добавить алиас**.
      1. Заполните поля: введите алиас (например, `events`) и тип топика после `$devices/<deviceID>` (например, `events`).<br/>Вы сможете использовать алиас `events` вместо топика `$devices/<deviceID>/events`.
      1. Повторите действия для каждого добавляемого алиаса.
   1. Нажмите кнопку **Сохранить**.

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
    --topic-aliases <имя алиаса>='$devices/{id}/<events, state, commands или config>'
    ```
    
{% endlist %}
