## Создать целевую группу

Чтобы создать целевую группу:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться целевая группа.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. В меню слева выберите **Целевые группы**.
  1. Нажмите кнопку **Создать целевую группу**.
  1. Введите имя целевой группы: `test-target-group`.
  1. Выберите три ВМ из разных зон доступности.
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания целевой группы:

      ```
      yc alb target-group create --help
      ```

  1. Выполните команду:

     ```
     yc alb target-group create test-tg \
     --target subnet-name=subnet-1,ip-address=10.0.0.36 \
     --target subnet-name=subnet-2,ip-address=10.1.0.8 \
     --target subnet-name=subnet-3,ip-address=10.2.0.12 
     ```

     Результат выполнения команды:
     
     ```
     id: a5d751meibht4ev264pp
     name: test-tg
     folder_id: aoerb349v3h4bupphtaf
     targets:
     - ip_address: 10.0.0.36
       subnet_id: bucp2nunecvqgobf7cve
     - ip_address: 10.1.0.8
       subnet_id: bltca464785h2eon18r9
     - ip_address: 10.2.0.12
       subnet_id: fo2tgfikh3hergif27iu
     ```

{% endlist %}