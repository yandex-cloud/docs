# Изменить параметры HTTP-роутера

Чтобы изменить параметры HTTP-роутера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан HTTP-роутер.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/router.svg) **HTTP-роутеры**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **Редактировать**.
  1. Измените параметры роутера.
  1. Внизу страницы нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения балансировщиков:
     ```
     yc alb http-router update --help
     ```

  1. Выполните команду, указав новые параметры роутера:
     ```
     yc alb http-router update <имя HTTP-роутера> --new-name <новое имя HTTP-роутера>
     ```

     Результат:
     ```
     id: a5dld80l32edg407nsti
     name: new-http-router
     folder_id: aoe197919j8elpeg1lkp
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
             backend_group_id: a5d4db973944t2fh8gor
             timeout: 2s
             idle_timeout: 3s
       modify_request_headers:
       - name: Accept-Language
         append: ru-RU
     created_at: "2021-02-11T21:31:01.676592016Z"
     ```

- Terraform

  Подробнее о Terraform [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием HTTP-роутера:

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

     Более подробную информацию о параметрах ресурса `yandex_alb_http_router` в Terraform см. в [документации провайдера]({{ tf-provider-link }}/alb_http_router).

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

     Более подробную информацию о параметрах ресурса `yandex_alb_virtual_host` в Terraform см. в [документации провайдера]({{ tf-provider-link }}/alb_virtual_host).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение HTTP-роутера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc alb http-router get <идентификатор http-роутера>
     ```

{% endlist %}

## Добавить маршрут в виртуальный хост {#add-virtual-host}

Чтобы добавить новый маршрут в виртуальный хост HTTP-роутера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан HTTP-роутер.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/router.svg) **HTTP-роутеры**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **Редактировать**.
  1. Нажмите кнопку **Добавить маршрут**.
  1. Задайте параметры маршрута и нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите описание команды CLI для работы с виртуальными хостами:

  ```
  yc alb virtual-host --help
  ```

  Вы можете добавить новый маршрут в начало, в конец или в определенное место списка маршрутов хоста.

  **Добавить маршрут в конец списка маршрутов хоста**

  1. Посмотрите описание команды CLI для добавления маршрута в конец списка маршрутов хоста:
     ```
     yc alb virtual-host append-http-route --help
     ```

  1. Выполните команду:
     ```
     yc alb virtual-host append-http-route <имя маршрута> \
       --virtual-host-name <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --match-http-method GET \
       --exact-path-match / \
       --backend-group-name <имя группы бэкендов> \
       --request-timeout <тайм-аут запроса>s \
       --request-idle-timeout <тайм-аут ожидания запроса>s
     ```

     Результат:
     ```
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     routes:
     - name: test-route
       http:
         match:
           path:
             prefix_match: /
         route:
           backend_group_id: a5d3e9ko2qf0tbk0s27b
           timeout: 2s
           idle_timeout: 3s
     - name: test-route-toend
     ...
     ```

  **Добавить маршрут в начало списка маршрутов хоста**

  1. Посмотрите описание команды CLI для добавления маршрута в начало списка маршрутов хоста:
     ```
     yc alb virtual-host prepend-http-route --help
     ```

  1. Выполните команду:
     ```
     yc alb virtual-host prepend-http-route <имя маршрута> \
       --virtual-host-name <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --match-http-method GET \
       --exact-path-match / \
       --backend-group-name <имя группы бэкендов> \
       --request-timeout <тайм-аут запроса>s \
       --request-idle-timeout <тайм-аут ожидания запроса>s
     ```

     Результат:
     ```
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
           backend_group_id: a5d3e9ko2qf0tbk0s27b
           timeout: 2s
           idle_timeout: 3s
     - name: test-route
     ...
     ```

  **Добавить маршрут перед определенным маршрутом**

  1. Посмотрите описание команды CLI для добавления маршрута перед определенным маршрутом:
     ```
     yc alb virtual-host insert-http-route --help
     ```

  1. Выполните команду:
     ```
     yc alb virtual-host insert-http-route <имя маршрута> \
       --virtual-host-name <имя виртуального хоста> \
       --before <имя маршрута, перед которым надо поставить новый маршрут> \
       --http-router-name <имя HTTP-роутера> \
       --match-http-method GET \
       --exact-path-match / \
       --backend-group-name <имя группы бэкендов> \
       --request-timeout <тайм-аут запроса>s \
       --request-idle-timeout <тайм-аут ожидания запроса>s
     ```

     Результат:
     ```
     done (2s)
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     routes:
     - name: test-route-insbefore
       http:
         match:
           http_method:
           - GET
           path:
             exact_match: /
         route:
           backend_group_id: a5d3e9ko2qf0tbk0s27b
           timeout: 2s
           idle_timeout: 3s
     - name: test-route
     ...
     ```

  **Добавить маршрут после определенного маршрута**

   1. Посмотрите описание команды CLI для добавления нового маршрута после определенного маршрута:
      ```
      yc alb virtual-host insert-http-route --help
      ```

   1. Выполните команду:
      ```
      yc alb virtual-host insert-http-route <имя маршрута> \
        --virtual-host-name <имя виртуального хоста> \
        --after <имя маршрута, после которого надо поставить новый маршрут> \
        --http-router-name <имя HTTP-роутера> \
        --match-http-method GET \
        --exact-path-match / \
        --backend-group-name <имя группы бэкендов> \
        --request-timeout <тайм-аут запроса>s \
        --request-idle-timeout <тайм-аут ожидания запроса>s
      ```

      Результат:

      ```
      done (2s)
      name: test-virtual-host
      authority:
      - your-domain.foo.com
      routes:
      - name: test-route
        http:
          match:
            path:
              prefix_match: /
          route:
            backend_group_id: a5d3e9ko2qf0tbk0s27b
            timeout: 2s
            idle_timeout: 3s
      - name: test-route-insafter
      ...
      ```

- Terraform

  Подробнее о Terraform [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием виртуального хоста, добавив блок `route`:

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

     Более подробную информацию о параметрах ресурса `yandex_alb_virtual_host` в Terraform см. в [документации провайдера]({{ tf-provider-link }}/alb_virtual_host).

     Порядок маршрутов важен в описании виртуального хоста. Более подробную информацию см. в [концепции](../../application-load-balancer/concepts/http-router.md#virtual-host).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение виртуального хоста можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc alb virtual-host get <идентификатор виртуального хоста>
     ```

{% endlist %}
