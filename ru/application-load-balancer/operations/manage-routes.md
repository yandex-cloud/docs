---
title: Как управлять маршрутами HTTP-роутера в {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете создавать, изменять и удалять маршруты в виртуальном хосте HTTP-роутера в {{ alb-full-name }}.
---

# Управлять маршрутами

[Маршруты](../concepts/http-router.md) состоят из набора условий (предиката), на основании которых [балансировщик](../concepts/application-load-balancer.md) выбирает дальнейшее направление для запроса, и действия над ним. Доступные условия и действия зависят от [типа маршрута](../concepts/http-router.md#routes-types).

## Создать маршрут {#create-route}

Чтобы создать маршрут в [виртуальном хосте](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% include [route-create-complete-section](../../_includes/application-load-balancer/instruction-steps/route-create-complete-section.md) %}

## Изменить маршрут {#update-route}

Чтобы изменить маршрут в [виртуальном хосте](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете изменять маршрут виртуального хоста.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором находится нужный маршрут.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с виртуальным хостом, в котором находится нужный маршрут, в строке с именем нужного маршрута нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне, в зависимости от [типа](../concepts/http-router.md#routes-types) маршрута:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        1. {% include [console-update-http-route-ss1](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss1.md) %}
        1. {% include [console-update-http-route-ss2](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss2.md) %}
        1. {% include [console-update-http-route-ss3](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss3.md) %}
        1. {% include [console-update-http-route-ss4](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss4.md) %}

      - gRPC {#grpc}

        1. {% include [console-update-grpc-route-ss1](../../_includes/application-load-balancer/instruction-steps/console-update-grpc-route-ss1.md) %}
        1. {% include [console-update-grpc-route-ss2](../../_includes/application-load-balancer/instruction-steps/console-update-grpc-route-ss2.md) %}
        1. {% include [console-update-grpc-route-ss3](../../_includes/application-load-balancer/instruction-steps/console-update-grpc-route-ss3.md) %}

      {% endlist %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  С помощью {{ yandex-cloud }} CLI вы можете изменять в виртуальном хосте разные [типы](../concepts/http-router.md#routes-types) маршрутов:

  {% list tabs group=alb_route_type%}

  - HTTP {#http}

    1. Посмотрите описание команды CLI для изменения маршрута виртуального хоста:

        ```bash
        yc alb virtual-host update-http-route --help
        ```
    1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
    1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
    1. Чтобы получить список маршрутов в виртуальном хосте, выполните команду, указав в ней имя виртуального хоста и имя или идентификатор HTTP-роутера соответственно в параметре `--http-router-name` или `--http-router-id`:

        ```bash
        yc alb virtual-host get <имя_виртуального_хоста> \
          --http-router-name <имя_HTTP-роутера> \
          --http-router-id <идентификатор_HTTP-роутера>
        ```

        {% cut "Результат:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-route
            http:
              match:
                path:
                  prefix_match: /
              route:
                backend_group_id: ds7dnf2s5dco********
                timeout: 60s
                auto_host_rewrite: false
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

    1. Измените маршрут, указав его имя и дополнительные параметры:

        ```bash
        yc alb virtual-host update-http-route <имя_маршрута> \
          --http-router-name <имя_HTTP-роутера> \
          --virtual-host-name <имя_виртуального_хоста> \
          --match-http-method <метод_1>,<метод_2>,...<метод_n> \
          --exact-path-match <полный_путь> \
          --prefix-path-match <префикс_пути> \
          --regex-path-match <регулярное_выражение> \
          --backend-group-name <имя_группы_бэкендов> \
          --request-timeout <таймаут_запроса>s \
          --request-idle-timeout <таймаут_ожидания_запроса>s \
          --rate-limit rps=<лимит_запросов>,requests-per-ip \
          --disable-security-profile
        ```

        Где:

        * `--http-router-name` — имя HTTP-роутера, в котором находится маршрут.

            Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
        * `--virtual-host-name` — имя виртуального хоста, в котором находится маршрут.
        * `--match-http-method` — список HTTP-[методов](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми необходимо маршрутизировать. Например: `--match-http-method GET,POST,OPTIONS`.

            Чтобы очистить заданный для маршрута список HTTP-методов, передайте в команде параметр `--clear-method-match`.
        * Параметры с условиями маршрутизации на основе пути:

            * `--exact-path-match` — маршрутизировать запросы, путь в которых идентичен заданному пути. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
            * `--prefix-path-match` — маршрутизировать запросы, путь в которых начинается с заданного префикса. Например: `/myapp/`.
            * `--regex-path-match` — маршрутизировать запросы, путь в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}\/`.

            {% note info %}

            Параметры `--exact-path-match`, `--prefix-path-match` и `--regex-path-match` — взаимоисключающие: вы можете использовать только один из них.

            {% endnote %}

            Чтобы очистить заданные для маршрута условия маршрутизации на основе пути, передайте в команде параметр `--clear-path-match`.

        * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md), виртуальный хост и маршрут.
        
            Вместо имени группы бэкендов вы можете указать ее идентификатор в параметре `--backend-group-id`.
        * `--request-timeout` — максимальное время в секундах, на которое может быть установлено соединение по запросу.

            Чтобы очистить заданное для маршрута максимальное время соединения, передайте в команде параметр `--clear-request-timeout`.
        * `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.

            Чтобы очистить заданное для маршрута максимальное время простоя, передайте в команде параметр `--clear-idle-timeout`.
        * {% include [cli-route-creation-rate-limit](../../_includes/application-load-balancer/instruction-steps/cli-route-creation-rate-limit.md) %}

            Чтобы очистить заданные для маршрута настройки частоты запросов, передайте в команде параметр `--clear-rate-limit`.
        * {% include [cli-route-creation-disable-security-profile](../../_includes/application-load-balancer/instruction-steps/cli-route-creation-disable-security-profile.md) %}

            Чтобы включить для маршрута профиль безопасности, который был отключен ранее, передайте в команде параметр `--disable-security-profile=false`.


        {% cut "Результат:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-route
            http:
              match:
                http_method:
                  - POST
                  - PATCH
                path:
                  exact_match: /
              route:
                backend_group_id: ds7dnf2s5dco********
                timeout: 12s
                idle_timeout: 6s
                host_rewrite: myapp
                prefix_rewrite: yourapp/
                rate_limit:
                  requests_per_ip:
                    per_second: "5"
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          modify_response_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "5"
            requests_per_ip:
              per_second: "3"
        ```

        {% endcut %}

        Подробную информацию о команде `yc alb virtual-host update-http-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update-http-route.md).

  - gRPC {#grpc}

    1. Посмотрите описание команды CLI для изменения маршрута виртуального хоста:

        ```bash
        yc alb virtual-host update-grpc-route --help
        ```
    1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
    1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
    1. Чтобы получить список маршрутов в виртуальном хосте, выполните команду, указав в ней имя виртуального хоста и имя или идентификатор HTTP-роутера соответственно в параметре `--http-router-name` или `--http-router-id`:

        ```bash
        yc alb virtual-host get <имя_виртуального_хоста> \
          --http-router-name <имя_HTTP-роутера> \
          --http-router-id <идентификатор_HTTP-роутера>
        ```

        {% cut "Результат:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-route
            grpc:
              match:
                fqmn:
                  prefix_match: /
              route:
                backend_group_id: ds7dq9nsrgpc********
                max_timeout: 10s
                idle_timeout: 5s
                host_rewrite: myapp
                rate_limit:
                  all_requests:
                    per_second: "12"
                  requests_per_ip:
                    per_second: "6"
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

    1. Измените маршрут, указав его имя и дополнительные параметры:

        ```bash
        yc alb virtual-host update-grpc-route <имя_маршрута> \
          --http-router-name <имя_HTTP-роутера> \
          --virtual-host-name <имя_виртуального_хоста> \
          --exact-fqmn-match <полный_FQMN> \
          --prefix-fqmn-match <префикс_FQMN> \
          --regex-fqmn-match <регулярное_выражение> \
          --backend-group-name <имя_группы_бэкендов> \
          --request-max-timeout <таймаут_запроса>s \
          --request-idle-timeout <таймаут_ожидания_запроса>s \
          --rate-limit rps=<лимит_запросов>,requests-per-ip \
          --disable-security-profile
        ```

        Где:

        * `--http-router-name` — имя HTTP-роутера, в котором находится маршрут.

            Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
        * `--virtual-host-name` — имя виртуального хоста, в котором находится маршрут.
        * Параметры с условиями маршрутизации на основе FQMN:

            * `--exact-fqmn-match` — маршрутизировать запросы, FQMN в которых идентичен заданному.
            * `--prefix-fqmn-match` — маршрутизировать запросы, FQMN в которых начинается с заданного префикса. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
            * `--regex-fqmn-match` — маршрутизировать запросы, FQMN в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}`.

            {% include [fqmn-slash-warning](../../_includes/application-load-balancer/instruction-steps/fqmn-slash-warning.md) %}

            {% note info %}

            Параметры `--exact-fqmn-match`, `--prefix-fqmn-match` и `--regex-fqmn-match` — взаимоисключающие: вы можете использовать только один из них.

            {% endnote %}

            Чтобы очистить заданные для маршрута условия маршрутизации на основе FQMN, передайте в команде параметр `--clear-fqmn-match`.
        * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md), виртуальный хост и маршрут.
        
            Вместо имени группы бэкендов вы можете указать ее идентификатор в параметре `--backend-group-id`.
        * `--request-max-timeout` — максимальное время, на которое может быть установлено соединение. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута.

            Чтобы очистить заданное для маршрута значение таймаута соединения, передайте в команде параметр `--clear-max-timeout`.
        * `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.

            Чтобы очистить заданное для маршрута значение максимального времени простоя, передайте в команде параметр `--clear-idle-timeout`.
        * {% include [cli-route-creation-rate-limit](../../_includes/application-load-balancer/instruction-steps/cli-route-creation-rate-limit.md) %}

            Чтобы очистить заданные для маршрута настройки частоты запросов, передайте в команде параметр `--clear-rate-limit`.
        * {% include [cli-route-creation-disable-security-profile](../../_includes/application-load-balancer/instruction-steps/cli-route-creation-disable-security-profile.md) %}

            Чтобы включить для маршрута профиль безопасности, который был отключен ранее, передайте в команде параметр `--disable-security-profile=false`.


        {% cut "Результат:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-route
            grpc:
              match:
                fqmn:
                  exact_match: /myapp
              route:
                backend_group_id: ds7dq9nsrgpc********
                max_timeout: 12s
                idle_timeout: 6s
                host_rewrite: myapp
                rate_limit:
                  all_requests:
                    per_second: "12"
                  requests_per_ip:
                    per_second: "6"
            disable_security_profile: true
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

        Подробную информацию о команде `yc alb virtual-host update-grpc-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update-grpc-route.md).

  {% endlist %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Измените в конфигурационном файле параметры маршрута как ресурса, вложенного в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host). С помощью {{ TF }} вы можете изменять в виртуальном хосте разные [типы](../concepts/http-router.md#routes-types) маршрутов:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        {% include [tf-route-http-hcl-code](../../_includes/application-load-balancer/instruction-steps/tf-route-http-hcl-code.md) %}

        Где:

        * `route` — описание маршрута виртуального хоста:

            {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

            {% include [tf-vh-create-legend-route-http](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-http.md) %}

      - gRPC {#grpc}

        {% include [tf-route-grpc-hcl-code](../../_includes/application-load-balancer/instruction-steps/tf-route-grpc-hcl-code.md) %}

        Где:

        * `route` — описание маршрута виртуального хоста:

            {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

            {% include [tf-vh-create-legend-route-grpc](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-grpc.md) %}

      {% endlist %}

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Обновите ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление, изменение ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [updateRoute](../api-ref/VirtualHost/updateRoute.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/UpdateRoute](../api-ref/grpc/VirtualHost/updateRoute.md).

{% endlist %}

## Изменить порядок маршрутов {#sort-routes}

Чтобы изменить порядок маршрутов в [виртуальном хосте](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% include [reorder-routes-complete-section](../../_includes/application-load-balancer/instruction-steps/reorder-routes-complete-section.md) %}

## Модифицировать параметры HTTP-запросов {#modify-http-parameters}

Маршруты [виртуальных хостов](../concepts/http-router.md#virtual-host) в [HTTP-роутерах](../concepts/http-router.md) {{ alb-full-name }} позволяют при необходимости модифицировать параметры HTTP-запросов, заменяя части запроса, удовлетворяющие [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax), другими значениями.

Например, такая модификация может быть полезна для управления версиями API, для микросервисной маршрутизации, для обеспечения обратной совместимости и нормализации URL, а также при [A/B тестировании](https://ru.wikipedia.org/wiki/A/B-тестирование) и в [канареечных релизах](../../api-gateway/concepts/extensions/canary.md).

Модифицировать параметры HTTP-запросов в маршрутах вы можете с помощью [{{ yandex-cloud }} CLI](../../cli/index.yaml), [{{ TF }}]({{ tf-provider-link }}) или [API](../api-ref/authentication.md).

### Пример модификации параметров HTTP-запросов {#modification-example}

В качестве примера приведем решение для ситуации, которая может возникнуть в результате внедрения в сервисе новой версии API-интерфейса. Предположим, что изначально единственная версия API в сервисе была доступна по адресу `/api/users`. После появления новой версии интерфейса (`v2`) новый интерфейс должен быть доступен по адресу `/api/v2/users`, а старый — по адресу `/api/v1/users`.

Запросы к новому API-интерфейсу приходят сразу на адрес `/api/v2/users`, и для них достаточно настроить обычное правило маршрутизации, которое направит эти запросы в группу бэкендов с новым API `api-v2-backend`.

Запросы к старому API продолжают приходить на адрес `/api/users`, и этот адрес в запросах вы можете заменить на адрес `/api/v1/users`. Для этого вы можете использовать модификацию параметров HTTP-запроса в настройках маршрута.

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы модифицировать параметры HTTP-запроса в маршруте виртуального хоста, при выполнении команды [создания](#create-route) или [изменения](#update-route) маршрута для HTTP-трафика задайте необходимые настройки замены в параметре `--path-regex-rewrite`. В приведенной ниже команде модификация запроса настраивается при создании маршрута:

  ```bash
  yc alb virtual-host append-http-route <имя_маршрута> \
  --virtual-host-name <имя_виртуального_хоста> \
  --http-router-name <имя_HTTP-роутера> \
  --backend-group-name api-v1-backend \
  --prefix-path-match '/api/users/' \
  --path-regex-rewrite 'regex=^/api/users/(.*),substitute=/api/v1/users/\\1'
  ```
   
  Где:

  * `--backend-group-name` — имя группы бэкендов, в которой доступен старый API-интерфейс.
  * `--prefix-path-match` — фильтр с указанием префикса пути, по которому будут отбираться запросы, поступающие в создаваемый маршрут.
  * `--path-regex-rewrite` — параметр, задающий настройки замены в пути HTTP-запроса:

      {% include [path-regex-rewrite-legend](../../_includes/application-load-balancer/instruction-steps/path-regex-rewrite-legend.md) %}

      {% note info %}

      Параметры `--path-regex-rewrite` и `--path-prefix-rewrite` — взаимоисключающие: вы можете использовать только один из них.

      {% endnote %}
  
  Результат:

  ```text
  name: my-virtual-host
  routes:
    - name: my-http-route
      http:
        match:
          path:
            prefix_match: /api/users/
        route:
          backend_group_id: ds7m9iupbcaq********
          regex_rewrite:
            regex: ^/api/users/(.*)
            substitute: /api/v1/users/\\1
  ```

  Подробную информацию о команде `yc alb virtual-host append-http-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

- {{ TF }} {#tf}

  1. Чтобы модифицировать параметры HTTP-запроса, в конфигурационном файле {{ TF }} в параметрах HTTP-маршрута как ресурса, вложенного в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host), задайте параметр `regex_rewrite`:

      ```hcl
      ...
      route {
        name                      = "<имя_маршрута>"
        disable_security_profile  = true|false

        http_route {
          http_match {
            http_method = ["<HTTP-метод_1>","<HTTP-метод_2>",...,"<HTTP-метод_n>"]
            path {
              prefix = "/api/users/"
              # или exact = "<путь_запроса>"
              # или regex = "<регулярное_выражение>"
            }
          }

          http_route_action {
            backend_group_id  = "ds7m9iupbcaq********"
            host_rewrite      = "<значение_заголовка_Host>"
            timeout           = "<таймаут_соединения>s"
            idle_timeout      = "<таймаут-простоя>s"
            regex_rewrite {
              regex      = "^/api/users/(.*)"
              substitute = "/api/v1/users/\\1"
            }
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
      ...
      ```

      Где:

      * `route` — описание маршрута виртуального хоста:

          * `http_route` — описание маршрута для HTTP-трафика:

              * `path` — параметр для фильтрации пути входящего запроса:

                  * `prefix` — фильтр с указанием префикса пути, по которому будут отбираться запросы, поступающие в создаваемый маршрут.
          * `http_route_action` — параметр для указания действия с HTTP-трафиком:

              * `backend_group_id` — идентификатор группы бэкендов, в которой доступен старый API-интерфейс.
              * `regex_rewrite` — параметр, задающий настройки замены в пути HTTP-запроса:

                  {% include [path-regex-rewrite-legend](../../_includes/application-load-balancer/instruction-steps/path-regex-rewrite-legend.md) %}

              {% note info %}

              Параметры `regex_rewrite` и `prefix_rewrite` — взаимоисключающие: вы можете использовать только один из них.

              {% endnote %}

          Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Создайте или обновите ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление, изменение ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

- API {#api}

  Чтобы модифицировать параметры HTTP-запроса в маршруте виртуального хоста, при [создании](#create-route) или [изменении](#update-route) маршрута для HTTP-трафика задайте необходимые настройки замены в поле `regexRewrite` (для REST API) или `regex_rewrite` (для gRPC API).

  {% note info %}

  Поля `regexRewrite` и `prefixRewrite` — взаимоисключающие: вы можете задать значение только для одного из них.

  {% endnote %}

{% endlist %}

## Удалить маршрут {#delete-route}

Чтобы удалить маршрут из [виртуального хоста](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете удалять маршрут виртуального хоста.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором находится нужный маршрут.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с виртуальным хостом, в котором находится нужный маршрут, в строке с именем нужного маршрута нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  С помощью {{ yandex-cloud }} CLI вы можете удалять из виртуального хоста разные [типы](../concepts/http-router.md#routes-types) маршрутов:

  {% list tabs group=alb_route_type%}

  - HTTP {#http}

    1. Посмотрите описание команды CLI для удаления маршрута виртуального хоста:

        ```bash
        yc alb virtual-host remove-http-route --help
        ```
    1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
    1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
    1. Чтобы получить список маршрутов в виртуальном хосте, выполните команду, указав в ней имя виртуального хоста и имя или идентификатор HTTP-роутера соответственно в параметре `--http-router-name` или `--http-router-id`:

        ```bash
        yc alb virtual-host get <имя_виртуального_хоста> \
          --http-router-name <имя_HTTP-роутера> \
          --http-router-id <идентификатор_HTTP-роутера>
        ```

        {% include [cli-route-delete-route](../../_includes/application-load-balancer/instruction-steps/cli-route-delete-route.md) %}

    1. Удалите маршрут, указав его имя, а также данные виртуального хоста и HTTP-роутера:

        ```bash
        yc alb virtual-host remove-http-route <имя_маршрута> \
          --http-router-name <имя_HTTP-роутера> \
          --virtual-host-name <имя_виртуального_хоста>
        ```

        Где:

        * `--http-router-name` — имя HTTP-роутера, в котором находится маршрут.

            Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
        * `--virtual-host-name` — имя виртуального хоста, в котором находится маршрут.

        {% cut "Результат:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-grpc-route
            grpc:
              match:
                fqmn:
                  prefix_match: /
              route:
                backend_group_id: ds7dq9nsrgpc********
                max_timeout: 10s
                idle_timeout: 5s
                host_rewrite: myapp
                rate_limit:
                  all_requests:
                    per_second: "12"
                  requests_per_ip:
                    per_second: "6"
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

        Подробную информацию о команде `yc alb virtual-host remove-http-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/remove-http-route.md).

  - gRPC {#grpc}

    1. Посмотрите описание команды CLI для удаления маршрута виртуального хоста:

        ```bash
        yc alb virtual-host remove-grpc-route --help
        ```
    1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
    1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
    1. Чтобы получить список маршрутов в виртуальном хосте, выполните команду, указав в ней имя виртуального хоста и имя или идентификатор HTTP-роутера соответственно в параметре `--http-router-name` или `--http-router-id`:

        ```bash
        yc alb virtual-host get <имя_виртуального_хоста> \
          --http-router-name <имя_HTTP-роутера> \
          --http-router-id <идентификатор_HTTP-роутера>
        ```

        {% include [cli-route-delete-route](../../_includes/application-load-balancer/instruction-steps/cli-route-delete-route.md) %}

    1. Удалите маршрут, указав его имя, а также данные виртуального хоста и HTTP-роутера:

        ```bash
        yc alb virtual-host remove-grpc-route <имя_маршрута> \
          --http-router-name <имя_HTTP-роутера> \
          --virtual-host-name <имя_виртуального_хоста>
        ```

        Где:

        * `--http-router-name` — имя HTTP-роутера, в котором находится маршрут.

            Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
        * `--virtual-host-name` — имя виртуального хоста, в котором находится маршрут.

        {% cut "Результат:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-http-route
            http:
              match:
                http_method:
                  - GET
                  - POST
                path:
                  prefix_match: myapp/
              route:
                backend_group_id: ds7dnf2s5dco********
                timeout: 10s
                idle_timeout: 3s
                host_rewrite: myapp
                prefix_rewrite: yourapp/
                rate_limit:
                  all_requests:
                    per_second: "12"
                  requests_per_ip:
                    per_minute: "120"
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

        Подробную информацию о команде `yc alb virtual-host remove-grpc-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/remove-grpc-route.md).

  {% endlist %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Удалите в конфигурационном файле описание маршрута как ресурса, вложенного в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

      {% include [tf-route-reorder-delete-route](../../_includes/application-load-balancer/instruction-steps/tf-route-reorder-delete-route.md) %}

      Информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Обновите ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление, удаление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [removeRoute](../api-ref/VirtualHost/removeRoute.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/RemoveRoute](../api-ref/grpc/VirtualHost/removeRoute.md).

{% endlist %}
