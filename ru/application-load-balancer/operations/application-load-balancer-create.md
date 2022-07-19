# Создать L7-балансировщик

Чтобы создать L7-балансировщик:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан балансировщик.

  1. В списке сервисов выберите **{{ alb-name }}**.

  1. Нажмите кнопку **Создать балансировщик** и выберите **Вручную**.

  1. Введите имя балансировщика: `test-load-balancer`.

  1. В блоке **Сетевые настройки** выберите сеть, в подсетях которой будут размещаться узлы балансировщика, и [подходящие группы безопасности](../concepts/application-load-balancer.md#security-groups) (если соответствующего поля нет, для балансировщика будет разрешен любой входящий и исходящий трафик).

  1. В блоке **Размещение** выберите три подсети для узлов балансировщика и включите передачу трафика в эти подсети.

  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:
     1. Введите имя обработчика: `test-listener`.
     1. (опционально) Включите опцию **Публичный IP-адрес**. Укажите **Порт**: `80` и выберите **Тип**:
        * `Автоматически`.
        * `Список` — в появившемся поле справа выберите адрес в выпадающем списке.
     1. (опционально) Включите опцию **Внутренний IP-адрес**. Укажите **Порт** и выберите **Подсеть** в выпадающем списке.
     1. В блоке **Прием и обработка трафика** выберите тип обработчика: `HTTP` или `Stream`.
     
        Для `HTTP` выберите:
        
        * Протокол: `HTTP`,`HTTPS` или `Перенаправлять на HTTPS`.
        * [HTTP-роутер](http-router-create.md) в выпадающем списке.
        
        Для `Stream` выберите протокол:
        
        * `Открытый`: выберите **Группы бэкендов** в выпадающем списке.
        * `Зашифрованный`: в блоке **Основной обработчик** выберите **Сертификаты** и **Группы бэкендов** в выпадающих списках.

  1. При необходимости добавьте дополнительные обработчики.

  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания L7-балансировщика:
     ```
     yc alb load-balancer create --help
     ```

  1. Выполните команду, указав сеть и подсети, в которых будут размещаться узлы балансировщика, а также [подходящие группы безопасности](../concepts/application-load-balancer.md#security-groups):
     ```
     yc alb load-balancer create <имя балансировщика> \
       --network-name <имя сети> \
       --location subnet-name=<имя подсети>,zone=<зона доступности>
     ```
     
     Опцию `--location` можно повторять несколько раз, чтобы указать разные зоны доступности и подсети.

     Результат:
     
          
     ```
     done (1m40s)
     id: a5d88ep483cmbfm63g9t
     name: test-balancer2
     folder_id: aoe197919j8elpeg1lkp
     status: ACTIVE
     region_id: {{ region-id }}
     network_id: c64l1c06d15178sa87k0
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-a
         subnet_id: buc4gsmpj8hvramg61g8
       - zone_id: {{ region-id }}-b
         subnet_id: blt6pcatjje62sqvjq5b
       - zone_id: {{ region-id }}-c
         subnet_id: fo2ap2nrhjk9vpfdnno8
     log_group_id: eolul9ap0bv02i8bsp87
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```
     

 
  1. Добавьте обработчик для L7-балансировщика:

     * HTTP-обработчик:

       1. Посмотрите описание команды CLI для добавления HTTP-обработчика L7-балансировщика:

          ```
          yc alb load-balancer add-listener --help
          ```

       1. Добавьте обработчик, выполнив команду:

          ```
          yc alb load-balancer add-listener <имя балансировщика> \
            --listener-name <имя обработчика> \
            --http-router-id <идентификатор HTTP-роутера> \
            --external-ipv4-endpoint port=<порт обработчика>
          ```

     * Stream-обработчик:

       1. Посмотрите описание команды CLI для добавления Stream-обработчика L7-балансировщика:

          ```
          yc alb load-balancer add-stream-listener --help
          ```

       1. Добавьте обработчик, выполнив команду:

          ```
          yc alb load-balancer add-stream-listener <имя балансировщика> \
            --listener-name=<имя обработчика> \
            --backend-group-id=<идентификатор группы бэкендов> \
            --external-ipv4-endpoint port=<порт обработчика>
          ```

     Результат после добавления двух обработчиков:
 
     ```
     done (42s)
     id: ds76g8b2op3fej12nab6
     name: test-load-balancer
     folder_id: b1gu6g9ielh690at5bm7
     status: ACTIVE
     network_id: enp0uulja5s3j1ftvfei
     listeners:
     - name: tslistener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 51.250.64.197
         ports:
         - "80"
       http:
         handler:
           http_router_id: ds7d7b14b3fsv7qjkvel
     - name: teststreamlistener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 51.250.64.197
         ports:
         - "443"
       stream:
         handler:
           backend_group_id: ds77tero4f5h46l4e2gl
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-a
         subnet_id: e9bs1hp7lgdl1g3n6ci1
       - zone_id: {{ region-id }}-b
         subnet_id: e2le8i7hqa216f6i6php
       - zone_id: {{ region-id }}-c
         subnet_id: b0cgk1au6fn203f3tqnf
     log_group_id: ckgs4u5km3u8j9f360md
     security_group_ids:
     - enp49ot04g63ih1scuap
     created_at: "2022-04-04T02:12:40.160629110Z"
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "<имя L7-балансировщика>"
       network_id  = "<идентификатор сети>"

       allocation_policy {
         location {
           zone_id   = "<зона доступности>"
           subnet_id = "<идентификатор подсети>" 
         }
       }

       listener {
         name = "<имя обработчика>"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [ 9000 ]
         }
         http {
           handler {
             http_router_id = "<идентификатор HTTP-роутера>"
           }
         }
       }
     }
     ```

     Где:

     * `name` — имя L7-балансировщика. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `network_id` — идентификатор сети.
     * `allocation_policy` — описание [расположения узлов](../../application-load-balancer/concepts/application-load-balancer.md#lb-location) L7-балансировщика. Укажите идентификаторы зоны доступности и подсети.
     * `listener` — описание параметров [обработчика](../../application-load-balancer/concepts/application-load-balancer.md#listener) для L7-балансировщика:
        * `name` — имя обработчика. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

        * `endpoint` — описание адресов и портов обработчика. Укажите внешний IPv4-адрес и порт для приема трафика. Если параметр `external_ipv4_address` не задан, то публичный адрес будет выделен автоматически.
        * `http` — описание HTTP-приемника для обработчика. Укажите идентификатор HTTP-роутера.

     Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/alb_load_balancer).

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
        yc alb load-balancer list
        ```

{% endlist %}
