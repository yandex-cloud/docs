# Создание устройства

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  1. [Посмотрите список реестров](../registry/registry-list.md#registry-list), в которых можно создать устройсто, или [создайте новый реестр](../registry/registry-create.md).
  
  1. Создайте устройство:
  
      ```
      $ yc iot device create --registry-name my-registry --name my-device
  
      id: b9135goeh1uc1s2i07nm
      registry_id: b91ki3851hab9m0l68je
      created_at: "2019-05-28T16:08:30.938Z"
      name: my-device
      ```
  
     {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Проверьте, что устройство создалось:
  
      ```
      $ yc iot device list --registry-name  my-registry
      +----------------------+-----------+
      |          ID          |   NAME    |
      +----------------------+-----------+
      | b9135goeh1uc1s2i07nm | my-device |
      +----------------------+-----------+
      ```
  
{% endlist %}
