---
title: Как изменить группу бэкендов в {{ alb-full-name }}
description: Пошаговая инструкция по изменению группы бэкендов.
---

# Изменить группу бэкендов

## Изменить базовые параметры группы {#update-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% note info %}

  Изменить [тип группы](../concepts/backend-group.md#group-types) можно только с помощью других инструментов: [CLI](../../cli/), {{ TF }}, API.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создана [группа бэкендов](../concepts/backend-group.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите на имя нужной группы.
  1. Нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры группы:
     * **{{ ui-key.yacloud.common.name }}** и **{{ ui-key.yc-ui-datasphere.common.description }}** группы бэкендов.
     * **{{ ui-key.yacloud.alb.label_session-affinity }}** — опция, при которой запросы в рамках одной пользовательской сессии обрабатывает один и тот же эндпоинт.

       {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

       Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http }}` или `{{ ui-key.yacloud.alb.label_proto-grpc }}` доступны режимы:
       * `{{ ui-key.yacloud.alb.label_affinity-connection }}`.
       * `{{ ui-key.yacloud.alb.label_affinity-header }}`.
       * `{{ ui-key.yacloud.alb.label_affinity-cookie }}`.

       Для типа `{{ ui-key.yacloud.alb.label_proto-stream }}` привязка сессий всегда работает по [IP-адресу](../../vpc/concepts/address.md).

       Подробнее о привязке сессий и ее режимах см. в [разделе](../concepts/backend-group.md#session-affinity).
  1. Внизу страницы нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для изменения базовых параметров [группы бэкендов](../concepts/backend-group.md):

     ```bash
     yc alb backend-group update --help
     ```

  1. Выполните команду:

     ```bash
     yc alb backend-group update \
       --name <имя_группы_бэкендов> \
       --new-name <новое_имя_группы_бэкендов> \
       --description <описание_группы_бэкендов> \
       --labels key=value[,<ключ>=<значение_метки>] \
       --connection-affinity source-ip=<режим_привязки_сессий_по_IP-адресу>
     ```

     Где:
     * `--name` — имя группы бэкендов.
     * `--new-name` — новое имя группы бэкендов. Требования к имени:

       {% include [name-format-2](../../_includes/name-format-2.md) %}

     * `--description` — описание группы бэкендов. Необязательный параметр.
     * `--labels key=value` — список меток в формате `ключ=значение`. Необязательный параметр.
     * `--connection-affinity` — режим [привязки сессий](../../application-load-balancer/concepts/backend-group.md#session-affinity) по [IP-адресу](../../vpc/concepts/address.md) (`source-ip`). Может принимать значения `true` или `false`. Необязательный параметр. Также доступны режимы `--cookie-affinity` (по cookie) и `--header-affinity` (по HTTP-заголовку). Может быть указан только один из режимов. Если группа бэкендов [типа Stream](../concepts/backend-group#group-types), режим привязки может быть только `--connection-affinity`.

       {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

     Результат:

     ```text
     id: ds7mi7mlqgct********
     name: <имя_группы_бэкендов>
     description: update
     folder_id: b1g6hif00bod********
     labels:
       bar: buz
       foo: buz
     http:
       backends:
       - name: <имя_бэкенда>
         backend_weight: "2"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - ds75pc3146dh********
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: <адрес_хоста>
             path: <путь>
       connection:
         source_ip: true
     created_at: "2022-11-30T17:46:05.599491104Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и измените фрагмент с описанием [группы бэкендов](../concepts/backend-group.md):

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name        = "<имя_группы_бэкендов>"
       description = "<описание_группы_бэкендов>"
       labels      = {
         new-label = "test-label"
       }
       session_affinity {
         connection {
           source_ip = <режим_привязки_сессий_по_IP-адресу>
         }
       }
     ...
     }
     ```

     Где `yandex_alb_backend_group` — параметры группы бэкендов:
     * `name` — имя группы бэкендов.
     * `description` — описание группы бэкендов. Необязательный параметр.
     * `labels` — список меток в формате `ключ=значение`. Необязательный параметр.
     * `session_affinity` — настройки [привязки сессий](../../application-load-balancer/concepts/backend-group.md#session-affinity) (необязательный параметр).

       {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

       * `connection` — режим привязки сессий по [IP-адресу](../../vpc/concepts/address.md) (`source_ip`). Может принимать значения `true` или `false`. Также доступны режимы `cookie` и `header`. Должен быть указан только один из режимов. Если группа бэкендов имеет тип `Stream` (состоит из ресурсов `stream_backend`), то привязка сессий может иметь только режим `connection`.

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

- API {#api}

  Чтобы изменить базовые параметры [группы бэкендов](../concepts/backend-group.md), воспользуйтесь методом REST API [update](../api-ref/BackendGroup/update.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Update](../api-ref/grpc/backend_group_service.md#Update).

{% endlist %}

## Добавить бэкенд в группу {#add-backend}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите на имя нужной группы.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.alb.button_add-backend }}**.
  1. В открывшемся окне задайте настройки бэкенда:

     {% include [backend-settings-console](../../_includes/application-load-balancer/backend-settings-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Добавьте в группу бэкенд и проверку состояния.

  {% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

  Внутри группы все бэкенды должны быть одного [типа](../concepts/backend-group.md#group-types) — `HTTP` или `Stream`.

  {% cut "HTTP-бэкенд" %}

  Выполните команду:

  {% include [cli-code-http-backend-create](../../_includes/application-load-balancer/cli-code-http-backend-create.md) %}

  {% include [cli-http-where-legend](../../_includes/application-load-balancer/cli-http-where-legend.md) %}

  Результат:

  ```text
  id: a5dqkr2mk3rr********
  name: <имя_группы_бэкендов>
  folder_id: aoe197919j8e********
  ...
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
  ...
            grpc:
              service_name: <имя_gRPC-сервиса>
  ...
  created_at: "2021-02-11T20:46:21.688940670Z"
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
  ...
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

  1. Откройте конфигурационный файл {{ TF }} и добавьте блок с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагмент с описанием группы бэкендов:

     {% include [TF-update-code](../../_includes/application-load-balancer/TF-update-code.md) %}

     Где `yandex_alb_backend_group` — параметры группы бэкендов:
     * `name` — имя группы бэкендов.
     * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — `HTTP`, `gRPC` или `Stream`.

     {% include [TF-backend-settings](../../_includes/application-load-balancer/TF-backend-settings.md) %}

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

