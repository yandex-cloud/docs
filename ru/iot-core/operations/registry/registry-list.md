# Получение информации о реестре

Чтобы узнать `ID` или `NAME` реестра, получите список реестров в каталоге или подробную информацию о реестре.

## Получить список реестров в каталоге {#registry-list}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Получите список [реестров](../../concepts/index.md#registry) в каталоге по умолчанию:
  
  ```
  $ yc iot registry list
  +----------------------+-------------+
  |          ID          |    NAME     |
  +----------------------+-------------+
  | b91ki3851hab9m0l68je | my-registry |
  +----------------------+-------------+
  ```
  
{% endlist %}


## Получить подробную информацию о реестре {#registry-get}

Для обращения к реестру используйте параметры `ID` или `NAME` из [предыдущего](#registry-list) пункта.

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Получите подробную информацию о реестре:
  
  ```
  $ yc iot registry get my-registry
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```
  
{% endlist %}
