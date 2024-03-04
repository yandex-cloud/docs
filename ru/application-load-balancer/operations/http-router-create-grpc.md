---
title: "Как создать HTTP-роутер для gRPC-трафика в {{ alb-full-name }}"
description: "Следуя данной инструкции, вы сможете создать HTTP-роутер для gRPC-трафика." 
---

# Создать HTTP-роутер для gRPC-трафика

Чтобы создать [HTTP-роутер](../concepts/http-router.md) и добавить в него [маршрут](../concepts/http-router.md#routes):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В меню слева выберите **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Введите имя HTTP-роутера.
  1. В блоке **{{ ui-key.yacloud.alb.label_virtual-hosts }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Введите **{{ ui-key.yacloud.common.name }}**.
  1. В поле **{{ ui-key.yacloud.alb.label_authority }}** введите: `*` или [IP-адрес](../../vpc/concepts/address.md) балансировщика.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}** и выберите **{{ ui-key.yacloud.alb.label_route-type }}**: `{{ ui-key.yacloud.alb.label_proto-grpc }}`.
     1. Введите **{{ ui-key.yacloud.common.name }}**.
     1. В блоке **{{ ui-key.yacloud.alb.label_fqmn }}** выберите одну из опций:
        * `{{ ui-key.yacloud.alb.label_match-prefix }}` — для маршрутизации всех запросов, начинающихся с определенного FQMN. В поле ввода укажите `/<первое_слово_названия_сервиса>`, например: `/helloworld`.
        * `{{ ui-key.yacloud.alb.label_match-exact }}` — для маршрутизации всех запросов, совпадающих с указанным FQMN.
        * `{{ ui-key.yacloud.alb.label_match-regex }}` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax).

        {% note warning %}

        FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.

        {% endnote %}

     1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:
        * `{{ ui-key.yacloud.alb.label_route-action-route }}`:
          * В списке **{{ ui-key.yacloud.alb.label_backend-group }}** выберите имя [группы бэкендов](../concepts/backend-group.md) из того же каталога, в котором создаете HTTP-роутер.
          * (Опционально) В поле **{{ ui-key.yacloud.alb.label_host-rewrite }}** выберите одну из опций:
            * `none` — замена не происходит.
            * `rewrite` — происходит замена на указанное значение.
            * `auto` — происходит автоматическая замена на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
          * (Опционально) В поле **{{ ui-key.yacloud.alb.label_timeout }}** укажите максимальное время, на которое может быть установлено соединение.
          * (Опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время, в течение которого соединение может простаивать без передачи данных.
        * `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`:
          * В поле **{{ ui-key.yacloud.alb.label_grpc-status-code }}** выберите код, по которому будет осуществляться ответ.
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
     name: <имя_HTTP-роутера>
     folder_id: aoerb349v3h4********
     created_at: "2022-06-16T21:04:59.438292069Z"
     ```

  1. Посмотрите описание команды CLI для создания виртуального хоста:

     ```bash
     yc alb virtual-host create --help
     ```

  1. Создайте виртуальный хост, указав имя HTTP-роутера и настройки виртуального хоста:

     ```bash
     yc alb virtual-host create <имя_виртуального_хоста> \
       --http-router-name <имя_HTTP-роутера> \
       --authority *
     ```

     Где `--authority` — домены для заголовков `:authority`, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`.

     Результат:

     ```text
     done (1s)
     name: <имя_виртуального_хоста>
     authority:
     - *
     ```

  1. Посмотрите описание команды CLI для добавления маршрута:

     ```bash
     yc alb virtual-host append-grpc-route --help
     ```

  1. Добавьте маршрут, указав идентификатор или имя HTTP-роутера и параметры маршрутизации:

     ```bash
     yc alb virtual-host append-grpc-route <имя_маршрута> \
       --virtual-host-name <имя_виртуального_хоста> \
       --http-router-name <имя_HTTP-роутера> \
       --prefix-fqmn-match / \
       --backend-group-name <имя_группы_бэкендов> \
       --request-max-timeout 60s
     ```

     Где:
     * `--virtual-host-name` — имя виртуального хоста.
     * `--http-router-name` — имя HTTP-роутера.
     * `--prefix-fqmn-match` — параметр для маршрутизации всех запросов с определенным началом. После параметра укажите FQMN `/`.

       Также, чтобы задать условие для маршрутизации, вы можете использовать опции:
       * `--exact-fqmn-match` — для маршрутизации всех запросов, совпадающих с указанным FQMN. После параметра укажите `/<FQMN>/`.
       * `--regex-fqmn-match` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). После параметра укажите `/<регулярное_выражение>`.
     * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md).
     * `--request-max-timeout` — максимальный тайм-аут ожидания запроса, в секундах.

     Подробную информацию о параметрах команды `yc alb virtual-host append-grpc-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-grpc-route.md).

     Результат:

     ```text
     done (1s)
     name: <имя_виртуального_хоста>
     authority:
     - *
     routes:
     - name: <имя_маршрута>
       grpc:
        match:
          fqmn:
           prefix_match: /helloworld
        route:
          backend_group_id: ds7snban2dvn********
          max_timeout: 60s
     ```

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
       name                    = "<имя_виртуального_хоста>"
       http_router_id          = yandex_alb_http_router.tf-router.id
       route {
         name                  = "<имя_маршрута>"
         grpc_route {
           grpc_route_action {
             backend_group_id  = "<идентификатор_группы_бэкендов>"
             max_timeout       = "60s"
           }
         }
       }
     }
     ```

     Где:
     * `yandex_alb_http_router` — описание HTTP-роутера:
       * `name` — имя HTTP-роутера. Формат имени:

         {% include [name-format](../../_includes/name-format.md) %}

       * `labels` — [метки](../../resource-manager/concepts/labels.md) для HTTP-роутера. Укажите пару ключ — значение.
     * `yandex_alb_virtual_host` — описание виртуального хоста:
       * `name` — имя виртуального хоста. Формат имени:

         {% include [name-format](../../_includes/name-format.md) %}

       * `http_router_id` — идентификатор HTTP-роутера.
       * `grpc_route` — описание маршрута для gRPC-трафика:
         * `name` — имя маршрута.
         * `grpc_route_action` — параметр для указания действия с gRPC-трафиком.
           * `backend_group_id` — идентификатор [группы бэкэндов](../concepts/backend-group.md).
           * `max_timeout` — максимальный тайм-аут ожидания запроса, в секундах.

     Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
     * Ресурс [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
     * Ресурс [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Создайте ресурсы

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc alb http-router get <имя_HTTP-роутера>
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/HttpRouter/create.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Create](../api-ref/grpc/http_router_service.md#Create).

{% endlist %}