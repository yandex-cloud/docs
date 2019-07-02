# Удалить устройство

Для обращения к [устройству](../../concepts/index.md#device) используйте его идентификатор или имя. Как узнать идентификатор или имя устройства, читайте в разделе [#T](device-list.md).

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  1. Удалите устройство:
  
      ```
      $ yc iot device delete my-device
      ```
  
  1. Проверьте, что устройство действительно удалено:
  
      ```
      $ yc iot device list --registry-name my-registry
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```
{% endlist %}
