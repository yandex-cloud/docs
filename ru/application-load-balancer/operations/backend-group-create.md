---
title: "Как создать группу бэкендов в {{ alb-full-name }}"
description: "Следуя данной инструкции, вы сможете создать группу бэкендов."
---

# Создать группу бэкендов

Чтобы создать [группу бэкендов](../concepts/backend-group.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создаваться группа бэкендов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Введите имя группы бэкендов.
  1. Выберите [тип группы бэкендов](../concepts/backend-group.md#group-types):
     * `{{ ui-key.yacloud.alb.label_proto-http }}` — для HTTP- или HTTPS-трафика.
     * `{{ ui-key.yacloud.alb.label_proto-grpc }}` — для HTTP- или HTTPS-трафика с вызовами [gRPC](https://{{ lang }}.wikipedia.org/wiki/GRPC)-процедур.
     * `{{ ui-key.yacloud.alb.label_proto-stream }}` — для TCP-трафика без шифрования или с TLS-шифрованием.
  1. (Опционально) Включите [привязку сессий](../concepts/backend-group.md#session-affinity). Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http-plain }}` или `{{ ui-key.yacloud.alb.label_proto-grpc }}` доступны следующие режимы привязки:
     * `{{ ui-key.yacloud.alb.label_affinity-connection }}`.
     * `{{ ui-key.yacloud.alb.label_affinity-header }}`.
     * `{{ ui-key.yacloud.alb.label_affinity-cookie }}`.

     Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-stream }}` сессии привязываются по [IP-адресу](../../vpc/concepts/address.md) клиента.

     {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

  1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**. Задайте настройки бэкенда:

     {% include [backend-settings-console](../../_includes/application-load-balancer/backend-settings-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% note info %}

  Создать группу бэкендов типа `gRPC` можно в [консоли управления]({{ link-console-main }}) или с помощью {{ TF }}.

  {% endnote %}

  1. Посмотрите описание команды [CLI](../../cli/) для создания группы бэкендов:

     ```bash
     yc alb backend-group create --help
     ```

  1. Создайте группу бэкендов, выполнив команду:

     ```bash
     yc alb backend-group create <имя_группы_бэкендов>
     ```

     Результат:

     ```text
     id: a5dg2cv4ngne********
     name: test-backend-group
     folder_id: aoerb349v3h4********
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

  1. Добавьте в группу бэкенд и проверку состояния.

     {% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

     Внутри группы все бэкенды должны быть одного [типа](../concepts/backend-group.md#group-types) — `HTTP`, `gRPC` или `Stream`.

     {% cut "HTTP-бэкенд" %}

     Выполните команду:

     {% include [cli-code-http-backend-create](../../_includes/application-load-balancer/cli-code-http-backend-create.md) %}

     {% include [cli-http-where-legend](../../_includes/application-load-balancer/cli-http-where-legend.md) %}

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_группы_бэкендов>
     folder_id: aoe197919j8e********
     http:
       backends:
       - name: <имя_бэкенда>
         backend_weight: "1"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5d2iap3nue9********
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: <адрес_хоста>
             path: <путь>
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "gRPC-бэкенд" %}

     Выполните команду:

     {% include [cli-code-gRPC-backend-create](../../_includes/application-load-balancer/cli-code-gRPC-backend-create.md) %}

     {% include [cli-gRPC-where-legend](../../_includes/application-load-balancer/cli-gRPC-where-legend.md) %}

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_группы_бэкендов>
     folder_id: aoe197919j8e********
     grpc:
       backends:
         - name: <имя_бэкенда>
           backend_weight: "12"
           load_balancing_config:
             panic_threshold: "90"
           port: "80"
           target_groups:
             target_group_ids:
               - a5d2iap3nue9********
           healthchecks:
             - timeout: 10s
               interval: 2s
               healthy_threshold: "10"
               unhealthy_threshold: "15"
               healthcheck_port: "80"
               grpc:
                 service_name: <имя_gRPC_сервиса>
     created_at: "2023-06-17T13:04:08.567141292Z"
     ```

     {% endcut %}

     {% cut "Stream-бэкенд" %}

     Выполните команду:

     {% include [cli-code-Stream-backend-create](../../_includes/application-load-balancer/cli-code-Stream-backend-create.md) %}

     {% include [cli-Stream-where-legend](../../_includes/application-load-balancer/cli-Stream-where-legend.md) %}

     Результат:

     ```text
     id: ds77tero4f5********
     name: <имя_группы_бэкендов>
     folder_id: b1gu6g9ielh6********
     stream:
       backends:
       - name: <имя_бэкенда>
     backend_weight: "1"
         port: "80"
         target_groups:
           target_group_ids:
           - ds7eof3r2cte********
         healthchecks:
           - timeout: 10s
             interval: 2s
             healthy_threshold: "10"
             unhealthy_threshold: "15"
             healthcheck_port: "80"
             stream:
               send:
                 text: <данные_к_эндпоинту>
               receive:
                 text: <данные_от_эндпоинта>
         enable_proxy_protocol: true
     created_at: "2022-04-06T09:17:57.104324513Z"
     ```

     {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя_группы_бэкендов>"
       session_affinity {
         connection {
           source_ip = <режим_привязки_сессий_по_IP-адресу>
         }
       }
       stream_backend {
         name                   = "<имя_бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор_целевой_группы>"]
         load_balancing_config {
           panic_threshold      = 90
         }
         enable_proxy_protocol  = true
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15
           stream_healthcheck {
             send               = "<данные_к_эндпоинту>"
             receive            = "<данные_от_эндпоинта>"
           }
         }
       }
     }
     ```

     Где:
     * `yandex_alb_backend_group` — параметры группы бэкендов:
       * `name` — имя группы бэкендов.
       * `session_affinity` — настройки [привязки сессий](../../application-load-balancer/concepts/backend-group.md#session-affinity) (необязательный параметр).

         {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

         * `connection` — режим привязки сессий по [IP-адресу](../../vpc/concepts/address.md) (`source_ip`). Может принимать значения `true` или `false`. Также доступны режимы `cookie` и `header`. Должен быть указан только один из режимов. Если группа бэкендов имеет тип `Stream` (состоит из ресурсов `stream_backend`), то привязка сессий может иметь только режим `connection`.
       * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — `HTTP`, `gRPC` или `Stream`.

     {% include [TF-backend-settings](../../_includes/application-load-balancer/TF-backend-settings.md) %}

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc alb backend-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/BackendGroup/create.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Create](../api-ref/grpc/backend_group_service.md#Create).

{% endlist %}

### См. также {#see-also}

* [{#T}](../concepts/best-practices.md)