- API {#api}

  Чтобы изменить базовые параметры группы, воспользуйтесь методом REST API [addBackend](../api-ref/BackendGroup/addBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/AddBackend](../api-ref/grpc/backend_group_service.md#AddBackend).

{% endlist %}

## Изменить параметры бэкенда в группе {#update-backend}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите на имя нужной группы.
  1. Напротив имени бэкенда нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В открывшемся окне задайте настройки бэкенда. Подробнее о настройках см. [выше](#add-backend).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения параметров бэкенда:

     ```bash
     yc alb backend-group update-<тип_бэкенда>-backend --help
     ```

  1. Укажите новые параметры бэкенда в зависимости от его типа:

     {% cut "HTTP-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group update-http-backend \
       --backend-group-name <имя_группы_бэкендов> \
       --name <имя_добавляемого_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     {% include [cli-http-where-legend](../../_includes/application-load-balancer/cli-http-where-legend.md) %}

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_группы_бэкендов>
     folder_id: aoe197919j8e********
     ...
             host: <адрес_хоста>
             path: <путь>
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "gRPC-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group update-grpc-backend \
       --backend-group-name <имя_группы_бэкендов> \
       --name <имя_добавляемого_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --grpc-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,service-name=<имя_gRPC-сервиса>
     ```

     {% include [cli-gRPC-where-legend](../../_includes/application-load-balancer/cli-gRPC-where-legend.md) %}

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_группы_бэкендов>
     folder_id: aoe197919j8e********
     ...
               grpc:
                 service_name: <имя_gRPC-сервиса>
     ...
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "Stream-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group update-stream-backend \
       --backend-group-name <имя_группы_бэкендов> \
       --name <имя_добавляемого_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --enable-proxy-protocol \
       --stream-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,send-text=<данные_к_эндпоинту>,receive-text=<данные_от_эндпоинта>
     ```

     {% include [cli-Stream-where-legend](../../_includes/application-load-balancer/cli-Stream-where-legend.md) %}

     Результат:

     ```text
     id: ds77tero4f5********
     name: <имя_группы_бэкендов>
     folder_id: b1gu6g9ielh6********
     ...
                 text: <данные_к_эндпоинту>
               receive:
                 text: <данные_от_эндпоинта>
         enable_proxy_protocol: true
     created_at: "2022-04-06T09:17:57.104324513Z"
     ```

     {% endcut %}

     {% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и измените параметры блока с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагменте с описанием группы бэкендов:

     {% include [TF-update-code](../../_includes/application-load-balancer/TF-update-code.md) %}

     Где `yandex_alb_backend_group` — параметры группы бэкендов:
     * `name` — имя группы бэкендов.
     * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — `HTTP`, `gRPC` или `Stream`.

     {% include [TF-backend-settings](../../_includes/application-load-balancer/TF-backend-settings.md) %}

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

- API {#api}

  Чтобы изменить параметры бэкенда в группе, воспользуйтесь методом REST API [updateBackend](../api-ref/BackendGroup/updateBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/UpdateBackend](../api-ref/grpc/backend_group_service.md#UpdateBackend).

{% endlist %}

## Удалить бэкенд из группы {#delete-backend}

Чтобы удалить бэкенд из группы:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите на имя нужной группы.
  1. Напротив имени бэкенда нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления бэкенда из группы:

     ```bash
     yc application-load-balancer delete-<тип_бэкенда>-backend --help
     ```

  1. В зависимости от типа бэкенда выполните команду для удаления:
     * HTTP-бэкенд:

       ```bash
       yc alb backend-group delete-http-backend \
         --backend-group-name=<имя_группы_бэкендов> \
         --name=<имя_удаляемого_бэкенда>
       ```

     * gRPC-бэкенд:

       ```bash
       yc alb backend-group delete-grpc-backend \
         --backend-group-name=<имя_группы_бэкендов> \
         --name=<имя_удаляемого_бэкенда>
       ```

     * Stream-бэкенд:

       ```bash
       yc alb backend-group delete-stream-backend \
         --backend-group-name=<имя_группы_бэкендов> \
         --name=<имя_удаляемого_бэкенда>
       ```

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_бэкенда>
     folder_id: aoe197919j8e********
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и удалите блок с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагменте с описанием группы бэкендов.

     Пример описания группы бэкендов в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя_группы_бэкендов>"

       http_backend {
         name                   = "<имя_бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор_целевой_группы>"]
         load_balancing_config {
           panic_threshold      = 90
         }
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15
           http_healthcheck {
             path               = "/"
           }
         }
       }
     }
     ```

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

- API {#api}

  Воспользуйтесь методом REST API [removeBackend](../api-ref/BackendGroup/removeBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/RemoveBackend](../api-ref/grpc/backend_group_service.md#RemoveBackend).

{% endlist %}

### См. также {#see-also}

* [{#T}](../concepts/best-practices.md)