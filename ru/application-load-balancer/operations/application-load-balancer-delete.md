# Удалить L7-балансировщик

Чтобы удалить L7-балансировщик:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.

     Чтобы выполнить это действие с несколькими балансировщиками, выделите нужные в списке и нажмите кнопку **Удалить** в нижней части экрана.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления балансировщика:

     ```bash
     yc alb load-balancer delete --help
     ```

  1. Выполните команду:

     ```bash
     yc alb load-balancer delete <идентификатор или имя балансировщика>
     ```

     Результат:

     ```bash
     done (1m10s)
     ```

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить L7-балансировщик, созданный с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием L7-балансировщика.

     {% cut "Пример описания L7-балансировщика в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "my-load-balancer"
       network_id  = yandex_vpc_network.test-network.id

       allocation_policy {
         location {
           zone_id   = "{{ region-id }}-a"
           subnet_id = yandex_vpc_subnet.test-subnet.id 
         }
       }

       listener {
         name = "my-listener"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [ 9000 ]
         }    
         http {
           handler {
             http_router_id = yandex_alb_http_router.test-router.id
           }
         }
       }    
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```bash
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```bash
     terraform plan
     ```

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer list
     ```

- API

  Воспользуйтесь методом REST API [delete](../api-ref/LoadBalancer/delete.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Delete](../api-ref/grpc/load_balancer_service.md#Delete).

{% endlist %}