# Удалить L7-балансировщик

Чтобы удалить L7-балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан балансировщик.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Application Load Balancer**.
  1. Напротив имени нужного балансировщика нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.

     Чтобы выполнить это действие с несколькими балансировщиками, выделите нужные в списке и нажмите кнопку **Удалить** в нижней части экрана.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления балансировщика:

     ```bash
     yc alb load-balancer delete --help
     ```

  1. Выполните команду:

     ```bash
     yc alb load-balancer delete <имя_или_идентификатор_балансировщика>
     ```

     Результат:

     ```text
     done (1m10s)
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить L7-балансировщик, созданный с помощью Terraform:
  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием L7-балансировщика.

     {% cut "Пример описания L7-балансировщика в конфигурации Terraform" %}

     ```hcl
     ...
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "<имя_балансировщика>"
       network_id  = yandex_vpc_network.test-network.id

       allocation_policy {
         location {
           zone_id   = "ru-central1-a"
           subnet_id = yandex_vpc_subnet.test-subnet.id
         }
       }

       listener {
         name = "<имя_обработчика>"
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

  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.
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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer list
     ```

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с балансировщиками Application Load Balancer 10 минутами.
  
  Операции, которые длятся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию балансировщика блок `timeouts`, например:
  
  ```hcl
  resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
    ...
    timeouts {
      create = "60m"
      update = "60m"
      delete = "60m"
    }
  }
  ```
  
  {% endcut %}
  
  {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/LoadBalancer/delete.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Delete](../api-ref/grpc/LoadBalancer/delete.md).

{% endlist %}