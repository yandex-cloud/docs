---
title: "Как удалить целевую группу в балансировщике приложений"
description: "Чтобы удалить целевую группу, в консоли управления выберите каталог, которому принадлежит целевая группа. Выберите сервис {{ alb-name }}. В меню слева выберите Целевые группы. Выберите целевую группу и нажмите значок выбора. В открывшемся меню выберите пункт Удалить. Чтобы выполнить это действие с несколькими группами, выделите нужные в списке и нажмите кнопку Удалить в нижней части экрана."
---

# Удалить целевую группу {{ alb-name }}

{% note warning %}

{% include [target-group-deletion-restriction](../../_includes/application-load-balancer/target-group-deletion-restriction.md) %}

{% endnote %}

Чтобы удалить целевую группу:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана целевая группа.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
  1. Выберите целевую группу и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
  1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.common.delete }}**.

     Чтобы выполнить это действие с несколькими группами, выделите нужные в списке и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** в нижней части экрана.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления целевой группы:

      ```bash
      yc alb target-group delete --help
      ```

  1. Выполните команду:

      ```bash
      yc alb target-group delete <имя_или_идентификатор_целевой_группы>
      ```

      Чтобы проверить удаление, получите список целевых групп, выполнив команду:

      ```bash
      yc alb target-group list
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}
  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с описанием целевой группы.

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
     yc alb target-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/TargetGroup/delete.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/Delete](../api-ref/grpc/target_group_service.md#Delete).

{% endlist %}