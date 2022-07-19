# Удалить сетевой балансировщик

{% list tabs %}

- Консоль управления
  
  Чтобы удалить [сетевой балансировщик](../concepts/index.md):
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить балансировщик.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. В строке балансировщика, который требуется удалить, нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите действие.
  
- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../../cli/quickstart.md#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для удаления сетевого балансировщика:
  
     ```
     yc load-balancer network-load-balancer delete --help
     ```
  
  1. Получите список всех балансировщиков:
  
     ```
     yc load-balancer network-load-balancer list
     ```
	 
	 Результат:
	 
	 ```
     +----------------------+--------------------+-------+
     |          ID          | NAME               |  ...  |
     +----------------------+------+-------------+-------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer |  ...  |
     ...
     +----------------------+------+-------------+-------+
     ```
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного балансировщика.
  1. Удалите балансировщик:
  
     ```
     yc load-balancer network-load-balancer delete b7r97ah2jn5rmo6k1dsk
     ```
  
  
- API
  
  Удалить сетевой балансировщик можно с помощью метода API [delete](../api-ref/NetworkLoadBalancer/delete.md).
  
- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить сетевой балансировщик, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием сетевого балансировщика.
     
     {% cut "Пример описания сетевого балансировщика в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "my-network-load-balancer"
       listener {
         name = "my-listener"
		 port = 9000
         external_address_spec {
           ip_version = "ipv4"
         }
       }
	   attached_target_group {
         target_group_id = "${yandex_lb_target_group.my-target-group.id}"
         healthcheck {
           name = "http"
             http_options {
               port = 9000
               path = "/ping"
             }
         }
       }
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc load-balancer network-load-balancer list
     ```

{% endlist %}

## Примеры {examples}

### Удаление сетевого балансировщика из указанного каталога {from-folder}

{% list tabs %}

- CLI
  
  Чтобы удалить сетевой балансировщик из другого каталога, используйте флаги `--folder-id` или `--folder-name`.
  
  ```
  yc load-balancer network-load-balancer delete test-load-balancer --folder-id b1gnbfd11bq5g5vnjgr4
  ```
  
  ```
  yc load-balancer network-load-balancer delete test-load-balancer --folder-name test-folder
  ```
  
{% endlist %}