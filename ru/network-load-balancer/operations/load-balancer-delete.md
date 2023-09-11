# Удалить сетевой балансировщик

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить балансировщик.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. В строке балансировщика, который требуется удалить, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer delete --help
     ```

  1. Удалите балансировщик:

     ```bash
     yc load-balancer network-load-balancer delete <идентификатор или имя балансировщика>
     ```

     Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить сетевой балансировщик, созданный с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием сетевого балансировщика.

     ```hcl
     ...
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя сетевого балансировщика>"
       listener {
         name = "<имя обработчика>"
         port = <номер порта>
         external_address_spec {
           ip_version = "<версия IP-адреса: ipv4 или ipv6>"
         }
       }
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
     }
     ...
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Удалите сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Чтобы удалить сетевой балансировщик, воспользуйтесь методом REST API [delete](../api-ref/NetworkLoadBalancer/delete.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Delete](../api-ref/grpc/network_load_balancer_service.md#Delete).

{% endlist %}

## Примеры {examples}

### Удаление сетевого балансировщика из указанного каталога {from-folder}

{% list tabs %}

- CLI

  Чтобы удалить сетевой балансировщик из другого каталога, используйте параметры `--folder-id` или `--folder-name`:

  ```bash
  yc load-balancer network-load-balancer delete test-load-balancer \
     --folder-id=b1gnbfd11bq5g5vnjgr4
  ```

  ```bash
  yc load-balancer network-load-balancer delete test-load-balancer \
     --folder-name=test-folder
  ```

{% endlist %}
