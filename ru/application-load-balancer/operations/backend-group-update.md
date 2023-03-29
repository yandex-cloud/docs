---
title: "Как изменить группу бэкендов в {{ alb-full-name }}"
description: "Пошаговая инструкция по изменению группы бэкендов."
---

# Изменить группу бэкендов

## Изменить базовые параметры группы {#update-group}

{% list tabs %}

- Консоль управления
  
  {% note info %}

  Изменить [тип группы](../concepts/backend-group.md#group-types) можно только с помощью других инструментов: CLI, {{ TF }}, API.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана группа бэкендов.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Нажмите на имя нужной группы.
  1. Нажмите ![image](../../_assets/pencil.svg) **Редактировать**.
  1. Измените параметры группы:

     * **Имя** и **Описание** группы бэкендов.
     * **Привязка сессий** — опция, при которой запросы в рамках одной пользовательской сессии обрабатывает один и тот же эндпоинт. 
     
       {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

       Для группы бэкендов типа HTTP или gRPC доступны режимы:
       
       * `По IP-адресу`;
       * `По HTTP-заголовку`;
       * `По cookie`.
       
       Для типа Stream привязка сессий всегда работает по IP-адресу.
       
       Подробнее о привязке сессий и её режимах см. в [разделе](../concepts/backend-group.md#session-affinity).
   
  1. Внизу страницы нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения базовых параметров группы бэкендов:

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
       --connection-affinity source-ip=<true_или_false>
     ```

     Где:
     * `--name` — имя группы бэкендов.
     * `--new-name` — новое имя группы бэкендов. Требования к имени:

       {% include [name-format-2](../../_includes/name-format-2.md) %}

     * `--description` — описание группы бэкендов. Необязательный параметр.
     * `--labels key=value` — список меток в формате `ключ=значение`. Необязательный параметр.
     * `--connection-affinity source-ip=<true_или_false>` — режим [привязки сессий](../../application-load-balancer/concepts/backend-group.md#session-affinity) по IP-адресу (`source-ip`). Необязательный параметр. Также доступны режимы `--cookie-affinity` (по cookie) и `--header-affinity` (по HTTP-заголовку). Может быть указан только один из режимов. Если группа бэкендов [типа Stream](../concepts/backend-group#group-types), то режим привязки может быть только `--connection-affinity`.

       {% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

     Результат:

     ```
     id: ds7mi7mlqgctp95cotf0
     name: test-backend-group
     description: update
     folder_id: b1g6hif00bod2o410drm
     labels:
       bar: buz
       foo: buz
     http:
       backends:
       - name: backend1
         backend_weight: "2"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - ds75pc3146dhsesgqe8s
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
       connection:
         source_ip: true
     created_at: "2022-11-30T17:46:05.599491104Z"
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте конфигурационный файл {{ TF }} и измените фрагмент с описанием группы бэкендов:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name        = "<имя_группы_бэкендов>"
       description = "<описание_группы_бэкендов>"
       labels      = {
         new-label = "test-label"
       }
       session_affinity {
         connection {
           source_ip = <true_или_false>
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
       
       * `connection` — режим привязки сессий по IP-адресу (`source_ip`). Также доступны режимы `cookie` и `header`. Должен быть указан только один из режимов. Если группа бэкендов имеет тип Stream (состоит из ресурсов `stream_backend`), то привязка сессий может иметь только режим `connection`.

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

- API

  Чтобы изменить базовые параметры группы, воспользуйтесь методом REST API [update](../api-ref/BackendGroup/update.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Update](../api-ref/grpc/backend_group_service.md#Update).

{% endlist %}

## Добавить бэкенд в группу {#add-backend}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Нажмите на имя нужной группы.
  1. Нажмите кнопку ![image](../../_assets/plus.svg) **Добавить бэкенд**.
  1. В открывшемся окне задайте настройки бэкенда:
     
     {% include [backend-settings-console](../../_includes/application-load-balancer/backend-settings-console.md) %}
     
  1. Нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Добавьте в группу бэкенд и проверку состояния. Внутри группы все бэкенды должны быть одного [типа](../concepts/backend-group.md#group-types) — HTTP или Stream.

  {% cut "HTTP-бэкенд" %}

  Выполните команду:

  ```bash
  yc alb backend-group add-http-backend \
    --backend-group-name <имя бэкенд группы> \
    --name <имя добавляемого бэкенда> \
    --weight <вес бэкенда> \
    --port <порт бэкенда> \
    --target-group-id=<идентификатор целевой группы> \
    --panic-threshold 90 \
    --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15, \
    timeout=10s,interval=2s,host=your-host.com,path=/ping
  ```

  Где:
  * `--panic-threshold` — порог для режима паники.
  * `--http-healthcheck` — параметры проверки состояния ресурсов:
    * `port` — порт.
    * `healthy-threshold` — порог работоспособности.
    * `unhealthy-threshold` — порог неработоспособности.
    * `timeout` — таймаут.
    * `interval` — интервал.
    * `host` — адрес хоста.
    * `path` — путь.

  Результат:

  ```text
  id: a5dqkr2mk3rr799f1npa
  name: test-backend-group
  folder_id: aoe197919j8elpeg1lkp
  ...
          host: your-host.com
          path: /ping
  created_at: "2021-02-11T20:46:21.688940670Z"
  ```

  {% endcut %}

  {% cut "Stream-бэкенд" %}

  Выполните команду:

  ```bash
  yc alb backend-group add-stream-backend \
    --backend-group-name <имя бэкенд группы> \
    --name <имя добавляемого бэкенда> \
    --weight <вес бэкенда> \
    --port <порт бэкенда> \
    --target-group-id=<идентификатор целевой группы> \
    --panic-threshold 90 \
    --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15, \
    timeout=10s,interval=2s,host=your-host.com,path=/ping
  ```

  Где:
  * `--panic-threshold` — порог для режима паники.
  * `--http-healthcheck` — параметры проверки состояния ресурсов:
    * `port` — порт.
    * `healthy-threshold` — порог работоспособности.
    * `unhealthy-threshold` — порог неработоспособности.
    * `timeout` — таймаут.
    * `interval` — интервал.
    * `host` — адрес хоста.
    * `path` — путь.

  Результат:

  ```text
  id: ds77tero4f5h46l4e2gl
  name: test-backend-group
  folder_id: b1gu6g9ielh690at5bm7
  ...
          host: your-host.com
          path: /ping
  created_at: "2022-04-06T09:17:57.104324513Z"
  ```

  {% endcut %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и добавьте блок с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагмент с описанием группы бэкендов:

    ```hcl
    resource "yandex_alb_backend_group" "test-backend-group" {
      name                     = "<имя группы бэкендов>"

      http_backend {
        name                   = "<имя бэкенда>"
        weight                 = 1
        port                   = 80
        target_group_ids       = ["<идентификатор целевой группы>"]
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

    Где `yandex_alb_backend_group` — параметры группы бэкендов:
    * `name` — имя группы бэкендов.
    * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — HTTP, gRPC или Stream.

    Параметры бэкенда:
    * `name` — имя бэкенда.
    * `port` — порт бэкенда.
    * `weight` — вес бэкенда.
    * `target_group_ids` — идентификатор целевой группы. Получить список доступных целевых групп можно с помощью команды [CLI](../../cli/quickstart.md): `yc alb target-group list`.
    * `load_balancing_config` — параметры балансировки:
      * `panic_threshold` — порог для режима паники.
    * `healthcheck` — параметры проверки состояния:
      * `timeout` — таймаут.
      * `interval` — интервал.
      * `healthy_threshold` — порог работоспособности.
      * `unhealthy_threshold` — порог неработоспособности.
      * `http_healthcheck` — параметры проверки состояния типа HTTP: 
        * `path` — путь.

    Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb backend-group get --name <имя группы бэкендов>
     ```

- API

  Чтобы изменить базовые параметры группы, воспользуйтесь методом REST API [addBackend](../api-ref/BackendGroup/addBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/AddBackend](../api-ref/grpc/backend_group_service.md#AddBackend).

{% endlist %}

## Изменить параметры бэкенда в группе {#update-backend}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Нажмите на имя нужной группы.
  1. Напротив имени бэкенда нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. В открывшемся окне задайте настройки бэкенда. Подробнее о настройках см. [выше](#add-backend).
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения параметров бэкенда:

     ```bash
     yc alb backend-group update-<тип бэкенда>-backend --help
     ```

  1. Укажите новые параметры бэкенда в зависимости от его типа:

     {% cut "HTTP-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group update-http-backend \
       --backend-group-name <имя бэкенд группы> \
       --name <имя бэкенда> \
       --weight <вес бэкенда> \
       --port <порт бэкенда> \
       --target-group-id=<идентификатор целевой группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     Где:
     * `--panic-threshold` — порог для режима паники.
     * `--http-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат:

     ```text
     id: a5dqkr2mk3rr799f1npa
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     ...
             host: your-host.com
             path: /ping
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "Stream-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group update-stream-backend \
       --backend-group-name <имя бэкенд группы> \
       --name <имя бэкенда> \
       --weight <вес бэкенда> \
       --port <порт бэкенда> \
       --target-group-id=<идентификатор целевой группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     Где:
     * `--panic-threshold` — порог для режима паники.
     * `--http-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат:

     ```text
     id: ds77tero4f5h46l4e2gl
     name: test-backend-group
     folder_id: b1gu6g9ielh690at5bm7
     ...
             host: your-host.com
             path: /ping
     created_at: "2022-04-06T09:17:57.104324513Z"
     ```

     {% endcut %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и измените параметры блока с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагменте с описанием группы бэкендов:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя группы бэкендов>"

       http_backend {
         name                   = "<имя бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор целевой группы>"]
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

     Где `yandex_alb_backend_group` — параметры группы бэкендов:
     * `name` — имя группы бэкендов.
     * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — HTTP, gRPC или Stream.

     Параметры бэкенда:
     * `name` — имя бэкенда.
     * `port` — порт бэкенда.
     * `weight` — вес бэкенда.
     * `target_group_ids` — идентификатор целевой группы. Получить список доступных целевых групп можно с помощью команды [CLI](../../cli/quickstart.md): `yc alb target-group list`.
     * `load_balancing_config` — параметры балансировки:
       * `panic_threshold` — порог для режима паники.
     * `healthcheck` — параметры проверки состояния:
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `healthy_threshold` — порог работоспособности.
       * `unhealthy_threshold` — порог неработоспособности.
       * `http_healthcheck` — параметры проверки состояния типа HTTP: 
         * `path` — путь.

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb backend-group get --name <имя группы бэкендов>
     ```

- API

  Чтобы изменить параметры бэкенда в группе, воспользуйтесь методом REST API [updateBackend](../api-ref/BackendGroup/updateBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/UpdateBackend](../api-ref/grpc/backend_group_service.md#UpdateBackend).

{% endlist %}

## Удалить бэкенд из группы {#delete-backend}

Чтобы удалить бэкенд из группы:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Нажмите на имя нужной группы.
  1. Напротив имени бэкенда нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления бэкенда из группы:

     ```bash
     yc application-load-balancer delete-<тип бэкенда>-backend --help
     ```

  1. В зависимости от типа бэкенда выполните команду для удаления:
     * HTTP-бэкенд:

       ```bash
       yc alb backend-group delete-http-backend \
         --backend-group-name=<имя группы бэкендов> \
         --name=<имя удаляемого бэкенда>
       ```

     * Stream-бэкенд:

       ```bash
       yc alb backend-group delete-stream-backend \
         --backend-group-name=<имя группы бэкендов> \
         --name=<имя удаляемого бэкенда>
       ```

     Результат:

     ```text
     id: a5dqkr2mk3rr799f1npa
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и удалите блок с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагменте с описанием группы бэкендов.

     Пример описания группы бэкендов в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя группы бэкендов>"

       http_backend {
         name                   = "<имя бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор целевой группы>"]
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

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb backend-group get --name <имя группы бэкендов>
     ```

- API

  Воспользуйтесь методом REST API [removeBackend](../api-ref/BackendGroup/removeBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/RemoveBackend](../api-ref/grpc/backend_group_service.md#RemoveBackend).

{% endlist %}
