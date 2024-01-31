---
title: "Как получить информацию об HTTP-роутере в {{ alb-full-name }}"
---

# Получить информацию об HTTP-роутере

Вы можете посмотреть идентификатор роутера, его хосты, а также маршруты в хостах.

Чтобы получить информацию об HTTP-роутере:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится роутер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Выберите HTTP-роутер.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация об  HTTP-роутере.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об HTTP-роутере:

      ```bash
      yc alb http-router get --help
      ```

  1. Получите информацию об HTTP-роутере, указав его идентификатор или имя:

      ```bash
      yc alb http-router get <имя_HTTP-роутера>
      ```

      Результат:

      ```bash
      id: ds7u8nv8gl2s********
      name: alb-router
      folder_id: b1geoelk7fld********
      virtual_hosts:
        - name: alb-host
          authority:
            - www.first-site.ru
            - first-site.ru
          routes:
            - name: route-1
              http:
                route:
                  backend_group_id: ds7maho6c4or********
      created_at: "2023-10-24T12:20:44.091821711Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию об HTTP-роутере с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_alb_http_router" "tf-router" {
        http_router_id = "<идентификатор_http-роутера>"
      }

      output "tf-router-name" {
        value = data.yandex_alb_http_router.tf-router.name
      }
      ```

      Где:

      * `data "yandex_alb_http_router"` — описание HTTP-роутера в качестве источника данных:
         * `http_router_id` — идентификатор HTTP-роутера.
      * `output "tf-router-name"` — выходная переменная, которая содержит имя HTTP-роутера:
         * `value` — возвращаемое значение.
       
     Вместо `name` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_alb_http_router` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_alb_http_router).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст HTTP-роутер и отобразит значения выходной переменной в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      tf-router-name = "myrouter"
      ```

- API {#api}

  Чтобы получить подробную информацию об HTTP-роутере, воспользуйтесь методом REST API [get](../api-ref/HttpRouter/get.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Get](../api-ref/grpc/http_router_service.md#Get).

{% endlist %}
