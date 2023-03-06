---
title: "Как удалить целевую группу в балансировщике приложений"
description: "Чтобы удалить целевую группу, в консоли управления выберите каталог, которому принадлежит целевая группа. Выберите сервис {{ alb-name }}. В меню слева выберите Целевые группы. Выберите целевую группу и нажмите значок выбора. В открывшемся меню выберите пункт Удалить. Чтобы выполнить это действие с несколькими группами, выделите нужные в списке и нажмите кнопку Удалить в нижней части экрана."
---

# Удалить целевую группу {{ alb-name }}

{% note warning %}

{% include [target-group-deletion-restriction](../../_includes/application-load-balancer/target-group-deletion-restriction.md) %}

{% endnote %}

Чтобы удалить целевую группу:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана целевая группа.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/trgroups.svg) **Целевые группы**.
  1. Выберите целевую группу и нажмите значок ![image](../../_assets/horizontal-ellipsis.svg).
  1. В открывшемся меню выберите пункт **Удалить**.

     Чтобы выполнить это действие с несколькими группами, выделите нужные в списке и нажмите кнопку **Удалить** в нижней части экрана.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления целевой группы:

     ```bash
     yc alb target-group delete --help
     ```

  1. Выполните команду:

     ```bash
     yc alb target-group delete <имя или идентификатор целевой группы>
     ```

     Чтобы проверить удаление, получите список целевых групп, выполнив команду:

     ```bash
     yc alb target-group list
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с описанием целевой группы.

     Пример описания целевой группы в конфигурации {{ TF }}:

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

     Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения целевой группы можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb target-group list
     ```

{% endlist %}