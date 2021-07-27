---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Изменить целевую группу

Вы можете добавлять или удалять ВМ из целевой группы.

## Добавить ВМ в целевую группу {#add-targets}

Чтобы добавить ВМ в целевую группу:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит целевая группа.
  1. Выберите сервис **{{ alb-name }}**.
  1. Откройте раздел **Целевые группы**.
  1. Нажмите на имя нужной группы.
  1. Нажмите **Добавить целевые ресурсы**.
  1. Отметьте нужные ВМ и нажмите кнопку **Добавить**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления ресурсов в целевые группы:
     ```
     yc alb target-group add-targets --help
     ```

  1. Выполните команду, указав имя целевой группы, имя подсети и внутренний IP-адрес ВМ:
     ```
     yc alb target-group --name <имя целевой группы> add-targets \
     --target subnet-name=<имя подсети>,ip-address=<внутренний IP-адрес ВМ>
     ```

     Результат выполнения команды:
     ```
     done (1s)
     id: a5daisped2unjsnbjhhl
     name: test-tg
     folder_id: aoe197919j8elpeg1lkp
     targets:
     - ip_address: 10.130.0.28
       subnet_id: buc4gsmpj8hvramg61g8
     - ip_address: 10.128.0.34
       subnet_id: fo2ap2nrhjk9vpfdnno8
     - ip_address: 10.129.0.30
       subnet_id: blt6pcatjje62sqvjq5b
     - ip_address: 10.128.0.32
       subnet_id: blt6pca13je62sqvjq5b
     created_at: "2021-02-11T11:16:27.770674538Z"
     ```

{% endlist %}

## Удалить ВМ из целевой группы {#remove-targets}

Чтобы удалить ВМ из целевой группы:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит целевая группа.
  1. Выберите сервис **{{ alb-name }}**.
  1. Откройте раздел **Целевые группы**.
  1. Нажмите на имя нужной группы.
  1. Нажмите **Изменить**.
  1. Выберите виртуальную машину и нажмите значок ![image](../../_assets/dots.svg).
  1. В открывшемся меню выберите пункт **Удалить**.
  1. Подтвердите удаление.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ресурсов из целевой группы:
     ```
     yc alb target-group remove-targets --help
     ```

  1. Выполните следующую команду, указав имя целевой группы, имя подсети и внутренний IP-адрес ВМ:
     ```
     yc alb target-group --name <имя целевой группы> \
     remove-targets --target subnet-name=<имя подсети>,ip-address=<внутренний IP-адрес ВМ>
     ```

     Результат выполнения команды:
     ```
     done (1s)
     id: a5daisped2unjsnbjhhl
     name: test-tg
     folder_id: aoe197919j8elpeg1lkp
     targets:
     - ip_address: 10.130.0.28
       subnet_id: buc4gsmpj8hvramg61g8
     - ip_address: 10.128.0.34
       subnet_id: fo2ap2nrhjk9vpfdnno8
     - ip_address: 10.129.0.30
       subnet_id: blt6pcatjje62sqvjq5b
     created_at: "2021-02-11T11:16:27.770674538Z"
     ```

{% endlist %}