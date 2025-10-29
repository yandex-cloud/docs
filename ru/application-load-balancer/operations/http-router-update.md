---
title: Как изменить параметры HTTP-роутера в {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете изменить параметры HTTP-роутера.
---

# Изменить параметры HTTP-роутера

Чтобы изменить параметры HTTP-роутера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан HTTP-роутер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры роутера, заголовка, виртуального хоста или маршрута.
  1. Внизу страницы нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

     Более подробную информацию о параметрах ресурса `yandex_alb_http_router` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_http_router).

  1. Чтобы добавить, изменить или удалить виртуальные хосты HTTP-роутера, используйте ресурс `yandex_alb_virtual_host` с указанием на роутер в поле `http_router_id`:

     ```hcl
     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name           = "my-virtual-host"
       http_router_id = "${yandex_alb_http_router.tf-router.id}"
       route {
         name                     = "my-route"
         disable_security_profile = true|false
         http_route {
           http_route_action {
             backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
             timeout          = "3s"
           }
         }
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_alb_virtual_host` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} изменит все требуемые ресурсы. Проверить изменение HTTP-роутера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb http-router get <идентификатор_http-роутера>
     ```

     {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/HttpRouter/update.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Update](../api-ref/grpc/HttpRouter/update.md).

{% endlist %}

## Добавить маршрут в виртуальный хост {#add-virtual-host}

Чтобы добавить новый маршрут в [виртуальный хост](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% include [route-create-complete-section](../../_includes/application-load-balancer/instruction-steps/route-create-complete-section.md) %}

## Изменить порядок маршрутов в виртуальном хосте {#change-route-order}

Чтобы изменить порядок маршрутов в [виртуальном хосте](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% include [reorder-routes-complete-section](../../_includes/application-load-balancer/instruction-steps/reorder-routes-complete-section.md) %}

## Изменить таймаут маршрута {#route-timeout}

Изменение таймаута доступно только для маршрутов с типом действия `{{ ui-key.yacloud.alb.label_route-action-route }}`.

Чтобы изменить таймаут маршрута HTTP-роутера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан HTTP-роутер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. В разделе **{{ ui-key.yacloud.alb.label_virtual-hosts }}** для нужного маршрута измените значение поля **{{ ui-key.yacloud.alb.label_timeout }}**.
  1. Внизу страницы нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения маршрута:

      ```bash
        yc alb virtual-host update-http-route --help
      ```

  1. Выполните команду:

      ```bash
      yc alb virtual-host remove-http-route <имя_маршрута> \
        --virtual-host-name <имя_виртуального_хоста> \
        --http-router-name <имя_роутера> \
        --request-timeout <таймаут>
      ```

      Где `--request-timeout` — новое значение таймаута с указанием единиц измерения времени, например `120s`.

      Результат:

      ```text
      name: host-one
      routes:
        - name: route-one
          http:
            match:
              path:
                prefix_match: /
            route:
              backend_group_id: ds7d6hg1dg24********
              timeout: 120s
              auto_host_rewrite: false
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените значение параметра `timeout` для нужного маршрута:

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

     Более подробную информацию о параметрах ресурса `yandex_alb_virtual_host` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение виртуального хоста можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb virtual-host get <идентификатор_виртуального_хоста>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md).

{% endlist %}