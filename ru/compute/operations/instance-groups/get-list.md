---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Получить список групп виртуальных машин

Чтобы получить список групп виртуальных машин:

{% list tabs %}

- Консоль управления
  
  1. Откройте страницу каталога в консоли управления.
  1. Выберите сервис **{{ compute-full-name }}**.
  1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для работы с группой виртуальных машин:
  
      ```
      $ {{ yc-compute-ig }} --help
      ```
  
  1. Получите список групп виртуальных машин в каталоге по умолчанию:
  
      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}
  
- API
  
  Воспользуйтесь методом API [list](../../api-ref/InstanceGroup/list.md).
  
  Список доступных групп запрашивайте методом [listInstances](../../api-ref/InstanceGroup/listInstances.md).
  
{% endlist %}
