# Получение информации об устройстве

Чтобы узнать `ID` или `NAME` устройства, получите список устройств в реестре или подробную информацию об устройстве.

## Получить список устройств в реестре {#device-list}

Если вы не знаете уникальный идентификатор или имя реестра, в котором находится ваше устройство, [посмотрите список существующих реестров](../registry/registry-list.md#registry-list).

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Получите список [устройств](../../concepts/index.md#device) в реестре:
  
  ```
  $ yc iot device list --registry-name my-registry
  
  +----------------------+-----------+
  |          ID          |   NAME    |
  +----------------------+-----------+
  | b9135goeh1uc1s2i07nm | my-device |
  +----------------------+-----------+
  ```
  
{% endlist %}


## Получить подробную информацию об устройстве {#device-get}

Для обращения к устройству используйте параметры `ID` или `NAME` из [предыдущего](#device-list) пункта.

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  
  Получите подробную информацию об устройстве:
  
  ```
  $ yc iot device get my-device
  
  id: b9135goeh1uc1s2i07nm
  registry_id: b91ki3851hab9m0l68je
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  ```
  
{% endlist %}
