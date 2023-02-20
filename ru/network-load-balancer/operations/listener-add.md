# Добавить обработчик к сетевому балансировщику

{% list tabs %}

- Консоль управления
  
  Чтобы добавить [обработчик](../concepts/listener.md) к сетевому балансировщику:
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется добавить обработчик к балансировщику.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. В строке балансировщика, к которому нужно добавить обработчик, нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Добавить обработчик**.
  1. В открывшемся окне:
     
	 * Укажите порт, на котором обработчик будет принимать входящий трафик, из диапазона от 1 до 32767.
	 * Укажите целевой порт, на который балансировщик будет направлять трафик, из диапазона от 1 до 32767.
	 * Нажмите **Добавить**.
  
- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../../cli/quickstart.md#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы добавить обработчик к сетевому балансировщику:
  
  1. Получите список балансировщиков:
  
     {% if product == "yandex-cloud" %}
  
     ```
     yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     | c58r8boim8qfkcqtuioj | test-load-balancer | {{ region-id }} | EXTERNAL |              0 |                        | INACTIVE |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
  
     ```
     
     {% endif %}
     
     {% if product == "cloud-il" %}
  
     ```
     yc load-balancer network-load-balancer list
     +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        | REGION ID |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
     | c58r8boim8qfkcqtuioj | test-load-balancer | {{ region-id }}       | EXTERNAL |              0 |                        | INACTIVE |
     +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
  
     ```
     
     {% endif %}
  
  1. Добавьте обработчик, указав его имя, порт и версию IP-адреса:
  
     ```
     yc load-balancer network-load-balancer add-listener c580id04kvumgn7ssfh1 \
       --listener name=test-listener,port=80,external-ip-version=ipv4
     .....done
     id: c58r8boim8qfkcqtuioj
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2019-04-01T09:29:25Z"
     name: test-load-balancer
     region_id: {{ region-id }}
     status: INACTIVE
     type: EXTERNAL
     listeners:
     - name: test-listener
       address: <IP-адрес обработчика>
       port: "80"
       protocol: TCP
     ```
  
- API
  
  Добавить обработчик можно с помощью метода API [addListener](../api-ref/NetworkLoadBalancer/addListener.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `listener` в описании сетевого балансировщика:

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

     Где:

     * `name` — имя сетевого балансировщика. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `listener` — описание параметров [обработчика](../concepts/listener.md) для сетевого балансировщика:
        * `name` — имя обработчика. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

        * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик, из диапазона от 1 до 32767.
        * `external_address_spec` — описание внешнего IP-адреса. Укажите версию IP-адреса (ipv4 или ipv6). По умолчанию ipv4.
     * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
        * `target_group_id` — идентификатор целевой группы.
        * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от 1 до 32767 и путь, по которому будут выполняться проверки.

     Более подробную информацию о параметрах ресурса `yandex_lb_network_load_balancer` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/lb_network_load_balancer).

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

     Проверить изменение сетевого балансировщика можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc load-balancer network-load-balancer get <имя сетевого балансировщика>
     ```

{% endlist %}

## Примеры

### Добавление обработчика внутреннему сетевому балансировщику {#internal-listener}

{% list tabs %}

- CLI
  
  Выполните команду, указав имя обработчика, порт, идентификатор подсети и внутренний адрес из диапазона адресов подсети:
  
  ```
  yc load-balancer network-load-balancer add-listener b7rc2h753djb3a5dej1i \
    --listener name=test-listener,port=80,internal-subnet-id=e9b81t3kjmi0auoi0vpj,internal-address=10.10.0.14
  ```

- {{ TF }}

    1. Откройте файл конфигурации {{ TF }} и добавьте блок `listener` в описании внутреннего сетевого балансировщика:

       {% cut "Пример добавление обработчика внутреннему сетевому балансировщику с помощью {{ TF }}" %}

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
