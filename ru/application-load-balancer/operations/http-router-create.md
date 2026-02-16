---
title: Как создать HTTP-роутер для HTTP-трафика в {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете создать HTTP-роутер для HTTP-трафика.
---

# Создать HTTP-роутер для HTTP-трафика

Чтобы создать [HTTP-роутер](../concepts/http-router.md) и добавить в него [маршрут](../concepts/http-router.md#routes):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создаваться HTTP-роутер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Введите имя HTTP-роутера.
  1. В блоке **{{ ui-key.yacloud.alb.label_virtual-hosts }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. {% include [console-name-vh](../../_includes/application-load-balancer/instruction-steps/console-name-vh.md) %}
  1. (Опционально) В поле **{{ ui-key.yacloud.alb.label_authority }}** укажите значение заголовка `Host` для HTTP/1.1 или псевдо-заголовка `:authority` для HTTP/2, по которому будет выбираться виртуальный хост.

      {% include [console-no-authority-notice](../../_includes/application-load-balancer/instruction-steps/console-no-authority-notice.md) %}
  1. {% include [console-vh-form-sws-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-sws-step.md) %}
  1. {% include [console-vh-form-albnative-rl-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-albnative-rl-step.md) %}
  1. {% include [console-vh-form-header-mods-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-header-mods-step.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}** и в открывшейся форме **{{ ui-key.yacloud.alb.label_new-route }}**:

      1. {% include [console-update-http-route-naming-step](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-naming-step.md) %}
      1. {% include [console-update-http-route-ss1](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss1.md) %}
      1. {% include [console-update-http-route-ss2](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss2.md) %}
      1. {% include [console-update-http-route-ss3](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss3.md) %}
      1. {% include [console-update-http-route-ss4](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss4.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для создания HTTP-роутера:

      ```bash
      yc alb http-router create --help
      ```
  1. Выполните команду:

      ```bash
      yc alb http-router create <имя_HTTP-роутера>
      ```

      Результат:

      ```text
      id: a5dcsselagj4********
      name: test-http-router
      folder_id: aoerb349v3h4********
      created_at: "2021-02-11T21:04:59.438292069Z"
      ```
  1. {% include [cli-vh-create-help](../../_includes/application-load-balancer/instruction-steps/cli-vh-create-help.md) %}
  1. {% include [cli-vh-create](../../_includes/application-load-balancer/instruction-steps/cli-vh-create.md) %}
  1. {% include [cli-vh-append-http-route-help](../../_includes/application-load-balancer/instruction-steps/cli-vh-append-http-route-help.md) %}
  1. {% include [cli-vh-append-http-route-code](../../_includes/application-load-balancer/instruction-steps/cli-vh-append-http-route-code.md) %}

      Где:

      {% include [cli-http-route-creation-legend](../../_includes/application-load-balancer/instruction-steps/cli-http-route-creation-legend.md) %}

      {% include [cli-vh-append-http-route-output](../../_includes/application-load-balancer/instruction-steps/cli-vh-append-http-route-output.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры HTTP-роутера и виртуального хоста:

      ```hcl
      resource "yandex_alb_http_router" "tf-router" {
        name          = "<имя_HTTP-роутера>"
        labels        = {
          tf-label    = "tf-label-value"
          empty-label = ""
        }
      }

      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name           = "<имя_виртуального_хоста>"
        http_router_id = yandex_alb_http_router.tf-router.id

        rate_limit {
          all_requests {
            per_second = <количество_запросов_в_секунду>
            # или per_minute = <количество_запросов_в_минуту>
          }
          requests_per_ip {
            per_second = <количество_запросов_в_секунду>
            # или per_minute = <количество_запросов_в_минуту>
          }
        }

        route {
          name                      = "<имя_маршрута>"
          disable_security_profile  = true|false

          http_route {
            http_match {
              http_method = ["<HTTP-метод_1>","<HTTP-метод_2>",...,"<HTTP-метод_n>"]
              path {
                prefix = "/<префикс_пути_запроса>/"
                # или exact = "<путь_запроса>"
                # или regex = "<регулярное_выражение>"
              }
            }

            http_route_action {
              backend_group_id  = "<идентификатор_группы_бэкендов>"
              host_rewrite      = "<значение_заголовка_Host>"
              timeout           = "<таймаут_соединения>s"
              idle_timeout      = "<таймаут-простоя>s"
              prefix_rewrite    = "<новый_префикс_пути_запроса>/"
              rate_limit {
                all_requests {
                  per_second = <количество_запросов_в_секунду>
                  # или per_minute = <количество_запросов_в_минуту>
                }
                requests_per_ip {
                  per_second = <количество_запросов_в_секунду>
                  # или per_minute = <количество_запросов_в_минуту>
                }
              }
            }
          }
        }

        authority        = ["<домен_1>","<домен_2>",...,"<домен_n>"]

        modify_request_headers {
          name           = "<имя_заголовка>"
          append         = "<добавляемая_в_содержимое_заголовка_строка>"
          # или replace  = "<новое_содержимое_заголовка>"
          # или remove   = true|false
        }

        modify_response_headers {
          name           = "<имя_заголовка>"
          append         = "<добавляемая_в_содержимое_заголовка_строка>"
          # или replace  = "<новое_содержимое_заголовка>"
          # или remove   = true|false
        }

        route_options {
          security_profile_id = "<идентификатор_профиля_безопасности>"
        }
      }
      ```

      Где:

      * `yandex_alb_http_router` — описание HTTP-роутера:
          * `name` — имя HTTP-роутера. Формат имени:

              {% include [name-format](../../_includes/name-format.md) %}

          * `labels` — [метки](../../resource-manager/concepts/labels.md) для HTTP-роутера. Укажите пару ключ-значение.
      * `yandex_alb_virtual_host` — описание виртуального хоста:

          {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

          * `route` — описание маршрута виртуального хоста:

              {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

              {% include [tf-vh-create-legend-route-http](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-http.md) %}

          {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
      * [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router)
      * [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host)
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
        
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc alb http-router get <имя_HTTP-роутера>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/HttpRouter/create.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Create](../api-ref/grpc/HttpRouter/create.md).

{% endlist %}