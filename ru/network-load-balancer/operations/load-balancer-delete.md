---
title: Удалить сетевой балансировщик
description: Следуя данной инструкции, вы сможете удалить сетевой балансировщик.
---

# Удалить сетевой балансировщик

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить балансировщик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. В строке балансировщика, который требуется удалить, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer delete --help
     ```

  1. Удалите балансировщик:

     ```bash
     yc load-balancer network-load-balancer delete <имя_или_идентификатор_балансировщика>
     ```

     Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить сетевой балансировщик, созданный с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием сетевого балансировщика.

     ```hcl
     ...
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_балансировщика>"
       listener {
         name = "<имя_обработчика>"
         port = <номер_порта>
         external_address_spec {
           ip_version = "<версия_IP-адреса>"
         }
       }
       attached_target_group {
         target_group_id = "<идентификатор_целевой_группы>"
         healthcheck {
           name = "<имя_проверки_состояния>"
             http_options {
               port = <номер_порта>
               path = "<адрес_URL>"
             }
         }
       }
     }
     ...
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Удалите сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы удалить сетевой балансировщик, воспользуйтесь методом REST API [delete](../api-ref/NetworkLoadBalancer/delete.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Delete](../api-ref/grpc/NetworkLoadBalancer/delete.md).

{% endlist %}

## Примеры {#examples}

### Удаление сетевого балансировщика из указанного каталога {from-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы удалить сетевой балансировщик из другого каталога, используйте параметры `--folder-id` или `--folder-name`:

  ```bash
  yc load-balancer network-load-balancer delete test-load-balancer \
     --folder-id=b1gnbfd11bq5********
  ```

  ```bash
  yc load-balancer network-load-balancer delete test-load-balancer \
     --folder-name=test-folder
  ```

{% endlist %}
