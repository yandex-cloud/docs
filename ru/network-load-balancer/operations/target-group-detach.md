---
title: "Отключить целевую группу от сетевого балансировщика"
description: "Следуя данной инструкции, вы сможете отключить целевую группу от сетевого балансировщика."
---

# Отключить целевую группу от сетевого балансировщика

{% list tabs %}

- Консоль управления

  Чтобы отключить [целевую группу](../concepts/target-resources.md) от сетевого балансировщика:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется отключить целевую группу от балансировщика.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Выберите балансировщик, от которого требуется отключить целевую группу.
  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_attached-target-groups }}** в строке с нужной целевой группой нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg).
  1. В открывшемся меню нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_detach-action }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_detach-action }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отключения целевой группы от сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer detach-target-group --help
     ```

  1. Отключите [целевую группу](../concepts/target-resources.md) от сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer detach-target-group <идентификатор или имя балансировщика> \
        --target-group-id=<идентификатор целевой группы>
     ```

     Идентификатор, имя балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы отключить [целевую группу](../concepts/target-resources.md) от сетевого балансировщика, созданного с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием целевой группы.

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя сетевого балансировщика>"
       ...
       attached_target_group {
         target_group_id = "<идентификатор целевой группы>"
         healthcheck {
           name = "<имя проверки состояния>"
           http_options {
             port = <номер порта>
             path = "<адрес URL, по которому будут выполняться проверки>"
           }
         }
       }
       ...
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Удалите сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Чтобы отключить целевую группу от сетевого балансировщика, воспользуйтесь методом REST API [detachTargetGroup](../api-ref/NetworkLoadBalancer/detachTargetGroup.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/DetachTargetGroup](../api-ref/grpc/network_load_balancer_service.md#DetachTargetGroup) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId`.
  * Идентификатор целевой группы в параметре `targetGroupId`.

  Идентификатор балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

{% endlist %}
