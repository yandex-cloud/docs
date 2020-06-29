# Изменение алиаса

Алиас привязан к конкретному устройству, поэтому для изменения алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs %}

- Консоль управления

   Для изменения алиаса:

   1. В [консоли управления](https://console.cloud.yandex.ru/) выберите каталог, в котором вы выполняете сценарий.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите из списка нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Нажмите значок ![image](../../../../_assets/horizontal-ellipsis.svg) справа от имени нужного устройства, в выпадающем списке выберите **Редактировать**.
   1. Измените значения полей нужного алиаса.
   1. Нажмите **Сохранить**.

- CLI
    
    {% include [cli-install](../../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}
    
    Измените алиасы устройства: 
    
    {% note warning %}
    
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
