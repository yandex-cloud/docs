---
title: Создать целевую группу {{ alb-full-name }}
description: Для создания целевой группы {{ alb-full-name }} необходимо в консоли управления выбрать каталог, в котором будет создаваться целевая группа. В списке сервисов выберите {{ alb-name }}. В меню слева выберите Целевые группы. Нажмите кнопку Создать целевую группу. Введите имя целевой группы. Выберите ВМ. Нажмите кнопку Создать.
---

# Создать целевую группу {{ alb-name }}

Создайте [виртуальные машины](../../compute/concepts/vm.md) в рабочем [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по [инструкции](../../compute/operations/index.md#vm-create).

Чтобы создать [целевую группу](../concepts/target-group.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться целевая группа.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_target-group-create }}**.
  1. Введите имя и описание целевой группы.
  1. В блоке **{{ ui-key.yacloud.alb.label_targets }}** выберите ВМ из списка или добавьте целевой ресурс вручную:
     1. В поле **{{ ui-key.yacloud.alb.column_target }}** укажите адрес ресурса и выберите [подсеть](../../vpc/concepts/network.md#subnet).
     1. (Опционально) Если [IP-адрес](../../vpc/concepts/address.md) ресурса находится вне [{{ vpc-full-name }}](../../vpc/), выберите опцию **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

        Например, укажите частный IPv4-адрес из вашего ЦОД, подключенного к {{ yandex-cloud }} через [{{ interconnect-full-name }}](../../interconnect/). Адрес должен входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3). Подробнее см. [Подсети](../../vpc/concepts/network.md#subnet).


     1. Нажмите **{{ ui-key.yacloud.alb.button_add-target }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для создания целевой группы:

     ```bash
     yc alb target-group create --help
     ```

  1. Выполните команду, указав в параметрах имя целевой группы, имя [подсети](../../vpc/concepts/network.md#subnet) и [внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) ВМ:

     ```bash
     yc alb target-group create \
       --name <имя_целевой_группы> \
       --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_1> \
       --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_2> \
       --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ_3>
     ```

     Результат:

      ```text
      id: a5d751meibht********
      name: <имя_целевой_группы>
      folder_id: aoerb349v3h4********
      targets:
      - ip_address: <внутренний_IP-адрес_ВМ_1>
        subnet_id: fo2tgfikh3he********
      - ip_address: <внутренний_IP-адрес_ВМ_2>
        subnet_id: fo2tgfikh3he********
      - ip_address: <внутренний_IP-адрес_ВМ_3>
        subnet_id: fo2tgfikh3he********
      created_at: "2021-02-11T11:16:27.770674538Z
      ```

      Также вы можете создать целевую группу с ресурсами, которые размещены вне [{{ vpc-full-name }}](../../vpc/), например в вашем ЦОД, подключенном к {{ yandex-cloud }} через [{{ interconnect-full-name }}](../../interconnect/). Адреса ресурсов должны входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3). Подробнее см. [Подсети](../../vpc/concepts/network.md#subnet).


      Выполните команду, указав в параметрах имя целевой группы и частные IPv4-адреса ресурсов:

      ```bash
      yc alb target-group create \
        --name <имя_целевой_группы> \
        --target private-ip-address=true,ip-address=<частный_IPv4-адрес_ресурса_1> \
        --target private-ip-address=true,ip-address=<частный_IPv4-адрес_ресурса_2> \
        --target private-ip-address=true,ip-address=<частный_IPv4-адрес_ресурса_3>
      ```

      Результат:

      ```text
      id: ds7s2dld2usr********
      name: <имя_целевой_группы>
      folder_id: aoerb349v3h4********
      targets:
        - ip_address: <частный_IPv4-адрес_ресурса_1>
          private_ipv4_address: true
        - ip_address: <частный_IPv4-адрес_ресурса_2>
          private_ipv4_address: true
        - ip_address: <частный_IPv4-адрес_ресурса_3>
          private_ipv4_address: true
      created_at: "2023-07-25T08:55:14.172526884Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

     Где `yandex_alb_target_group` — параметры целевой группы:
     * `name` — имя целевой группы.
     * `target` — параметры целевого ресурса:
       * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet), в которой размещена ВМ. Получить список доступных подсетей можно с помощью команды [CLI](../../cli/): `yc vpc subnet list`.
       * `ip_address` — внутренний IP-адрес ВМ. Получить список [внутренних IP-адресов](../../vpc/concepts/address.md#internal-addresses) можно с помощью команды CLI: `yc vpc subnet list-used-addresses --id <идентификатор_подсети>`.

     Также вы можете создать целевую группу с ресурсами, которые размещены вне [{{ vpc-full-name }}](../../vpc), например в вашем ЦОД, подключенном к {{ yandex-cloud }} через [{{ interconnect-full-name }}](../../interconnect/):

     ```hcl
     resource "yandex_alb_target_group" "foo" {
       name                   = "<имя_целевой_группы>"

       target {
         private_ipv4_address = true
         ip_address           = "<частный_IPv4-адрес_ресурса_1>"
       }

       target {
         private_ipv4_address = true
         ip_address           = "<частный_IPv4-адрес_ресурса_2>"
       }

       target {
         private_ipv4_address = true
         ip_address           = "<частный_IPv4-адрес_ресурса_3>"
       }
     }
     ```


     Где `yandex_alb_target_group` — параметры целевой группы:
     * `name` — имя целевой группы.
     * `target` — параметры целевого ресурса:
       * `private_ipv4_address` — параметр, который означает, что IP-адрес находится вне {{ vpc-name }}.
       * `ip_address` — частный IPv4-адрес ресурса. Адреса должны входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3). Подробнее см. [Подсети](../../vpc/concepts/network.md#subnet).

     Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc alb target-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/TargetGroup/create.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/Create](../api-ref/grpc/TargetGroup/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../tutorials/application-load-balancer-website.md)
* [{#T}](../tutorials/logging.md)
* [{#T}](../tutorials/alb-with-ddos-protection/console.md)
