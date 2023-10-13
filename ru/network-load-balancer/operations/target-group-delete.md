---
title: "Как удалить целевую группу в сетевом балансировщике"
description: "Перед удалением целевой группы ее необходимо отключить от сетевого балансировщика. После удаления целевую группу невозможно восстановить. Откройте раздел Load Balancer в каталоге, где требуется удалить целевую группу. В открывшемся меню нажмите кнопку Удалить."
---

# Удалить целевую группу {{ network-load-balancer-name }}

{% note alert %}

Перед удалением целевой группы ее необходимо отключить от сетевого балансировщика. После удаления целевую группу невозможно восстановить.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы удалить [целевую группу](../concepts/target-resources.md):
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить целевую группу.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/trgroups.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
  1. В строке целевой группы, которую требуется удалить, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg).
  1. В открывшемся меню выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления целевой группы:

     ```bash
     yc load-balancer target-group delete --help
     ```

  1. Удалите целевую группу из каталога по умолчанию:

     ```bash
     yc load-balancer target-group delete <идентификатора или имя целевой группы>
     ```

     Идентификатор и имя целевой группы можно получить со [списком целевых групп в каталоге](target-group-list.md#list).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить целевую группу, созданную с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием целевой группы.

     ```hcl
     resource "yandex_lb_target_group" "foo" {
       name      = "<имя целевой группы>"
       target {
         subnet_id = "<идентификатор подсети>"
         address   = "<внутренний IP-адрес ресурса>"
       }
       target {
         subnet_id = "<идентификатор подсети>"
         address   = "<внутренний IP-адрес ресурса 2>"
       }
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Удалите сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Чтобы удалить целевую группу, воспользуйтесь методом REST API [delete](../api-ref/TargetGroup/delete.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/Delete](../api-ref/grpc/target_group_service.md#Delete).

  Идентификатор целевой группы можно получить со [списком целевых групп в каталоге](target-group-list.md#list).

{% endlist %}