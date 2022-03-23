---
title: Создать целевую группу Yandex Application Load Balancer
description: 'Для создания целевой группы Yandex Application Load Balancer необходимо в консоли управления выбрать каталог, в котором будет создаваться целевая группа. В списке сервисов выберите Application Load Balancer. В меню слева выберите Целевые группы. Нажмите кнопку Создать целевую группу. Введите имя целевой группы. Выберите ВМ. Нажмите кнопку Создать.'
---

# Создать целевую группу

Создайте виртуальные машины в рабочем каталоге по [инструкции](../../compute/operations/index.md#vm-create).

Чтобы создать целевую группу:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться целевая группа.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/trgroups.svg) **Целевые группы**.
  1. Нажмите кнопку **Создать целевую группу**.
  1. Введите имя целевой группы: `test-target-group`.
  1. Выберите ВМ.
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания целевой группы:
      ```
      yc alb target-group create --help
      ```

  1. Выполните команду, указав в параметрах имя подсети и внутренние IP-адреса ВМ:
     ```
     yc alb target-group create <имя целевой группы> \
       --target subnet-name=<имя подсети>,ip-address=<внутренний IP-адрес ВМ 1> \
       --target subnet-name=<имя подсети>,ip-address=<внутренний IP-адрес ВМ 2> \
       --target subnet-name=<имя подсети>,ip-address=<внутренний IP-адрес ВМ 3>
     ```

     Результат:

     ```
     id: a5d751meibht4ev264pp
     name: test-target-group
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
