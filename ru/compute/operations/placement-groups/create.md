---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Создать группу размещения

Создайте [группу размещения](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы размещения:

     ```
     $ yc compute placement-group create --help
     ```

  1. Создайте группу размещения:

     ```
     $ yc compute placement-group create --spread-strategy --name my-group
     id: fd83bv4rnsna2sjkiq4s
     folder_id: b1g5kkhshgs9s0l4609d
     created_at: "2019-12-30T10:07:34Z"
     name: my-group
     spread_placement_strategy: {}
     ```

     Данная команда создаст группу размещения со следующими характеристиками:

     - С именем `my-group`.
     - Стратегией распределенного размещения (`spread`).

   1. Проверьте, что группа размещения добавлена:

      ```
      $ yc compute placement-group list
      +----------------------+----------+----------+
      |          ID          |   NAME   | STRATEGY |
      +----------------------+----------+----------+
      | fd83bv4rnsna2sjkiq4s | my-group | SPREAD   |
      +----------------------+----------+----------+
      ```

- API

  Воспользуйтесь методом API [create](../../api-ref/PlacementGroup/create.md).

{% endlist %}

## Смотрите также {see-also}

* [Как добавить виртуальную машину в группу размещения](add-vm.md).
* [Как создать виртуальную машину в группе размещения](create-vm-in-pg.md).