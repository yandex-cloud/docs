# Изменить параметры HTTP-роутера

Чтобы изменить параметры HTTP-роутера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан HTTP-роутер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/router.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры роутера, виртуального хоста или маршрута.
  1. Внизу страницы нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения балансировщиков:

     ```bash
     yc alb http-router update --help
     ```

  1. Выполните команду, указав новые параметры роутера:

     ```bash
     yc alb http-router update <имя_HTTP-роутера> --new-name <новое_имя_HTTP-роутера>
     ```

     Результат:
     
          
     ```text
     id: a5dld80l32ed********
     name: new-http-router
     folder_id: aoe197919j8e********
     virtual_hosts:
     - name: test-virtual-host
       authority:
       - your-domain.foo.com
       routes:
       - name: test-route
         http:
           match:
             path:
               prefix_match: /
           route:
             backend_group_id: a5d4db973944********
             timeout: 2s
             idle_timeout: 3s
       modify_request_headers:
       - name: Accept-Language
         append: ru-RU
     created_at: "2021-02-11T21:31:01.676592016Z"
     ```

 

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием HTTP-роутера:

     ```hcl
     ...
     resource "yandex_alb_http_router" "tf-router" {
       name   = "my-http-router"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_alb_http_router` в {{ TF }} см. в [документации провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_http_router).

  1. Чтобы добавить, изменить или удалить виртуальные хосты HTTP-роутера, используйте ресурс `yandex_alb_virtual_host` с указанием на роутер в поле `http_router_id`:

     ```hcl
     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name           = "my-virtual-host"
       http_router_id = "${yandex_alb_http_router.tf-router.id}"
       route {
         name = "my-route"
         http_route {
           http_route_action {
             backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
             timeout          = "3s"
           }
         }
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_alb_virtual_host` в {{ TF }} см. в [документации провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_virtual_host).

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

     Проверить изменение HTTP-роутера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb http-router get <идентификатор_http-роутера>
     ```

- API

  Воспользуйтесь методом REST API [update](../api-ref/HttpRouter/update.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Update](../api-ref/grpc/http_router_service.md#Update).

{% endlist %}

## Добавить маршрут в виртуальный хост {#add-virtual-host}

Чтобы добавить новый маршрут в виртуальный хост HTTP-роутера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан HTTP-роутер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/router.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Задайте параметры маршрута и нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI 

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}
 
   Посмотрите описание команды CLI для работы с виртуальными хостами:
 
   ```bash
   yc alb virtual-host --help
   ```

   * **HTTP**

    
      Вы можете добавить новый маршрут в начало, в конец или в определенное место списка маршрутов хоста.
    
      **Добавить маршрут в конец списка маршрутов хоста**
    
      1. Посмотрите описание команды CLI для добавления маршрута в конец списка маршрутов хоста:

         ```bash
         yc alb virtual-host append-http-route --help
         ```
    
      1. Выполните команду:

         ```bash
         yc alb virtual-host append-http-route <имя_маршрута> \
           --virtual-host-name <имя_виртуального_хоста> \
           --http-router-name <имя_HTTP-роутера> \
           --match-http-method <метод_HTTP> \
           --exact-path-match / \
           --backend-group-name <имя_группы_бэкендов> \
           --request-timeout <тайм-аут_запроса>s \
           --request-idle-timeout <тайм-аут_ожидания_запроса>s
         ```

         Подробную информацию о параметрах команды `yc alb virtual-host append-http-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).

         Результат:

         ```text
         name: test-virtual-host
         authority:
         - your-domain.foo.com
         routes:
         - name: test-route
         ...
         - name: test-route-toend
           http:
             match:
               path:
                 prefix_match: /
             route:
               backend_group_id: a5d3e9ko2qf0********
               timeout: 2s
               idle_timeout: 3s
         ```
    
      **Добавить маршрут в начало списка маршрутов хоста**
    
      1. Посмотрите описание команды CLI для добавления маршрута в начало списка маршрутов хоста:

         ```bash
         yc alb virtual-host prepend-http-route --help
         ```
    
      1. Выполните команду:

         ```bash
         yc alb virtual-host prepend-http-route <имя_маршрута> \
           --virtual-host-name <имя_виртуального_хоста> \
           --http-router-name <имя_HTTP-роутера> \
           --match-http-method <метод_HTTP> \
           --exact-path-match / \
           --backend-group-name <имя_группы_бэкендов> \
           --request-timeout <тайм-аут_запроса>s \
           --request-idle-timeout <тайм-аут_ожидания_запроса>s
         ```

         Подробную информацию о параметрах команды `yc alb virtual-host prepend-http-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/prepend-http-route.md).

         Результат:

         ```text
         name: test-virtual-host
         authority:
         - your-domain.foo.com
         routes:
         - name: test-route-tostart
           http:
             match:
               http_method:
               - GET
               path:
                 exact_match: /
             route:
               backend_group_id: a5d3e9ko2qf0********
               timeout: 2s
               idle_timeout: 3s
         - name: test-route
         ...
         ```
    
      **Добавить маршрут перед определенным маршрутом**
    
      1. Посмотрите описание команды CLI для добавления маршрута перед определенным маршрутом:

         ```bash
         yc alb virtual-host insert-http-route --help
         ```
    
      1. Выполните команду:

         ```bash
         yc alb virtual-host insert-http-route <имя_маршрута> \
           --virtual-host-name <имя_виртуального_хоста> \
           --before <имя_маршрута_перед_которым_надо_поставить_новый_маршрут> \
           --http-router-name <имя_HTTP-роутера> \
           --match-http-method <метод_HTTP> \
           --exact-path-match / \
           --backend-group-name <имя_группы_бэкендов> \
           --request-timeout <тайм-аут_запроса>s \
           --request-idle-timeout <тайм-аут_ожидания_запроса>s
         ```

         Подробную информацию о параметрах команды `yc alb virtual-host insert-http-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/insert-http-route.md).

         Результат:

         ```text
         done (2s)
         name: test-virtual-host
         authority:
         - your-domain.foo.com
         routes:
         ...
         - name: test-route-insbefore
           http:
             match:
               http_method:
               - GET
               path:
                 exact_match: /
             route:
               backend_group_id: a5d3e9ko2qf0********
               timeout: 2s
               idle_timeout: 3s
         - name: test-route
         ...
         ```
    
      **Добавить маршрут после определенного маршрута**
    
       1. Посмотрите описание команды CLI для добавления нового маршрута после определенного маршрута:

          ```bash
          yc alb virtual-host insert-http-route --help
          ```
    
       1. Выполните команду:

           ```bash
           yc alb virtual-host insert-http-route <имя_маршрута> \
             --virtual-host-name <имя_виртуального_хоста> \
             --after <имя_маршрута_после_которого_надо_поставить_новый_маршрут> \
             --http-router-name <имя_HTTP-роутера> \
             --match-http-method <метод_HTTP> \
             --exact-path-match / \
             --backend-group-name <имя_группы_бэкендов> \
             --request-timeout <тайм-аут_запроса>s \
             --request-idle-timeout <тайм-аут_ожидания_запроса>s
           ```

           Подробную информацию о параметрах команды `yc alb virtual-host insert-http-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/insert-http-route.md).
    
           Результат:
    
           ```text
           done (2s)
           name: test-virtual-host
           authority:
           - your-domain.foo.com
           routes:
           - name: test-route
           ...
           - name: test-route-insafter
             http:
               match:
                 path:
                   prefix_match: /
               route:
                 backend_group_id: a5d3e9ko2qf0********
                 timeout: 2s
                 idle_timeout: 3s
           ...
           ```

   * **gRPC**

      Вы можете добавить новый маршрут в начало, в конец или в определенное место списка маршрутов хоста.
      
      **Добавить маршрут в конец списка маршрутов хоста**
      
      1. Посмотрите описание команды CLI для добавления маршрута в конец списка маршрутов хоста:

         ```bash
         yc alb virtual-host append-grpc-route --help
         ```
      
      1. Выполните команду:

         ```bash
         yc alb virtual-host append-grpc-route <имя_маршрута> \
           --virtual-host-name <имя_виртуального_хоста> \
           --http-router-name <имя_HTTP-роутера> \
           --prefix-fqmn-match /<первое_слово_названия_сервиса> \
           --backend-group-name <имя_группы_бэкендов> \
           --request-max-timeout <таймаут>s 
         ```

         Подробную информацию о параметрах команды `yc alb virtual-host append-grpc-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-grpc-route.md).

         Результат:

         ```text
         name: <имя_виртуального_хоста>
         authority:
         - *
         routes:
         - name: grpc-route
         ...
         - name: grpc-route-toend
           grpc:
             match:
               fqmn:
                prefix_match: /helloworld
             route:
               backend_group_id: ds7snban2dvn********
               max_timeout: 60s
               auto_host_rewrite: false
         ```
      
      **Добавить маршрут в начало списка маршрутов хоста**
      
      1. Посмотрите описание команды CLI для добавления маршрута в начало списка маршрутов хоста:

         ```bash
         yc alb virtual-host prepend-grpc-route --help
         ```
      
      1. Выполните команду:

         ```bash
         yc alb virtual-host prepend-grpc-route <имя_маршрута> \
           --virtual-host-name <имя_виртуального_хоста> \
           --http-router-name <имя_HTTP-роутера> \
           --prefix-fqmn-match /<первое_слово_названия_сервиса> \
           --backend-group-name <имя_группы_бэкендов> \
           --request-max-timeout <таймаут>s  
         ```

         Подробную информацию о параметрах команды `yc alb virtual-host prepend-grpc-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/prepend-grpc-route.md).

         Результат:

         ```text
         name: <имя_виртуального_хоста>
         authority:
         - *
         routes:
         - name: grpc-route-tostart
           grpc:
             match:
               fqmn:
                prefix_match: /helloworld
             route:
               backend_group_id: ds7snban2dvn********
               max_timeout: 60s
               auto_host_rewrite: false
         - name: grpc-route
         ...
         ```
      
      **Добавить маршрут перед определенным маршрутом**
      
      1. Посмотрите описание команды CLI для добавления маршрута перед определенным маршрутом:

         ```bash
         yc alb virtual-host insert-grpc-route --help
         ```
      
      1. Выполните команду:

         ```bash
         yc alb virtual-host insert-grpc-route <имя_маршрута> \
           --virtual-host-name <имя_виртуального_хоста> \
           --before <имя_маршрута_перед_которым_надо_поставить_новый_маршрут> \
           --http-router-name <имя_HTTP-роутера> \
           --prefix-fqmn-match /<первое_слово_названия_сервиса> \
           --backend-group-name <имя_группы_бэкендов> \
           --request-max-timeout <таймаут>s  
         ```

         Подробную информацию о параметрах команды `yc alb virtual-host insert-grpc-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/insert-grpc-route.md).

         Результат:

         ```text
         name: grpc-host
         authority:
         - *
         routes:       
         ...
         - name: grpc-route-before
           grpc:
             match:
               fqmn:
                prefix_match: /helloworld
             route:
               backend_group_id: ds7snban2dvn********
               max_timeout: 60s
               auto_host_rewrite: false
         - name: grpc-route
         ...
         ```
      
      **Добавить маршрут после определенного маршрута**
      
      1. Посмотрите описание команды CLI для добавления нового маршрута после определенного маршрута:

          ```bash
          yc alb virtual-host insert-grpc-route --help
          ```
      
      1. Выполните команду:

          ```bash
          yc alb virtual-host insert-grpc-route <имя_маршрута> \
            --virtual-host-name <имя_виртуального_хоста> \
            --after <имя_маршрута_после_которого_надо поставить_новый_маршрут> \
            --http-router-name <имя_HTTP-роутера> \
            --prefix-fqmn-match /<первое_слово названия_сервиса> \
            --backend-group-name <имя_группы_бэкендов> \
            --request-max-timeout <таймаут>s  
          ```

          Подробную информацию о параметрах команды `yc alb virtual-host insert-grpc-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/insert-grpc-route.md).

          Результат:
      
          ```text
          name: grpc-host
          authority:
          - *
          routes:       
          ...
          - name: grpc-route
          ...
          - name: grpc-route-after
             grpc:
            match:
               fqmn:
               prefix_match: /helloworld
            route:
               backend_group_id: ds7snban2dvn********
               max_timeout: 60s
               auto_host_rewrite: false
          ...
          ```

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием виртуального хоста, добавив блок `route`:

     ```hcl
     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name           = "my-virtual-host"
       http_router_id = "${yandex_alb_http_router.tf-router.id}"
       route {
         name = "my-route"
         http_route {
           http_route_action {
             backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
             timeout          = "3s"
           }
         }
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_alb_virtual_host` в {{ TF }} см. в [документации провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_virtual_host).

     Порядок маршрутов важен в описании виртуального хоста. Более подробную информацию см. в [концепции](../../application-load-balancer/concepts/http-router.md#virtual-host).

  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```text
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

     Проверить изменение виртуального хоста можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb virtual-host get <идентификатор_виртуального_хоста>
     ```

- API

  Воспользуйтесь методом REST API [update](../api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../api-ref/grpc/virtual_host_service.md#Update).

{% endlist %}

## Изменить порядок маршрутов в виртуальном хосте {#change-route-order}

Чтобы изменить порядок маршрутов HTTP-роутера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан HTTP-роутер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/router.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_routes-sort }}**.
  1. В открывшемся окне перетащите маршрут на новое место в списке.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Завершите редактирование роутера и нажмите **{{ ui-key.yacloud.common.save }}**.
  
- CLI 

   * **HTTP**
   
      1. Посмотрите описание команды CLI для удаления маршрута:

          ```bash
          yc application-load-balancer virtual-host remove-http-route --help
          ```
       
      1. Удалите маршрут:   

          ```bash
          yc alb virtual-host remove-http-route <имя_маршрута> \
            --virtual-host-name <имя_виртуального_хоста> \
            --http-router-name <имя_роутера>
          ```
      
      1. Добавьте маршрут в нужном месте одним из способов, описанных выше.   

   * **gRPC**
   
      1. Посмотрите описание команды CLI для удаления маршрута:

          ```bash
          yc application-load-balancer virtual-host remove-gRPC-route --help
          ```
       
      1. Удалите маршрут:   

          ```bash
          yc alb virtual-host remove-grpc-route <имя_маршрута> \
            --virtual-host-name <имя_виртуального_хоста> \
            --http-router-name  <имя_роутера>
          ```
      
      1. Добавьте маршрут в нужном месте одним из способов, описанных выше.   

- API

  Воспользуйтесь методом REST API [update](../api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../api-ref/grpc/virtual_host_service.md#Update).

{% endlist %}
