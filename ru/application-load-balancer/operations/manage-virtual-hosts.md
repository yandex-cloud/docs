---
title: Как управлять виртуальными хостами в {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете создавать, изменять и удалять виртуальные хосты HTTP-роутера в {{ alb-full-name }}.
---

# Управлять виртуальными хостами

[Виртуальные хосты](../concepts/http-router.md#virtual-host) внутри [HTTP-роутеров](../concepts/http-router.md) объединяют [маршруты](../concepts/http-router.md#routes), относящиеся к одному набору доменов — значений заголовков `Host` (`:authority`) HTTP-запроса. При получении входящего запроса [балансировщик](../concepts/application-load-balancer.md) по очереди проверяет предикаты маршрутов и выбирает первый, который удовлетворяет запросу.

## Создать виртуальный хост {#create-vh}

Чтобы создать виртуальный хост:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать виртуальный хост.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором вы будете создавать виртуальный хост.
  
      При необходимости [создайте](./http-router-create.md) новый HTTP-роутер.
  1. На панели сверху нажмите ![cube](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.alb.button_virtual-host-create }}** и в открывшемся окне:

      1. {% include [console-name-vh](../../_includes/application-load-balancer/instruction-steps/console-name-vh.md) %}
      1. В поле **{{ ui-key.yacloud.alb.label_authority }}** укажите:

          * Для HTTP-трафика — значение заголовка `Host` для HTTP/1.1 или псевдозаголовка `:authority` для HTTP/2, по которым будет выбираться виртуальный хост.
          * Для gRPC-трафика — `*` или [IP-адрес](../../vpc/concepts/address.md) балансировщика.

          При необходимости воспользуйтесь кнопкой **{{ ui-key.yacloud.alb.button_add-host-id }}**, чтобы задать для виртуального хоста дополнительные значения **{{ ui-key.yacloud.alb.label_authority }}**.

          {% include [console-no-authority-notice](../../_includes/application-load-balancer/instruction-steps/console-no-authority-notice.md) %}

      1. {% include [console-vh-form-sws-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-sws-step.md) %}
      1. {% include [console-vh-form-albnative-rl-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-albnative-rl-step.md) %}
      1. {% include [console-vh-form-header-mods-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-header-mods-step.md) %}
      1. (Опционально) [Создайте](./manage-routes.md#create-route) необходимые маршруты для трафика создаваемого виртуального хоста.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. {% include [cli-vh-create-help](../../_includes/application-load-balancer/instruction-steps/cli-vh-create-help.md) %}
  1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-create](../../_includes/application-load-balancer/instruction-steps/cli-vh-create.md) %}

  Подробнее о команде `alb virtual-host create` см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры виртуального хоста. С помощью {{ TF }} вы можете создавать виртуальные хосты с разными [типами](../concepts/http-router.md#routes-types) маршрутов:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        {% include [tf-vh-http-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-http-create-manifest.md) %}

        Где:

        * `yandex_alb_virtual_host` — описание виртуального хоста:

            {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

            * `route` — описание маршрута виртуального хоста:

                {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

                {% include [tf-vh-create-legend-route-http](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-http.md) %}

            {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      - gRPC {#grpc}

        {% include [tf-vh-grpc-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-grpc-create-manifest.md) %}

        Где:

        * `yandex_alb_virtual_host` — описание виртуального хоста:

            {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

            * `route` — описание маршрута виртуального хоста:

                {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

                {% include [tf-vh-create-legend-route-grpc](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-grpc.md) %}

            {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      {% endlist %}

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/VirtualHost/create.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Create](../api-ref/grpc/VirtualHost/create.md).

{% endlist %}

## Изменить виртуальный хост {#update-vh}

Чтобы изменить виртуальный хост:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный виртуальный хост.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором находится нужный виртуальный хост.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с нужным виртуальным хостом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:

      1. (Опционально) В поле **{{ ui-key.yacloud.alb.label_authority }}** измените заданные настройки и укажите:

          * Для HTTP-трафика — значение заголовка `Host` для HTTP/1.1 или псевдозаголовка `:authority` для HTTP/2, по которым будет выбираться виртуальный хост.
          * Для gRPC-трафика — `*` или [IP-адрес](../../vpc/concepts/address.md) балансировщика.

          При необходимости воспользуйтесь кнопкой **{{ ui-key.yacloud.alb.button_add-host-id }}**, чтобы задать для виртуального хоста дополнительные значения **{{ ui-key.yacloud.alb.label_authority }}**.

          {% include [console-no-authority-notice](../../_includes/application-load-balancer/instruction-steps/console-no-authority-notice.md) %}
      1. {% include [console-vh-form-sws-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-sws-step.md) %}
      1. {% include [console-vh-form-albnative-rl-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-albnative-rl-step.md) %}
      1. (Опционально) Разверните блок **{{ ui-key.yacloud.alb.label_modifications }}** и настройте модификацию [HTTP-заголовков](https://ru.wikipedia.org/wiki/Список_заголовков_HTTP). Если настроек в блоке еще нет, нажмите кнопку **{{ ui-key.yacloud.alb.button_add-modification }}**, чтобы добавить новую модификацию заголовка:

          {% include [console-vh-form-header-mods-step-part2](../../_includes/application-load-balancer/instruction-steps/console-vh-form-header-mods-step-part2.md) %}
      1. (Опционально) [Создайте](./manage-routes.md#create-route) необходимые маршруты для трафика создаваемого виртуального хоста.
      1. {% include [console-reorder-routes](../../_includes/application-load-balancer/instruction-steps/console-reorder-routes.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения виртуального хоста:

      ```bash
      yc alb virtual-host update --help
      ```
  1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
  1. Чтобы изменить виртуальный хост, выполните команду, указав его имя:

      ```bash
      yc alb virtual-host update <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера> \
        --authority <домен_1>,<домен_2>,...,<домен_n> \
        --modify-request-header name=Accept-Language,append=ru-RU \
        --modify-response-header name=Accept-Charset,replace=utf-8 \
        --rate-limit rps=100,all-requests \
        --security-profile-id <идентификатор_профиля_безопасности> \
        --clear-routes
      ```

      Где:
      * `--http-router-name` — имя HTTP-роутера.

          Вместо имени HTTP-роутера вы можете передать его идентификатор в параметре `--http-router-id`.
      * `--authority` — список доменов для заголовков `Host` для HTTP/1.1 или `authority` для HTTP/2, которые будут связаны с этим виртуальным хостом. Несколько значений указываются через запятую. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`. Для gRPC-трафика вы можете указать IP-адрес балансировщика.

          Необязательный параметр. Если значение не задано, на виртуальный хост будет направляться весь трафик.

          Чтобы удалить заданный для виртуального хоста список доменов, передайте в команде параметр `--clear-authorities`.
      * `--modify-request-header` — настройки модификации HTTP-заголовка запроса в формате `<свойство>=<значение>`. Возможные свойства:

          {% include [cli-vh-modify-header-options](../../_includes/application-load-balancer/instruction-steps/cli-vh-modify-header-options.md) %}

          Чтобы изменить несколько HTTP-заголовков в запросе, задайте в команде параметр `--modify-request-header` необходимое количество раз.

          Необязательный параметр: если не задан, заголовки запроса передаются в бэкенд в неизменном виде.

          Чтобы очистить все настройки модификации HTTP-заголовка запроса для виртуального хоста, передайте в команде параметр `--clear-request-header-modifications`.
      * `--modify-response-header` — настройки модификации HTTP-заголовка ответа в формате `<свойство>=<значение>`. Возможные свойства: 

          {% include [cli-vh-modify-header-options](../../_includes/application-load-balancer/instruction-steps/cli-vh-modify-header-options.md) %}

          Чтобы изменить несколько HTTP-заголовков в ответе, задайте в команде параметр `--modify-response-header` необходимое количество раз.

          Необязательный параметр: если не задан, заголовки ответа передаются клиенту в неизменном виде.

          Чтобы очистить все настройки модификации HTTP-заголовка ответа для виртуального хоста, передайте в команде параметр `--clear-response-header-modifications`.
      * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
          * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
          * `all-requests` — ограничение на все входящие запросы.
          * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.

          Для одного виртуального хоста вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.

          Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.

          Чтобы очистить все заданные для виртуального хоста ограничения на количество запросов, передайте в команде параметр `--clear-rate-limit`.
      * `--security-profile-id` — идентификатор [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.yaml). Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр.

          Чтобы отвязать профиль безопасности от виртуального хоста, передайте в параметре пустое значение: `--security-profile-id ""`

      * `--clear-routes` — параметр, который удаляет все маршруты из виртуального хоста. Необязательный параметр.

      Результат:

      ```text
      name: test-virtual-host
      authority:
        - example.com
      modify_request_headers:
        - name: Accept-Language
          replace: ru-RU
      modify_response_headers:
        - name: Accept-Charset
          append: utf-8
      route_options:
        security_profile_id: fevu5fnuk6vf********
      rate_limit:
        all_requests:
          per_second: "80"
      ```

  Подробнее о команде `yc alb virtual-host update` см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле измененные параметры виртуального хоста. С помощью {{ TF }} вы можете создавать виртуальные хосты с разными [типами](../concepts/http-router.md#routes-types) маршрутов:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        {% include [tf-vh-http-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-http-create-manifest.md) %}

        Где:

        * `yandex_alb_virtual_host` — описание виртуального хоста:

            {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

            * `route` — описание маршрута виртуального хоста:

                {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

                {% include [tf-vh-create-legend-route-http](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-http.md) %}

            {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      - gRPC {#grpc}

        {% include [tf-vh-grpc-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-grpc-create-manifest.md) %}

        Где:

        * `yandex_alb_virtual_host` — описание виртуального хоста:

            {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

            * `route` — описание маршрута виртуального хоста:

                {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

                {% include [tf-vh-create-legend-route-grpc](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-grpc.md) %}

            {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      {% endlist %}

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Обновите ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} обновит требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md).

{% endlist %}

## Удалить виртуальный хост {#delete-vh}

Чтобы удалить виртуальный хост:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный виртуальный хост.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором находится нужный виртуальный хост.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с нужным виртуальным хостом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления виртуального хоста:

      ```bash
      yc alb virtual-host delete --help
      ```
  1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
  1. Чтобы удалить виртуальный хост, выполните команду, указав его имя:

      ```bash
      yc alb virtual-host delete <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      Где `--http-router-name` — имя HTTP-роутера. Вместо имени HTTP-роутера вы можете передать его идентификатор в параметре `--http-router-id`.

  Подробнее о команде `yc alb virtual-host delete` см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить виртуальный хост, созданный с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием виртуального хоста (ресурс `yandex_alb_virtual_host`).

      {% cut "Пример описания виртуального хоста в конфигурации {{ TF }}" %}

      {% include [tf-vh-http-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-http-create-manifest.md) %}

      {% endcut %}

  1. Обновите ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} обновит требуемые ресурсы. Проверить наличие ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc alb virtual-host list \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/VirtualHost/delete.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Delete](../api-ref/grpc/VirtualHost/delete.md).

{% endlist %}
