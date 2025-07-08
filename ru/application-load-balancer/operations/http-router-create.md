---
title: Как создать HTTP-роутер для HTTP-трафика в {{ alb-full-name }}
description: Следуя данной инструкции, вы сможете создать HTTP-роутер для HTTP-трафика.
---

# Создать HTTP-роутер для HTTP-трафика

Чтобы создать [HTTP-роутер](../concepts/http-router.md) и добавить в него [маршрут](../concepts/http-router.md#routes):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создаваться HTTP-роутер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Введите имя HTTP-роутера.
  1. В блоке **{{ ui-key.yacloud.alb.label_virtual-hosts }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Введите имя хоста.
  1. (Опционально) В поле **{{ ui-key.yacloud.alb.label_authority }}** укажите значение заголовка `Host` для HTTP/1.1 или псевдо-заголовка `:authority` для HTTP/2, по которому будет выбираться виртуальный хост.
  1. (Опционально) В поле **{{ ui-key.yacloud.alb.label_security-profile-id }}** выберите [профиль безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/). Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить WAF и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. [{#T}](../../smartwebsecurity/concepts/profiles.md).


  1. (Опционально) В блоке **{{ ui-key.yacloud.alb.label_modifications }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-modification }}** и настройте [HTTP-заголовок](https://ru.wikipedia.org/wiki/Список_заголовков_HTTP):
     * В поле **{{ ui-key.yacloud.alb.label_modification-type }}** выберите:
       * `{{ ui-key.yacloud.alb.label_header-request }}` — модифицировать заголовок входящего запроса — от клиента к балансировщику.
       * `{{ ui-key.yacloud.alb.label_header-response }}` — модифицировать заголовок исходящего ответа — от бэкенда к внешнему клиенту.
     * В поле **{{ ui-key.yacloud.alb.label_modification-header }}** укажите имя заголовка.  Например, `Host`, `User-Agent`, `X-Forwarded-For`, `Strict-Transport-Security`.
     * В поле **{{ ui-key.yacloud.alb.label_modification-operation }}** выберите:
       * `append` — для добавления указанной строки к значению заголовка.
       * `replace` — для замены значения заголовка указанной строкой.
       * `remove` — для удаления заголовка. Будет удалено не только значение заголовка, но и сам заголовок.
       * `rename` — для изменения имени заголовка. При этом значение заголовка не изменяется.
     * Введите строку для изменения значения заголовка или новое имя заголовка.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Введите **{{ ui-key.yacloud.common.name }}** маршрута.
  1. В поле **{{ ui-key.yacloud.alb.label_path }}** выберите одну из опций:
     * `{{ ui-key.yacloud.alb.label_match-exact }}` и укажите путь `/` — для маршрутизации всех запросов совпадающих с указанным путем.
     * `{{ ui-key.yacloud.alb.label_match-prefix }}` — для маршрутизации всех запросов с определенным началом.
     * `{{ ui-key.yacloud.alb.label_match-regex }}` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax).
  1. В списке **{{ ui-key.yacloud.alb.label_http-methods }}** выберите нужные методы.
  1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}`, `{{ ui-key.yacloud.alb.label_route-action-redirect }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:
     * `{{ ui-key.yacloud.alb.label_route-action-route }}`:
       * В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите имя [группы бэкендов](../concepts/backend-group.md) из того же каталога, в котором создаете HTTP-роутер.
       * (Опционально) В поле **{{ ui-key.yacloud.alb.label_prefix-rewrite }}** укажите, куда HTTP-роутер должен перенаправлять трафик. Если в поле **{{ ui-key.yacloud.alb.label_path }}** вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен. Если была выбрана опция `{{ ui-key.yacloud.alb.label_match-prefix }}`, будет заменено только начало.
       * (Опционально) В поле **{{ ui-key.yacloud.alb.label_host-rewrite }}** выберите одну из опций:
         * `none` — замена не происходит.
         * `rewrite` — происходит замена на указанное значение.
         * `auto` — происходит автоматическая замена на адрес целевой ВМ.
       * (Опционально) В поле **{{ ui-key.yacloud.alb.label_timeout }}** укажите максимальное время, на которое может быть установлено соединение.
       * (Опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время keep-alive, в течение которого соединение может простаивать без передачи данных.
       * (Опционально) В поле **{{ ui-key.yacloud.alb.label_upgrade-types }}** укажите список протоколов, на которые группа бэкендов может перейти в рамках TCP-соединения по запросу клиента.
       * (Опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_web-socket }}**, если вы хотите использовать протокол WebSocket.
     * `{{ ui-key.yacloud.alb.label_route-action-redirect }}`:
       * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код, по которому будет осуществляться перенаправление.
       * (Опционально) В поле **{{ ui-key.yacloud.alb.label_replace }}** укажите, куда HTTP-роутер должен перенаправлять трафик. Если в поле **{{ ui-key.yacloud.alb.label_path }}** вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен, даже если в поле **{{ ui-key.yacloud.alb.label_replace }}** выбрана опция `{{ ui-key.yacloud.alb.label_replace-prefix }}`.
       * (Опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_strict-query }}**. 
       * (Опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_replace-scheme }}**. Если в оригинальном URI использована схема `http` (`https`) и указан порт `80` (`443`), при изменении схемы порт будет удален.
       * (Опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_replace-host }}** и укажите новый хост.
       * (Опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_replace-port }}** и укажите новый порт.
     * `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`:
       * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код, по которому будет осуществляться ответ.
       * В поле **{{ ui-key.yacloud.alb.label_body }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_select }}** и в открывшемся окне:
         * Выберите **{{ ui-key.yacloud.component.file-content-dialog.field_method }}** указания ответа: **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}** или **{{ ui-key.yacloud.component.file-content-dialog.value_upload }}**.
         * В зависимости от выбранного способа прикрепите файл или укажите текст ответа балансировщика на запрос, поступивший по этому маршруту.
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

  1. Посмотрите описание команды CLI для создания виртуального хоста:

     ```bash
     yc alb virtual-host create --help
     ```

  1. Создайте виртуальный хост, указав имя HTTP-роутера и настройки виртуального хоста:

     ```bash
     yc alb virtual-host create <имя_виртуального_хоста> \
       --http-router-name <имя_HTTP-роутера> \
       --authority your-domain.foo.com \
       --modify-request-header name=Accept-Language,append=ru-RU \
       --rate-limit rps=100,all-requests \
       --security-profile-id <идентификатор_профиля_безопасности>
     ```

     Где:
     * `--http-router-name` — имя HTTP-роутера.
     * `--authority` — домены для заголовков `Host` для HTTP/1.1 или `authority` для HTTP/2, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`. Необязательный параметр.
     * `--modify-request-header` — настройки модификации заголовка запроса:
       * `name` — имя модифицируемого заголовка.
       * `append` — строка, которая будет добавлена к значению заголовка.
     * `--rate-limit` — (опционально) ограничение на скорость запросов:
       * `rps` или `rpm` – количество запросов, которые можно принять в секунду или в минуту.
       * `all-requests` — ограничение на все входящие запросы.
       * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса в отдельности. То есть в единицу времени для каждого IP-адреса можно принять указанное количество запросов.
     * `--security-profile-id` — (опционально) идентификатор [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/). Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить WAF и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. [{#T}](../../smartwebsecurity/concepts/profiles.md).


     Результат:

     ```text
     name: test-virtual-host
     authority:
       - your-domain.foo.com
     modify_request_headers:
       - name: Accept-Language
         append: ru-RU
     route_options:
       security_profile_id: fevcifh6tr**********
     rate_limit:
       all_requests:
         per_second: "100"
     ```

  1. Посмотрите описание команды CLI для добавления маршрута:

     ```bash
     yc alb virtual-host append-http-route --help
     ```

  1. Добавьте маршрут, указав идентификатор или имя HTTP-роутера и параметры маршрутизации:

     ```bash
     yc alb virtual-host append-http-route <имя_маршрута> \
       --virtual-host-name <имя_виртуального_хоста> \
       --http-router-name <имя_HTTP-роутера> \
       --prefix-path-match / \
       --backend-group-name <имя_группы_бэкендов> \
       --request-timeout <тайм-аут_запроса>s \
       --request-idle-timeout <тайм-аут_ожидания_запроса>s
       --rate-limit rps=<лимит_запросов>,requests-per-ip
     ```

     Где:
     * `--virtual-host-name` — имя виртуального хоста.
     * `--http-router-name` — имя HTTP-роутера.
     * `--prefix-path-match` — параметр для маршрутизации всех запросов с определенным началом. После параметра укажите путь `/`.

       Также, чтобы задать условие для маршрутизации, вы можете использовать параметры:
       * `--exact-path-match` — для маршрутизации всех запросов, совпадающих с указанным путем. После параметра укажите `/<путь>/`. 
       * `--regex-path-match` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). После параметра укажите `/<регулярное_выражение>`.
     * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md).
     * `--request-timeout` — тайм-аут запроса, в секундах.
     * `--request-max-timeout` — максимальный тайм-аут ожидания запроса, в секундах.
     * `--rate-limit` — ограничение на скорость запросов.

     Подробную информацию о параметрах команды `yc alb virtual-host append-http-route` см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

     Результат:

     ```text
     done (1s)
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
           backend_group_id: a5d4db973944********
           timeout: 2s
           idle_timeout: 3s
     modify_request_headers:
     - name: Accept-Language
       append: ru-RU
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
         name = "<имя_маршрута>"
         http_route {
           http_route_action {
             backend_group_id = "<идентификатор_группы_бэкендов>"
             timeout          = "60s"
           }
         }
       }
       
       authority             = "<домены>"
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
       * `name` — имя виртуального хоста. Формат имени:

         {% include [name-format](../../_includes/name-format.md) %}

       * `http_router_id` — идентификатор HTTP-роутера.
       * `rate_limit` — (опционально) ограничения скорости для всего виртуального хоста.
         * `all_requests` — (опционально) ограничение всех запросов в секунду или в минуту:
           * `per_second` — в секунду.
           * `per_minute` — в минуту.
         * `requests_per_ip` — (опционально) дополнительное ограничение запросов для каждого IP-адреса в секунду или в минуту:
           * `per_second` — в секунду.
           * `per_minute` — в минуту.
       * `route` — описание маршрута HTTP-роутера:
         * `name` — имя маршрута.
         * `http_route_action` — параметр для указания действия с HTTP-трафиком.
           * `backend_group_id` — идентификатор [группы бэкендов](../concepts/backend-group.md).
           * `timeout` — максимальный тайм-аут ожидания запроса, в секундах.
       * `authority` — домены для заголовков `Host`для HTTP/1.1 или `authority` для HTTP/2, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`. Необязательный параметр.
       * `route_options` — (опционально) дополнительные параметры виртуального хоста:
           * `security_profile_id` — идентификатор [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/). Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить WAF и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. [{#T}](../../smartwebsecurity/concepts/profiles.md).
  

     Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
     * [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
     * [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc alb http-router get <имя_HTTP-роутера>
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/HttpRouter/create.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Create](../api-ref/grpc/HttpRouter/create.md).

{% endlist %}
