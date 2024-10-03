---
title: Как удалить группу бэкендов
description: Следуя данной инструкции, вы сможете удалить группу бэкендов.
---

# Удалить группу бэкендов

{% note warning %}

{% include [backend-group-deletion-restriction](../../_includes/application-load-balancer/backend-group-deletion-restriction.md) %}

{% endnote %}

Чтобы удалить [группу бэкендов](../concepts/backend-group.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создана группа бэкендов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Напротив имени группы бэкендов нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

     Чтобы выполнить это действие с несколькими группами, выделите нужные в списке и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** в нижней части экрана.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для удаления группы бэкендов:

     ```bash
     yc alb backend-group delete --help
     ```

  1. Выполните команду, указав имя удаляемой группы бэкендов:

     ```bash
     yc alb backend-group delete --name <имя_группы_бэкендов>
     ```

     Чтобы проверить удаление, получите список группы бэкендов, выполнив команду:

     ```bash
     yc alb backend-group list
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с описанием группы бэкендов.

     Пример описания группы бэкендов в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя_группы_бэкендов>"

       http_backend {
         name                   = "<имя_бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор_целевой_группы>"]
         load_balancing_config {
           panic_threshold      = 90
         }    
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15 
           http_healthcheck {
             path               = "/"
           }
         }
       }
     }
     ```

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc alb backend-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/BackendGroup/delete.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Delete](../api-ref/grpc/backend_group_service.md#Delete).

{% endlist %}