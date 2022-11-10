---
title: Создать целевую группу {{ alb-full-name }}
description: "Для создания целевой группы {{ alb-full-name }} необходимо в консоли управления выбрать каталог, в котором будет создаваться целевая группа. В списке сервисов выберите {{ alb-name }}. В меню слева выберите Целевые группы. Нажмите кнопку Создать целевую группу. Введите имя целевой группы. Выберите ВМ. Нажмите кнопку Создать."
---

# Создать целевую группу {{ alb-name }}

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

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

      ```hcl
      resource "yandex_alb_target_group" "foo" {
        name           = "<имя целевой группы>"

        target {
          subnet_id    = "<идентификатор подсети>"
          ip_address   = "<внутренний IP-адрес ВМ 1>"
        }

        target {
          subnet_id    = "<идентификатор подсети>"
          ip_address   = "<внутренний IP-адрес ВМ 2>"
        }

        target {
          subnet_id    = "<идентификатор подсети>"
          ip_address   = "<внутренний IP-адрес ВМ 3>"
        }
      }
      ```

      Где:

      * `yandex_alb_target_group` — параметры целевой группы:
        * `name` — имя целевой группы.
        * `target` — параметры целевого ресурса:
          * `subnet_id` — идентификатор подсети, в которой размещена ВМ. Получить список доступных подсетей можно с помощью команды [CLI](../../cli/quickstart.md): `yc vpc subnet list`.
          * `ip_address` — внутренний IP-адрес ВМ. Получить список внутренних IP-адресов можно с помощью команды [CLI](../../cli/quickstart.md): `yc vpc subnet list-used-addresses --id <идентификатор подсети>`.

      Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb target-group list
      ```

{% endlist %}
