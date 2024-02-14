---
title: "Создать целевую группу {{ network-load-balancer-name }}"
description: "Следуя данной инструкции, вы сможете создать целевую группу {{ network-load-balancer-name }}."
---

# Создать целевую группу {{ network-load-balancer-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  Чтобы создать новую [целевую группу](../concepts/target-resources.md):
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать целевую группу.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.target-group.button_create }}**.
  1. Введите имя целевой группы. Требования к имени:
  
      {% include [name-format](../../_includes/name-format.md) %}
  
  1. Выберите [виртуальные машины](../../glossary/vm.md), которые нужно добавить в целевую группу.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания целевой группы:
  
     ```bash
     yc load-balancer target-group create --help
     ```

  1. Создайте целевую группу и добавьте в нее нужные виртуальные машины в качестве целевых ресурсов, указав параметры виртуальных машин в одном или нескольких параметрах `--target`:

     ```bash
     yc load-balancer target-group create <имя_целевой_группы> \
        --target subnet-id=<идентификатор_подсети>,`
                `address=<внутренний_IP-адрес_ВМ>
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса целевой группы.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_lb_target_group" "foo" {
       name      = "<имя_целевой_группы>"
       target {
         subnet_id = "<идентификатор_подсети>"
         address   = "<внутренний_IP-адрес_ресурса>"
       }
       target {
         subnet_id = "<идентификатор_подсети>"
         address   = "<внутренний_IP-адрес_ресурса_2>"
       }
     }
     ```

     * `name` — имя целевой группы.
     * `target` — описание целевого ресурса:
        * `subnet_id` — идентификатор подсети, к которой подключены целевые объекты. Все целевые объекты в целевой группе должны находится в пределах одной зоны доступности.
        * `address` — внутренний IP-адрес ресурса.

     Более подробную информацию о параметрах ресурса `yandex_lb_target_group` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_target_group).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте целевую группу.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы создать новую целевую группу, воспользуйтесь методом REST API [create](../api-ref/TargetGroup/create.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/Create](../api-ref/grpc/target_group_service.md#Create).
  
  После создания целевой группы следует добавить в нее целевые ресурсы, по которым будет распределяться нагрузка. Для этого воспользуйтесь методом REST API [addTargets](../api-ref/TargetGroup/addTargets) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/AddTargets](../api-ref/grpc/target_group_service.md#AddTargets).

{% endlist %}
