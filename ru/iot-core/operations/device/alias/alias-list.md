# Получение списка алиасов

Список алиасов можно получить только для всех устройств в реестре. Для этого вам необходимо знать уникальный идентификатор или имя реестра. Как узнать уникальный идентификатор или имя реестра, читайте в разделе [{#T}](../../registry/registry-list.md).

{% list tabs %}

- CLI
    
    {% include [cli-install](../../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}
    
    Получите список алиасов для всех устройств в реестре:
    
    ```
    $ yc iot registry list-device-topic-aliases my-registry
    +----------+----------------------------------------+----------------------+
    |  ALIAS   |              TOPIC PREFIX              |      DEVICE ID       |
    +----------+----------------------------------------+----------------------+
    | commands | $devices/arenak5ciqss6pbas6js/commands | arenak5ciqss6pbas6js |
    +----------+----------------------------------------+----------------------+
    ```
    
{% endlist %}
