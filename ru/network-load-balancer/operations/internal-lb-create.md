# Создать внутренний сетевой балансировщик


{% note warning %}

С 12 августа 2022 г. функциональность внутреннего балансировщика нагрузки становится [общедоступной](../../overview/concepts/launch-stages.md) и начнет [тарифицироваться](../pricing.md). 

{% endnote %}


{% note info %}

Обработчику внутреннего сетевого балансировщика назначается случайный IP-адрес из диапазона адресов выбранной подсети.

{% endnote %}

{% list tabs %}
  
- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../../cli/quickstart.md#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Перед созданием балансировщика [создайте](target-group-create.md) целевую группу, чтобы подключить ее к балансировщику.

  1. Посмотрите описание команды CLI для создания сетевого балансировщика:
  
     ```
     yc load-balancer network-load-balancer create --help
     ```
  
  1. Чтобы создать внутренний балансировщик с [обработчиком](../concepts/listener.md), выполните команду:
  
     ```
     yc load-balancer network-load-balancer create \
       --name internal-lb-test \
       --type internal \
       --region-id {{ region-id }} \
       --listener name=test-listener,port=80,internal-subnet-id=<идентификатор подсети>,internal-address=<внутренний IP-адрес из диапазона подсети>
     ```
  
  1. Получите список всех балансировщиков, чтобы убедиться, что балансировщик создан:
   
     ```
     yc load-balancer network-load-balancer list
     ```
  
- API
  
  Создать внутренний сетевой балансировщик можно с помощью метода API [create](../api-ref/NetworkLoadBalancer/create.md).

- {{ TF }} 

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

  Чтобы создать внутренний сетевой балансировщик с обработчиком: 
    
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     
     * `name` — имя сетевого балансировщика.
     * `type` — тип сетевого балансировщика. Используйте `internal`, чтобы создать внутренний балансировщик.
     * `listener` — параметры обработчика.
       * `name` — имя обработчика.
       * `port` — порт для приема трафика.
       * `internal_address_spec` — спецификация обработчика для внутреннего балансировщика.
         * `address` — внутренний IP-адрес из диапазона выбранной подсети. 
         * `subnet_id` — идентификатор подсети.

     Пример структуры конфигурационного файла:
     
     
     ```
     provider "yandex" {
         token     = "<OAuth или статический ключ сервисного аккаунта>"
         folder_id = "<идентификатор каталога>"
         zone      = "{{ region-id }}-a"
       }

     resource "yandex_lb_network_load_balancer" "internal-lb-test" {
       name = "internal-lb-test"
       type = "internal"

       listener {
         name = "my-listener"
         port = 8080
         internal_address_spec {
           address = "<внутренний IP-адрес>"
           subnet_id = "<идентификатор подсети>"
         }
       }
     ```


     
     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).
     
  1. Проверьте корректность конфигурационных файлов.
     
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:
        ```
        terraform plan
        ```
     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
        
  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:
        ```
        terraform apply
        ```
     1. Подтвердите создание ресурсов.
     
     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Примеры

### Создание внутреннего сетевого балансировщика без обработчика {#without-listener}

{% list tabs %}

- CLI
  
  Чтобы создать внутренний балансировщик без обработчика, выполните команду:
  
  ```
  yc load-balancer network-load-balancer create \
    --name internal-lb-test-1 \
    --type internal \
    --region-id {{ region-id }}
  ```

- {{ TF }}

    1. Опишите в конфигурационном файле параметры ресурса без блока `listener`:

       {% cut "Пример создания внутреннего сетевого балансировщика без обработчика с помощью {{ TF }}" %}

         ```
         resource "yandex_lb_network_load_balancer" "internal-lb-test" {
           name = "internal-lb-test"
           type = "internal"
         ```

       {% endcut %}

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/lb_network_load_balancer).

    1. Проверьте корректность конфигурационных файлов.

       1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
       1. Выполните проверку с помощью команды:

          ```
          terraform plan
          ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

       1. Если в конфигурации нет ошибок, выполните команду:

          ```
          terraform apply
          ```

       1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

          После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

          ```
          yc load-balancer network-load-balancer get <имя внутреннего сетевого балансировщика>
          ```

{% endlist %}

### Создание внутреннего сетевого балансировщика с обработчиком и подключенной целевой группой {#with-listener-and-target-group}

{% list tabs %}

- CLI
  
  1. Чтобы создать внутренний балансировщик с [обработчиком](../concepts/listener.md) и сразу подключить к нему целевую группу, получите список целевых групп:
  
     ```
     yc load-balancer target-group list
     ```
	 
	    Результат:
	 
	    	 
	    ```
     +----------------------+------------------+---------------------+-------------+--------------+
     |          ID          |       NAME       |       CREATED       |  REGION ID  | TARGET COUNT |
     +----------------------+------------------+---------------------+-------------+--------------+
     | b7rv80bfibkph3ekqqle | test-internal-tg | 2020-08-09 07:49:18 | {{ region-id }} |            3 |
     +----------------------+------------------+---------------------+-------------+--------------+
     ```
     
     
  
  1. Выполните команду:
  
     ```
     yc load-balancer network-load-balancer create \
       --name internal-lb-test-3 \
       --type internal \
       --region-id {{ region-id }} \
       --listener name=test-listener,port=80,internal-subnet-id=e9b81t3kjmi0auoi0vpj,internal-address=10.10.0.14 \
       --target-group target-group-id=b7rv80bfibkph3ekqqle,healthcheck-name=http,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
     ```

     Где `target-group-id` – идентификатор целевой группы.
     
	 Обратите внимание на формат параметров `healthcheck-interval` и `healthcheck-timeout`: необходимо указывать значение в формате `Ns`, где `N` — значение в секундах.

- {{ TF }}

    1. Чтобы создать внутренний сетевой балансировщик с [обработчиком](../concepts/listener.md), откройте файл конфигурации {{ TF }} и добавьте блок `listener` в описании внутреннего сетевого балансировщика. Чтобы подключить целевую группу, добавьте блок `attached_target_group` с указанием на целевую группу в поле `target_group_id`.

       {% cut "Пример создания внутреннего сетевого балансировщика с обработчиком и подключенной целевой группой с помощью {{ TF }}" %}

         ```
         resource "yandex_lb_network_load_balancer" "internal-lb-test" {
           name = "internal-lb-test"
           type = "internal"
           listener {
             name = "my-listener"
		     port = 9000
             internal_address_spec {
               subnet_id  = "b0cp4drld130kuprafls"
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
         ```

       {% endcut %}

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/lb_network_load_balancer).

    1. Проверьте корректность конфигурационных файлов.

       1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
       1. Выполните проверку с помощью команды:

          ```
          terraform plan
          ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

       1. Если в конфигурации нет ошибок, выполните команду:

          ```
          terraform apply
          ```

       1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

          После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

          ```
          yc load-balancer network-load-balancer get <имя внутреннего сетевого балансировщика>
          ```

{% endlist %}
