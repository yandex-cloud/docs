---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Получить информацию об имеющихся реестрах

Узнайте, как получить:
- [Список реестров в каталоге](#registry-list)
- [Подробную информацию о реестре](#registry-get)

## Получить список реестров в каталоге {#registry-list}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Получите список [реестров](../../concepts/registry.md) в каталоге по умолчанию:
  
  ```
  $ yc container registry list
  +----------------------+--------+----------------------+
  |          ID          |  NAME  |      FOLDER ID       |
  +----------------------+--------+----------------------+
  | crpd50616s9a2t7gr8mi | my-reg | b1g88tflru0ek1omtsu0 |
  +----------------------+--------+----------------------+
  ```
  
- API
  
  Чтобы получить список реестров в каталоге по умолчанию, воспользуйтесь методом [list](../../api-ref/Registry/list.md) для ресурса [Registry](../../api-ref/Registry/).
  
{% endlist %}


## Получить подробную информацию о реестре {#registry-get}

Для обращения к реестру используйте параметры `id` или `name` из [предыдущего](#registry-list) пункта.

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Получите подробную информацию о реестре:
  
  ```
  $ yc container registry get my-reg
  id: crpd50616s9a2t7gr8mi
  folder_id: b1g88tflru0ek1omtsu0
  name: my-reg
  status: ACTIVE
  created_at: "2019-01-09T14:34:06.601Z"
  ```
  
- API
  
  Чтобы получить подробную информацию о реестре, воспользуйтесь методом [get](../../api-ref/Registry/get.md) для ресурса [Registry](../../api-ref/Registry/).
  
  
{% endlist %}
