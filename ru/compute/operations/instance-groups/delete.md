# Удалить группу виртуальных машин

{% note important %}

Удаление группы виртуальных машин — неотменяемая и необратимая операция, восстановить удаленную группу невозможно. Вместе с группой удаляются целевая группа {{ load-balancer-name }}, виртуальные машины и диски.

{% endnote %}

Чтобы удалить группу виртуальных машин:

{% list tabs %}

- Консоль управления
  
  1. Откройте страницу каталога в консоли управления.
  
  1. Выберите сервис **{{ compute-full-name }}**.
  
  1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
  
  1. Нажмите значок ![image](../../../_assets/vertical-ellipsis.svg) для нужной группы и выберите пункт **Удалить**.
  
- CLI
  
  {% include [cli-install.md](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для удаления группы виртуальных машин:
  
      ```
      $ {{ yc-compute-ig }} delete --help
      ```
  
  1. Получите список групп виртуальных машин в каталоге по умолчанию:
  
      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-fixed-group`.
  1. Удалите группу виртуальных машин:
  
      ```
      $ {{ yc-compute-ig }} delete --name first-fixed-group
      ```
  
      {{ ig-name }} запустит операцию удаления группы виртуальных машин.
  
- API
  
  Воспользуйтесь методом API [delete](../../api-ref/InstanceGroup/delete.md).
  
  Список доступных групп запрашивайте методом [listInstances](../../api-ref/InstanceGroup/listInstances.md).
  
{% endlist %}
