# Удалить группу бэкендов

{% note warning %}

{% include [backend-group-deletion-restriction](../../_includes/application-load-balancer/backend-group-deletion-restriction.md) %}

{% endnote %}

Чтобы удалить группу бэкендов:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана группа бэкендов.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Напротив имени группы бэкендов нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.

     Чтобы выполнить это действие с несколькими группами, выделите нужные в списке и нажмите кнопку **Удалить** в нижней части экрана.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления группы бэкендов:

     ```bash
     yc alb backend-group delete --help
     ```

  1. Выполните команду, указав имя удаляемой группы бэкендов:

     ```bash
     yc alb backend-group delete --name <имя группы бэкендов>
     ```

     Чтобы проверить удаление, получите список группы бэкендов, выполнив команду:

     ```bash
     yc alb backend-group list
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с описанием группы бэкендов.

     Пример описания группы бэкендов в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя группы бэкендов>"

       http_backend {
         name                   = "<имя бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор целевой группы>"]
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

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb backend-group list
     ```

- API

  Воспользуйтесь методом REST API [delete](../api-ref/BackendGroup/delete.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Delete](../api-ref/grpc/backend_group_service.md#Delete).

{% endlist %}