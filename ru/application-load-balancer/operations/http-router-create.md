# Создать HTTP-роутер для HTTP-трафика

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться HTTP-роутер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/router.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Введите имя роутера.
  1. В блоке **{{ ui-key.yacloud.alb.label_virtual-hosts }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Введите имя хоста.

  
  1. (опционально) В поле **Профиль безопасности {{ sws-name }}** выберите [профиль безопасности](../../smartwebsecurity/concepts/profiles.md) {{ sws-full-name }}.

      Сервис {{ sws-name }} находится на [стадии Preview](../../overview/concepts/launch-stages.md).


  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Введите **{{ ui-key.yacloud.common.name }}** маршрута.
  1. В поле **{{ ui-key.yacloud.alb.label_path }}** выберите одну из опций:

      * `{{ ui-key.yacloud.alb.label_match-exact }}` и укажите путь `/` — для маршрутизации всех запросов совпадающих с указанным путем.
      * `{{ ui-key.yacloud.alb.label_match-prefix }}` —  для маршрутизации всех запросов с определенным началом.
      * `{{ ui-key.yacloud.alb.label_match-regex }}` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax).

  1. В списке **{{ ui-key.yacloud.alb.label_http-methods }}** выберите нужные методы.
  1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}`, `{{ ui-key.yacloud.alb.label_route-action-redirect }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:

      * `{{ ui-key.yacloud.alb.label_route-action-route }}`:

        * В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите имя группы бэкендов из того же каталога, в котором создаете роутер.
        * (опционально) В поле **{{ ui-key.yacloud.alb.label_prefix-rewrite }}** укажите, куда роутер должен перенаправлять трафик. Если в поле **{{ ui-key.yacloud.alb.label_path }}** вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен. Если была выбрана опция `{{ ui-key.yacloud.alb.label_match-prefix }}`, будет заменено только начало.
        * (опционально) В поле **{{ ui-key.yacloud.alb.label_host-rewrite }}** выберите одну из опций:

            * `none` — замена не происходит.
            * `rewrite` — происходит замена на указанное значение.
            * `auto` — происходит автоматическая замена на адрес целевой ВМ.
        * (опционально) В поле **{{ ui-key.yacloud.alb.label_timeout }}** укажите максимальное время, на которое может быть установлено соединение.
        * (опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время, в течение которого соединение может простаивать без передачи данных.
        * (опционально) В поле **{{ ui-key.yacloud.alb.label_upgrade-types }}** укажите список протоколов, на которые группа бэкендов может перейти в рамках TCP-соединения по запросу клиента.
        * (опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_web-socket }}**, если вы хотите использовать протокол WebSocket. 

      * `{{ ui-key.yacloud.alb.label_route-action-redirect }}`:

        * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код, по которому будет осуществляться перенаправление.
        * (опционально) В поле **{{ ui-key.yacloud.alb.label_replace }}** укажите, куда роутер должен перенаправлять трафик. Если в поле **{{ ui-key.yacloud.alb.label_path }}** вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен. Если была выбрана опция `{{ ui-key.yacloud.alb.label_match-prefix }}`, будет заменено только начало.
        * (опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_strict-query }}**. 
        * (опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_replace-scheme }}**.
        * (опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_replace-host }}** и укажите новый хост.
        * (опционально) Выберите опцию **{{ ui-key.yacloud.alb.label_replace-port }}** и укажите новый порт.
      
      * `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`:

        * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код, по которому будет осуществляться ответ.
        * В поле **{{ ui-key.yacloud.alb.label_body }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_select }}** и в открывшемся окне:

            * Выберите **{{ ui-key.yacloud.component.file-content-dialog.field_method }}** указания ответа: **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}** или **{{ ui-key.yacloud.component.file-content-dialog.value_upload }}**.
            * В зависимости от выбранного способа прикрепите файл или укажите текст ответа.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания HTTP-роутера:
     
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
        --modify-request-header name=Accept-Language,append=ru-RU
      ```

 

      Где:

      * `--authority` — домены для заголовков `Host` и `authority`, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`.
      * `--modify-request-header` — настройки модификации заголовка запроса:
        * `name` — имя модифицируемого заголовка.
        * `append` — строка, которая будет добавлена к значению заголовка.

      Результат:
     
      
      ```text
      name: test-virtual-host
      authority:
      - your-domain.foo.com
      modify_request_headers:
      - name: Accept-Language
        append: ru-RU
      ```
     


  1. Посмотрите описание команды CLI для добавления маршрута:

      ```bash
      yc alb virtual-host append-http-route --help
      ```

  1. Добавьте маршрут, указав идентификатор или имя роутера и параметры маршрутизации:
    
      ```bash
      yc alb virtual-host append-http-route <имя_маршрута> \
        --virtual-host-name <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера> \
        --prefix-path-match / \
        --backend-group-name <имя_группы_бэкендов> \
        --request-timeout <тайм-аут_запроса>s \
        --request-idle-timeout <тайм-аут_ожидания_запроса>s
      ```

      Где:

      * `--virtual-host-name` — имя виртуального хоста.
      * `--http-router-name` — имя HTTP-роутера.
      * `--prefix-path-match` — параметр для маршрутизации всех запросов с определенным началом. После параметра укажите путь `/`.

        Также чтобы задать условие для маршрутизации, вы можете использовать параметры:
        * `--exact-path-match` — для маршрутизации всех запросов, совпадающих с указанным путем. После параметра укажите `/<путь>/`. 
        * `--regex-path-match` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). После параметра укажите `/<регулярное_выражение>`.
      * `--backend-group-name` — имя группы бэкендов.
      * `--request-timeout` — тайм-аут запроса, в секундах.
      * `--request-max-timeout` — максимальный тайм-аут ожидания запроса, в секундах.

      Подробную информацию о параметрах команды `yc alb virtual-host append-http-route` см. в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).

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

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
          http_route {
            http_route_action {
              backend_group_id  = "<идентификатор_группы_бэкендов>"
              timeout           = "60s"
            }
          }
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
        * `route` — описание маршрута HTTP-роутера:
          * `name` — имя маршрута.
          * `http_route_action` — параметр для указания действия с HTTP-трафиком.
            * `backend_group_id` — идентификатор группы бэкэндов.
            * `timeout` — максимальный тайм-аут ожидания запроса, в секундах.

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

      * Ресурс [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
      * Ресурс [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Создайте ресурсы

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc alb http-router get <имя_HTTP-роутера>
        ```

- API

  Воспользуйтесь методом REST API [create](../api-ref/HttpRouter/create.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Create](../api-ref/grpc/http_router_service.md#Create).

{% endlist %}
