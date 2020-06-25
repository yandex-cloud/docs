# Получить информацию об имеющихся репозиториях

Узнайте, как получить:
* [Список репозиториев в реестре](#repository-list)
* [Информацию о репозитории по его имени](#repository-get-by-name)

## Получить список репозиториев в реестре {#repository-list}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Получите список репозиториев в текущем реестре:
  
  ```
  $ yc container repository list
  +----------------------+-----------------------------+
  |          ID          |               NAME          |
  +----------------------+-----------------------------+
  | crt3cpm16edqql0t30s2 | crp2hlbs67tj4ggrfodb/ubuntu |
  +----------------------+-----------------------------+
  ```
  
- API
  
  Чтобы получить список репозиториев в реестре, воспользуйтесь методом [list](../../api-ref/Repository/list.md) для ресурса [Repository](../../api-ref/Repository/).
  
{% endlist %}

## Получить информацию о репозитории по его имени {#repository-get-by-name}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Получите информацию о репозитории, передав в качестве аргумента его имя (начиная с идентификатора реестра):  
  
  ```
  $ yc container repository get crp2hlbs67tj4ggrfodb/ubuntu
  name: crp2hlbs67tj4ggrfodb/ubuntu
  id: crt3cpm16edqql0t30s2
  ```
  
{% endlist %}
