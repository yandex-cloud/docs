---
title: "Создать целевую группу {{ alb-full-name }}"
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
  1. Введите имя и описание целевой группы.
  1. В блоке **Целевые ресурсы** выберите ВМ из списка или добавьте целевой ресурс вручную:

      1. В поле **IP-адрес** укажите адрес ресурса и выберите [подсеть](../../vpc/concepts/network.md#subnet).
      1. (опционально) Если IP-адрес ресурса находится вне {{ vpc-name }}, выберите опцию **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

          Например, укажите IP-адрес из вашего ЦОД, подключенного к {{ yandex-cloud }} через [{{ interconnect-name }}](../../interconnect/). Адрес должен входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3).
      
      1. Нажмите **Добавить целевой ресурс**.

  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания целевой группы:

      ```bash
      yc alb target-group create --help
      ```

  1. Выполните команду, указав в параметрах имя [подсети](../../vpc/concepts/network.md#subnet) и внутренние IP-адреса ВМ:

      ```bash
      yc alb target-group create <имя_целевой_группы> \
        --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_1> \
        --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_2> \
        --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_3>
      ```

      Результат:

      ```yaml
      id: a5d751meibht4ev26...
      name: <имя_целевой_группы>
      folder_id: aoerb349v3h4bupph...
      targets:
      - ip_address: <внутренний_IP-адрес_ВМ_1>
        subnet_id: fo2tgfikh3hergif2...
      - ip_address: <внутренний_IP-адрес_ВМ_2>
        subnet_id: fo2tgfikh3hergif2...
      - ip_address: <внутренний_IP-адрес_ВМ_3>
        subnet_id: fo2tgfikh3hergif2...
      ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

      ```hcl
      resource "yandex_alb_target_group" "foo" {
        name           = "<имя_целевой_группы>"

        target {
          subnet_id    = "<идентификатор_подсети>"
          ip_address   = "<внутренний_IP-адрес_ВМ_1>"
        }

        target {
          subnet_id    = "<идентификатор_подсети>"
          ip_address   = "<внутренний_IP-адрес_ВМ_2>"
        }

        target {
          subnet_id    = "<идентификатор_подсети>"
          ip_address   = "<внутренний_IP-адрес_ВМ_3>"
        }
      }
      ```

      Где:

      * `yandex_alb_target_group` — параметры целевой группы:
        * `name` — имя целевой группы.
        * `target` — параметры целевого ресурса:
          * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet), в которой размещена ВМ. Получить список доступных подсетей можно с помощью команды [CLI](../../cli/quickstart.md): `yc vpc subnet list`.
          * `ip_address` — внутренний IP-адрес ВМ. Получить список внутренних IP-адресов можно с помощью команды [CLI](../../cli/quickstart.md): `yc vpc subnet list-used-addresses --id <идентификатор_подсети>`.

      Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb target-group list
      ```

- API

  Воспользуйтесь методом REST API [create](../api-ref/TargetGroup/create.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/Create](../api-ref/grpc/target_group_service.md#Create).

{% endlist %}
