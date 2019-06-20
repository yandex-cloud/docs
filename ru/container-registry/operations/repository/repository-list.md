# Получить список репозиториев в реестре

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Получите список репозиториев в текущем реестре:
  
  ```
  $ yc container repository list
  +-----------------------------+
  |            NAME             |
  +-----------------------------+
  | crp2hlbs67tj4ggrfodb/ubuntu |
  +-----------------------------+
  ```
  
- API
  
  Чтобы получить список репозиториев в реестре, воспользуйтесь методом [list](../../api-ref/Repository/list.md) для ресурса [Repository](../../api-ref/Repository/).
  
{% endlist %}
