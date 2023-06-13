# Изменить целевую группу

Вы можете добавлять или удалять виртуальные машины из целевой группы.

## Добавить ВМ в целевую группу {#add-targets}

Чтобы добавить ВМ в целевую группу:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана целевая группа.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/trgroups.svg) **Целевые группы**.
  1. Нажмите на имя нужной группы.
  1. Нажмите **Добавить целевые ресурсы**.
  1. Выберите ВМ из списка или добавьте целевой ресурс вручную:
      1. В поле **IP-адрес** укажите адрес ресурса и выберите [подсеть](../../vpc/concepts/network.md#subnet).
      1. (опционально) Если IP-адрес ресурса находится вне {{ vpc-name }}, выберите опцию **{{ ui-key.yacloud.alb.label_target-private-ip }}**.

          Например, укажите IP-адрес из вашего ЦОД, подключенного к {{ yandex-cloud }} через [{{ interconnect-name }}](../../interconnect/). Адрес должен входить в [частные диапазоны из RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3).
  1. Нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления ресурсов в целевые группы:

      ```bash
      yc alb target-group add-targets --help
      ```

  1. Выполните команду, указав имя целевой группы, имя подсети и внутренний IP-адрес ВМ:

      ```bash
      yc alb target-group add-targets \
        --name <имя_целевой_группы> \
        --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ>
      ```

      Результат:

      ```yaml
      done (1s)
      id: a5d751meibht4ev26...
      name: <имя_целевой_группы>
      ...
      - ip_address: <внутренний_IP-адрес_ВМ>
        subnet_id: fo2tgfikh3hergif2...
      created_at: "2021-02-11T11:16:27.770674538Z"
      ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и добавьте блок `target` с параметрами целевого ресурса во фрагмент с описанием целевой группы:

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
        
        target {
          subnet_id    = "<идентификатор_подсети>"
          ip_address   = "<внутренний_IP-адрес_ВМ_4>"
        }
      }
      ```

     Где `yandex_alb_target_group` — параметры целевой группы:
     * `name` — имя целевой группы.
     * `target` — параметры целевого ресурса:
       * `subnet_id` — идентификатор подсети, в которой размещена ВМ. Получить список доступных подсетей можно с помощью команды [CLI](../../cli/quickstart.md): `yc vpc subnet list`.
       * `ip_address` — внутренний IP-адрес ВМ. Получить список внутренних IP-адресов можно с помощью команды [CLI](../../cli/quickstart.md): `yc vpc subnet list-used-addresses --id <идентификатор подсети>`.

     Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения целевой группы можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb target-group get --name <имя_целевой_группы>
     ```

- API

  Воспользуйтесь методом REST API [addTargets](../api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/AddTargets](../api-ref/grpc/target_group_service.md#AddTargets).

{% endlist %}

## Удалить ВМ из целевой группы {#remove-targets}

Чтобы удалить ВМ из целевой группы:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана целевая группа.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/trgroups.svg) **Целевые группы**.
  1. Нажмите на имя нужной группы.
  1. Справа от нужной виртуальной машины нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить целевой ресурс**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ресурсов из целевой группы:

      ```bash
      yc alb target-group remove-targets --help
      ```

  1. Выполните следующую команду, указав имя целевой группы, имя подсети и внутренний IP-адрес ВМ:

      ```bash
      yc alb target-group remove-targets \
        --name <имя_целевой_группы> \
        --target subnet-name=<имя_подсети>,ip-address=<внутренний_IP-адрес_ВМ>
      ```

      Результат:

      ```yaml
      id: ds7urm6dn6cm48ba7...
      name: <имя_целевой_группы>
      folder_id: aoerb349v3h4bupph...
      created_at: "2023-06-10T13:14:55.239094324Z"
      ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и удалите блок `target` с IP-адресом ВМ, которую нужно удалить, во фрагменте с описанием целевой группы:

      Пример описания целевой группы в конфигурации {{ TF }}:

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

      Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения целевой группы можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb target-group get --name <имя_целевой_группы>
     ```

- API

  Воспользуйтесь методом REST API [removeTargets](../api-ref/TargetGroup/removeTargets.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/RemoveTargets](../api-ref/grpc/target_group_service.md#RemoveTargets).

{% endlist %}