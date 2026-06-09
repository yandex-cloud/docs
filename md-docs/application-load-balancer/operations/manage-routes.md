# Управлять маршрутами

[Маршруты](../concepts/http-router.md) состоят из набора условий (предиката), на основании которых [балансировщик](../concepts/application-load-balancer.md) выбирает дальнейшее направление для запроса, и действия над ним. Доступные условия и действия зависят от [типа маршрута](../concepts/http-router.md#routes-types).

## Создать маршрут {#create-route}

Чтобы создать маршрут в [виртуальном хосте](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать маршрут для виртуального хоста.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором находится виртуальный хост, для которого требуется создать маршрут.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с нужным виртуальным хостом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  
      При необходимости [создайте](manage-virtual-hosts.md#create-vh) новый виртуальный хост.
  
      В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}** и в появившейся форме **{{ ui-key.yacloud.alb.label_new-route }}**, в зависимости от [типа](../concepts/http-router.md#routes-types) создаваемого маршрута:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя создаваемого маршрута. Требования к имени:
           
           * длина — от 3 до 63 символов;
           * может содержать строчные буквы латинского алфавита, цифры и дефисы;
           * первый символ — буква, последний — не дефис.
        1. В поле **{{ ui-key.yacloud.alb.label_route-type }}** выберите `{{ ui-key.yacloud.alb.label_proto-http }}`.
        1. В поле **{{ ui-key.yacloud.alb.label_path }}** выберите одну из опций:
           
           * `{{ ui-key.yacloud.alb.label_match-exact }}` — чтобы маршрутизировать запросы, путь в которых идентичен пути, заданному в текстовом поле справа. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
           * `{{ ui-key.yacloud.alb.label_match-prefix }}` — чтобы маршрутизировать запросы, путь в которых начинается с префикса, заданного в текстовом поле справа.
           * `{{ ui-key.yacloud.alb.label_match-regex }}` — чтобы маршрутизировать запросы, путь в которых удовлетворяет [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax), заданному в текстовом поле справа. Например: `\/[a-z]{10}[0-9]{3}`.
        1. В поле **{{ ui-key.yacloud.alb.label_http-methods }}** выберите нужные HTTP-[методы](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми необходимо маршрутизировать.
        1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}`, `{{ ui-key.yacloud.alb.label_route-action-redirect }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:
           
           {% list tabs %}
           
           - {{ ui-key.yacloud.alb.label_route-action-route }}
           
             * В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите [группу бэкендов](../concepts/backend-group.md), расположенную в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_prefix-rewrite }}** укажите путь, по которому HTTP-роутер должен перенаправлять трафик. Если ранее в поле **{{ ui-key.yacloud.alb.label_path }}** вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен. Если была выбрана опция `{{ ui-key.yacloud.alb.label_match-prefix }}`, будет изменено только начало.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_host-rewrite }}** выберите одну из опций:
               
               * `none` — заголовок Host в запросе не изменяется.
               * `rewrite` — заголовок Host в запросе заменяется на указанное значение.
               * `auto` — заголовок Host в запросе автоматически заменяется на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
             * (Опционально) Включите опции **{{ ui-key.yacloud.alb.label_limit-all-requests }}** и/или **{{ ui-key.yacloud.alb.label_limit-requests-per-ip }}** и задайте соответствующие ограничения на количество запросов, которые будут обрабатываться для данного маршрута за единицу времени.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_timeout }}** укажите максимальное время, на которое может быть установлено соединение.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время keep-alive, в течение которого соединение может простаивать без передачи данных.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_upgrade-types }}**:
           
                 * (Опционально) Укажите список протоколов, на которые группа бэкендов может перейти в рамках TCP-соединения по запросу клиента. Используйте кнопку **{{ ui-key.yacloud_billing.alb.button_add-upgrade-type }}**, чтобы добавлять дополнительные протоколы.
                 * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_web-socket }}**, если вы хотите использовать протокол [WebSocket](https://ru.wikipedia.org/wiki/WebSocket).
           
           - {{ ui-key.yacloud.alb.label_route-action-redirect }}
           
             * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код, по которому будет осуществляться перенаправление:
           
                 * `301 Moved Permanently`;
                 * `302 Found`;
                 * `303 See Other`;
                 * `307 Temporary Redirect`;
                 * `308 Permanent Redirect`.
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace }}** и укажите тип модификации пути, по которому HTTP-роутер должен перенаправлять трафик:
           
                 * `{{ ui-key.yacloud.alb.label_replace-exact }}` — чтобы полностью заменить путь запроса на значение, заданное в поле справа.
                 * `{{ ui-key.yacloud.alb.label_replace-prefix }}` — чтобы изменить префикс пути запроса на значение, заданное в поле справа.
           
                 {% note info %}
           
                 Если в поле **{{ ui-key.yacloud.alb.label_path }}** выше вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен, даже если в поле **{{ ui-key.yacloud.alb.label_replace }}** выбрана опция `{{ ui-key.yacloud.alb.label_replace-prefix }}`.
           
                 {% endnote %}
           
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_strict-query }}**, чтобы удалять из запросов все query-параметры.
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-scheme }}**, чтобы изменять схему в запросах на схему, заданную в поле справа.
           
                 Если в исходном URI использована схема `http` (`https`) и указан порт `80` (`443`), при изменении схемы порт будет удален.
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-host }}** и в поле справа укажите новый хост.
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-port }}** и в поле справа укажите новый порт.
           
           - {{ ui-key.yacloud.alb.label_route-action-statusResponse }}
           
             * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код статического ответа, который будет отправляться на запрос.
             * В поле **{{ ui-key.yacloud.alb.label_body }}** задайте тело статического ответа на запросы. Для этого нажмите кнопку **{{ ui-key.yacloud.alb.button_select }}** и в открывшемся окне:
           
                 * В поле **{{ ui-key.yacloud.component.file-content-dialog.field_method }}** выберите:
           
                     * `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` — чтобы выбрать текстовый файл, содержащий тело ответа.
                     * `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` — чтобы указать текст ответа в текстовом поле.
                     * Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
           
           {% endlist %}

      - gRPC {#grpc}

        1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя создаваемого маршрута. Требования к имени:
           
           * длина — от 3 до 63 символов;
           * может содержать строчные буквы латинского алфавита, цифры и дефисы;
           * первый символ — буква, последний — не дефис.
        1. В поле **{{ ui-key.yacloud.alb.label_route-type }}** выберите `{{ ui-key.yacloud.alb.label_proto-grpc }}`.
        1. В поле **{{ ui-key.yacloud.alb.label_fqmn }}** выберите одну из опций:
           
           * `{{ ui-key.yacloud.alb.label_match-exact }}` — чтобы маршрутизировать запросы, FQMN которых идентичен FQMN, заданному в текстовом поле справа.
           * `{{ ui-key.yacloud.alb.label_match-prefix }}` — чтобы маршрутизировать запросы, FQMN в которых начинается с префикса, заданного в текстовом поле справа. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
           * `{{ ui-key.yacloud.alb.label_match-regex }}` — чтобы маршрутизировать запросы, FQMN в которых удовлетворяет [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax), заданному в текстовом поле справа.
           
           {% note warning %}
           
           FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.
           
           {% endnote %}
        1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:
           
           {% list tabs %}
           
           - {{ ui-key.yacloud.alb.label_route-action-route }}
           
             * В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите [группу бэкендов](../concepts/backend-group.md), расположенную в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_host-rewrite }}** выберите одну из опций:
               
               * `none` — заголовок Host в запросе не изменяется.
               * `rewrite` — заголовок Host в запросе заменяется на указанное значение.
               * `auto` — заголовок Host в запросе автоматически заменяется на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
             * (Опционально) Включите опции **{{ ui-key.yacloud.alb.label_limit-all-requests }}** и/или **{{ ui-key.yacloud.alb.label_limit-requests-per-ip }}** и задайте соответствующие ограничения на количество запросов, которые будут обрабатываться для данного маршрута за единицу времени.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_max-timeout }}** укажите максимальное время, на которое может быть установлено соединение. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время, в течение которого соединение может простаивать без передачи данных.
           
           - {{ ui-key.yacloud.alb.label_route-action-statusResponse }}
           
             В поле **{{ ui-key.yacloud.alb.label_grpc-status-code }}** выберите код статического ответа, отправляемого балансировщиком в ответ на запрос:
           
             * `OK`;
             * `INVALID_ARGUMENT`;
             * `NOT_FOUND`;
             * `PERMISSION_DENIED`;
             * `UNAUTHENTICATED`;
             * `UNIMPLEMENTED`;
             * `INTERNAL`;
             * `UNAVAILABLE`.
           
           {% endlist %}

      {% endlist %}

  1. (Опционально) Чтобы изменить порядок маршрутов, нажмите кнопку **{{ ui-key.yacloud.alb.button_routes-sort }}** и в открывшемся окне:
     
     1. С помощью мышки методом перетаскивания выстройте нужный порядок маршрутов.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
     
     {% note info %}
     
     Позднее вы в любой момент сможете [изменить](manage-routes.md#sort-routes) порядок маршрутов виртуального хоста.
     
     {% endnote %}
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  С помощью {{ yandex-cloud }} CLI вы можете добавлять в виртуальный хост разные [типы](../concepts/http-router.md#routes-types) маршрутов:

  {% list tabs group=alb_route_type%}

  - HTTP {#http}

    {{ yandex-cloud }} CLI позволяет использовать три разных команды для добавления HTTP-маршрутов в виртуальный хост:
    
    * `yc alb virtual-host append-http-route` — добавляет маршрут в конец списка маршрутов виртуального хоста.
    * `yc alb virtual-host prepend-http-route` — добавляет маршрут в начало списка маршрутов виртуального хоста.
    * `yc alb virtual-host insert-http-route` — добавляет маршрут в указанное место внутри списка маршрутов виртуального хоста.
    
    {% list tabs %}
    
    - append-http-route
    
      1. Посмотрите описание команды CLI для добавления маршрута в конец списка маршрутов виртуального хоста:
         
         ```bash
         yc alb virtual-host append-http-route --help
         ```
      1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
         
         ```bash
         yc alb http-router list
         ```
         
         Результат:
         
         ```text
         +----------------------+--------------------+-------------+-------------+
         |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
         +----------------------+--------------------+-------------+-------------+
         | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
         | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
         +----------------------+--------------------+-------------+-------------+
         ```
      1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
         
         ```bash
         yc alb virtual-host list \
           --http-router-name <имя_HTTP-роутера> \
           --http-router-id <идентификатор_HTTP-роутера>
         ```
         
         Результат:
         
         ```text
         +-------------------+-------------+-------------+----------------------+
         |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
         +-------------------+-------------+-------------+----------------------+
         | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
         | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
         +-------------------+-------------+-------------+----------------------+
         ```
      1. Добавьте маршрут, указав его имя и дополнительные параметры:
         
         ```bash
         yc alb virtual-host append-http-route <имя_маршрута> \
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
    
          * `--http-router-name` — имя HTTP-роутера, в котором создается маршрут.
          
              Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
          * `--virtual-host-name` — имя виртуального хоста, в котором создается маршрут.
          * `--match-http-method` — список HTTP-[методов](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми необходимо маршрутизировать. Например: `--match-http-method GET,POST,OPTIONS`. Необязательный параметр. Если не задан, маршрутизироваться будут запросы с любыми методами.
          * Параметры с условиями маршрутизации на основе пути:
          
              * `--exact-path-match` — маршрутизировать запросы, путь в которых идентичен заданному пути. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
              * `--prefix-path-match` — маршрутизировать запросы, путь в которых начинается с заданного префикса. Например: `/myapp/`.
              * `--regex-path-match` — маршрутизировать запросы, путь в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}\/`.
          
              {% note info %}
          
              Параметры `--exact-path-match`, `--prefix-path-match` и `--regex-path-match` — взаимоисключающие: вы можете использовать только один из них.
          
              {% endnote %}
          
          * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
            
            Вместо имени группы бэкендов вы можете указать ее идентификатор в параметре `--backend-group-id`.
          * `--request-timeout` — максимальное время в секундах, на которое может быть установлено соединение по запросу.
          * `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.
          * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
            
            * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
            * `all-requests` — ограничение на все входящие запросы.
            * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.
            
            Для одного маршрута вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.
            
            Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.
          * `--disable-security-profile` — параметр, отключающий для маршрута использование [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md), заданного для виртуального хоста. Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. в разделе [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр. По умолчанию профиль безопасности, привязанный к виртуальному хосту, действует в отношении всех создаваемых маршрутов.
    
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
            - name: my-second-route
              http:
                match:
                  http_method:
                    - GET
                    - POST
                    - OPTIONS
                  path:
                    exact_match: /
                route:
                  backend_group_id: ds7dnf2s5dco********
                  timeout: 2s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "10"
              disable_security_profile: true
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "100"
          ```
          
          {% endcut %}
          
          Подробную информацию о команде `yc alb virtual-host append-http-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).
    
    - prepend-http-route
    
      1. Посмотрите описание команды CLI для добавления маршрута в начало списка маршрутов:
    
          ```bash
          yc alb virtual-host prepend-http-route --help
          ```
      1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
         
         ```bash
         yc alb http-router list
         ```
         
         Результат:
         
         ```text
         +----------------------+--------------------+-------------+-------------+
         |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
         +----------------------+--------------------+-------------+-------------+
         | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
         | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
         +----------------------+--------------------+-------------+-------------+
         ```
      1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
         
         ```bash
         yc alb virtual-host list \
           --http-router-name <имя_HTTP-роутера> \
           --http-router-id <идентификатор_HTTP-роутера>
         ```
         
         Результат:
         
         ```text
         +-------------------+-------------+-------------+----------------------+
         |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
         +-------------------+-------------+-------------+----------------------+
         | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
         | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
         +-------------------+-------------+-------------+----------------------+
         ```
      1. Добавьте маршрут, указав его имя и дополнительные параметры:
    
          ```bash
          yc alb virtual-host prepend-http-route <имя_маршрута> \
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
    
          * `--http-router-name` — имя HTTP-роутера, в котором создается маршрут.
          
              Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
          * `--virtual-host-name` — имя виртуального хоста, в котором создается маршрут.
          * `--match-http-method` — список HTTP-[методов](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми необходимо маршрутизировать. Например: `--match-http-method GET,POST,OPTIONS`. Необязательный параметр. Если не задан, маршрутизироваться будут запросы с любыми методами.
          * Параметры с условиями маршрутизации на основе пути:
          
              * `--exact-path-match` — маршрутизировать запросы, путь в которых идентичен заданному пути. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
              * `--prefix-path-match` — маршрутизировать запросы, путь в которых начинается с заданного префикса. Например: `/myapp/`.
              * `--regex-path-match` — маршрутизировать запросы, путь в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}\/`.
          
              {% note info %}
          
              Параметры `--exact-path-match`, `--prefix-path-match` и `--regex-path-match` — взаимоисключающие: вы можете использовать только один из них.
          
              {% endnote %}
          
          * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
            
            Вместо имени группы бэкендов вы можете указать ее идентификатор в параметре `--backend-group-id`.
          * `--request-timeout` — максимальное время в секундах, на которое может быть установлено соединение по запросу.
          * `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.
          * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
            
            * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
            * `all-requests` — ограничение на все входящие запросы.
            * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.
            
            Для одного маршрута вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.
            
            Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.
          * `--disable-security-profile` — параметр, отключающий для маршрута использование [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md), заданного для виртуального хоста. Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. в разделе [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр. По умолчанию профиль безопасности, привязанный к виртуальному хосту, действует в отношении всех создаваемых маршрутов.
    
          {% cut "Результат:" %}
    
          ```text
          name: test-virtual-host
          authority:
            - example.com
          routes:
            - name: my-second-route
              http:
                match:
                  http_method:
                    - GET
                    - POST
                    - OPTIONS
                  path:
                    exact_match: /
                route:
                  backend_group_id: ds7dnf2s5dco********
                  timeout: 2s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "10"
              disable_security_profile: true
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
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "100"
          ```
    
          {% endcut %}
    
          Подробную информацию о команде `yc alb virtual-host prepend-http-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-http-route.md).
    
    - insert-http-route
    
      1. Посмотрите описание команды CLI для добавления маршрута в заданное место в списке маршрутов:
    
          ```bash
          yc alb virtual-host insert-http-route --help
          ```
      1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
         
         ```bash
         yc alb http-router list
         ```
         
         Результат:
         
         ```text
         +----------------------+--------------------+-------------+-------------+
         |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
         +----------------------+--------------------+-------------+-------------+
         | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
         | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
         +----------------------+--------------------+-------------+-------------+
         ```
      1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
         
         ```bash
         yc alb virtual-host list \
           --http-router-name <имя_HTTP-роутера> \
           --http-router-id <идентификатор_HTTP-роутера>
         ```
         
         Результат:
         
         ```text
         +-------------------+-------------+-------------+----------------------+
         |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
         +-------------------+-------------+-------------+----------------------+
         | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
         | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
         +-------------------+-------------+-------------+----------------------+
         ```
      1. Чтобы узнать текущий порядок маршрутов в виртуальном хосте, выполните команду, указав в ней имя виртуального хоста и имя или идентификатор HTTP-роутера соответственно в параметре `--http-router-name` или `--http-router-id`:
         
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
            - name: my-second-route
              http:
                match:
                  http_method:
                    - GET
                    - POST
                    - OPTIONS
                  path:
                    exact_match: /
                route:
                  backend_group_id: ds7dnf2s5dco********
                  timeout: 2s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "10"
              disable_security_profile: true
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "100"
          ```
          
          {% endcut %}
    
      1. Добавьте маршрут, указав его имя и дополнительные параметры:
    
          ```bash
          yc alb virtual-host insert-http-route <имя_маршрута> \
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
            --disable-security-profile \
            --before <имя_последующего_маршрута> \
            --after <имя_предшествующего_маршрута>
          ```
    
          Где:
    
          * `--http-router-name` — имя HTTP-роутера, в котором создается маршрут.
          
              Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
          * `--virtual-host-name` — имя виртуального хоста, в котором создается маршрут.
          * `--match-http-method` — список HTTP-[методов](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми необходимо маршрутизировать. Например: `--match-http-method GET,POST,OPTIONS`. Необязательный параметр. Если не задан, маршрутизироваться будут запросы с любыми методами.
          * Параметры с условиями маршрутизации на основе пути:
          
              * `--exact-path-match` — маршрутизировать запросы, путь в которых идентичен заданному пути. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
              * `--prefix-path-match` — маршрутизировать запросы, путь в которых начинается с заданного префикса. Например: `/myapp/`.
              * `--regex-path-match` — маршрутизировать запросы, путь в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}\/`.
          
              {% note info %}
          
              Параметры `--exact-path-match`, `--prefix-path-match` и `--regex-path-match` — взаимоисключающие: вы можете использовать только один из них.
          
              {% endnote %}
          
          * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
            
            Вместо имени группы бэкендов вы можете указать ее идентификатор в параметре `--backend-group-id`.
          * `--request-timeout` — максимальное время в секундах, на которое может быть установлено соединение по запросу.
          * `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.
          * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
            
            * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
            * `all-requests` — ограничение на все входящие запросы.
            * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.
            
            Для одного маршрута вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.
            
            Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.
          * `--disable-security-profile` — параметр, отключающий для маршрута использование [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md), заданного для виртуального хоста. Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. в разделе [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр. По умолчанию профиль безопасности, привязанный к виртуальному хосту, действует в отношении всех создаваемых маршрутов.
    
          * `--before` — имя маршрута, перед которым в общем списке маршрутов виртуального хоста будет добавлен новый маршрут.
          * `--after` — имя маршрута, после которого в общем списке маршрутов виртуального хоста будет добавлен новый маршрут.
          
          {% note info %}
          
          Параметры `--before` и `--after` — взаимоисключающие: вы можете указать только один из них.
          
          {% endnote %}
    
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
            - name: my-third-route
              http:
                match:
                  http_method:
                    - PATCH
                    - PUT
                  path:
                    exact_match: /
                route:
                  backend_group_id: ds7dnf2s5dco********
                  timeout: 2s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "10"
              disable_security_profile: true
            - name: my-second-route
              http:
                match:
                  http_method:
                    - GET
                    - POST
                    - OPTIONS
                  path:
                    exact_match: /
                route:
                  backend_group_id: ds7dnf2s5dco********
                  timeout: 2s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "10"
              disable_security_profile: true
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "100"
          ```
    
          {% endcut %}
    
          Подробную информацию о команде `yc alb virtual-host insert-http-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-http-route.md).
    
    {% endlist %}

  - gRPC {#grpc}

    {{ yandex-cloud }} CLI позволяет использовать три разных команды для добавления gRPC-маршрутов в виртуальный хост:
    
    * `yc alb virtual-host append-grpc-route` — добавляет маршрут в конец списка маршрутов виртуального хоста.
    * `yc alb virtual-host prepend-grpc-route` — добавляет маршрут в начало списка маршрутов виртуального хоста.
    * `yc alb virtual-host insert-grpc-route` — добавляет маршрут в указанное место внутри списка маршрутов виртуального хоста.
    
    {% list tabs %}
    
    - append-grpc-route
    
      1. Посмотрите описание команды CLI для добавления маршрута в конец списка маршрутов виртуального хоста:
         
         ```bash
         yc alb virtual-host append-grpc-route --help
         ```
      1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
         
         ```bash
         yc alb http-router list
         ```
         
         Результат:
         
         ```text
         +----------------------+--------------------+-------------+-------------+
         |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
         +----------------------+--------------------+-------------+-------------+
         | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
         | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
         +----------------------+--------------------+-------------+-------------+
         ```
      1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
         
         ```bash
         yc alb virtual-host list \
           --http-router-name <имя_HTTP-роутера> \
           --http-router-id <идентификатор_HTTP-роутера>
         ```
         
         Результат:
         
         ```text
         +-------------------+-------------+-------------+----------------------+
         |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
         +-------------------+-------------+-------------+----------------------+
         | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
         | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
         +-------------------+-------------+-------------+----------------------+
         ```
      1. Добавьте маршрут, указав его имя и дополнительные параметры:
         
         ```bash
         yc alb virtual-host append-grpc-route <имя_маршрута> \
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
    
          * `--http-router-name` — имя HTTP-роутера, в котором создается маршрут.
          
              Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
          * `--virtual-host-name` — имя виртуального хоста, в котором создается маршрут.
          * Параметры с условиями маршрутизации на основе FQMN:
          
              * `--exact-fqmn-match` — маршрутизировать запросы, FQMN в которых идентичен заданному.
              * `--prefix-fqmn-match` — маршрутизировать запросы, FQMN в которых начинается с заданного префикса. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
              * `--regex-fqmn-match` — маршрутизировать запросы, FQMN в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}`.
          
              {% note warning %}
              
              FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.
              
              {% endnote %}
          
              {% note info %}
          
              Параметры `--exact-fqmn-match`, `--prefix-fqmn-match` и `--regex-fqmn-match` — взаимоисключающие: вы можете использовать только один из них.
          
              {% endnote %}
          
          * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
            
            Вместо имени группы бэкендов вы можете указать ее идентификатор в параметре `--backend-group-id`.
          * `--request-max-timeout` — максимальное время, на которое может быть установлено соединение. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута.
          * `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.
          * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
            
            * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
            * `all-requests` — ограничение на все входящие запросы.
            * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.
            
            Для одного маршрута вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.
            
            Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.
          * `--disable-security-profile` — параметр, отключающий для маршрута использование [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md), заданного для виртуального хоста. Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. в разделе [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр. По умолчанию профиль безопасности, привязанный к виртуальному хосту, действует в отношении всех создаваемых маршрутов.
    
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
                  max_timeout: 60s
                  idle_timeout: 5s
                  auto_host_rewrite: false
            - name: my-second-route
              grpc:
                match:
                  fqmn:
                    prefix_match: helloworld/
                route:
                  backend_group_id: ds7dq9nsrgpc********
                  max_timeout: 10s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "4"
              disable_security_profile: true
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "100"
          ```
          
          {% endcut %}
          
          Подробную информацию о команде `yc alb virtual-host append-grpc-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-grpc-route.md).
    
    - prepend-grpc-route
    
      1. Посмотрите описание команды CLI для добавления маршрута в начало списка маршрутов:
    
          ```bash
          yc alb virtual-host prepend-grpc-route --help
          ```
      1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
         
         ```bash
         yc alb http-router list
         ```
         
         Результат:
         
         ```text
         +----------------------+--------------------+-------------+-------------+
         |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
         +----------------------+--------------------+-------------+-------------+
         | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
         | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
         +----------------------+--------------------+-------------+-------------+
         ```
      1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
         
         ```bash
         yc alb virtual-host list \
           --http-router-name <имя_HTTP-роутера> \
           --http-router-id <идентификатор_HTTP-роутера>
         ```
         
         Результат:
         
         ```text
         +-------------------+-------------+-------------+----------------------+
         |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
         +-------------------+-------------+-------------+----------------------+
         | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
         | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
         +-------------------+-------------+-------------+----------------------+
         ```
      1. Добавьте маршрут, указав его имя и дополнительные параметры:
    
          ```bash
          yc alb virtual-host prepend-grpc-route <имя_маршрута> \
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
    
          * `--http-router-name` — имя HTTP-роутера, в котором создается маршрут.
          
              Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
          * `--virtual-host-name` — имя виртуального хоста, в котором создается маршрут.
          * Параметры с условиями маршрутизации на основе FQMN:
          
              * `--exact-fqmn-match` — маршрутизировать запросы, FQMN в которых идентичен заданному.
              * `--prefix-fqmn-match` — маршрутизировать запросы, FQMN в которых начинается с заданного префикса. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
              * `--regex-fqmn-match` — маршрутизировать запросы, FQMN в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}`.
          
              {% note warning %}
              
              FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.
              
              {% endnote %}
          
              {% note info %}
          
              Параметры `--exact-fqmn-match`, `--prefix-fqmn-match` и `--regex-fqmn-match` — взаимоисключающие: вы можете использовать только один из них.
          
              {% endnote %}
          
          * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
            
            Вместо имени группы бэкендов вы можете указать ее идентификатор в параметре `--backend-group-id`.
          * `--request-max-timeout` — максимальное время, на которое может быть установлено соединение. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута.
          * `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.
          * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
            
            * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
            * `all-requests` — ограничение на все входящие запросы.
            * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.
            
            Для одного маршрута вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.
            
            Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.
          * `--disable-security-profile` — параметр, отключающий для маршрута использование [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md), заданного для виртуального хоста. Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. в разделе [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр. По умолчанию профиль безопасности, привязанный к виртуальному хосту, действует в отношении всех создаваемых маршрутов.
    
          {% cut "Результат:" %}
    
          ```text
          name: test-virtual-host
          authority:
            - example.com
          routes:
            - name: my-second-route
              grpc:
                match:
                  fqmn:
                    prefix_match: helloworld/
                route:
                  backend_group_id: ds7dq9nsrgpc********
                  max_timeout: 10s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "4"
              disable_security_profile: true
            - name: my-first-route
              grpc:
                match:
                  fqmn:
                    prefix_match: /
                route:
                  backend_group_id: ds7dq9nsrgpc********
                  max_timeout: 60s
                  idle_timeout: 5s
                  auto_host_rewrite: false
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "100"
          ```
    
          {% endcut %}
    
          Подробную информацию о команде `yc alb virtual-host prepend-grpc-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-grpc-route.md).
    
    
    - insert-grpc-route
    
      1. Посмотрите описание команды CLI для добавления маршрута в заданное место в списке маршрутов:
    
          ```bash
          yc alb virtual-host insert-grpc-route --help
          ```
      1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
         
         ```bash
         yc alb http-router list
         ```
         
         Результат:
         
         ```text
         +----------------------+--------------------+-------------+-------------+
         |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
         +----------------------+--------------------+-------------+-------------+
         | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
         | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
         +----------------------+--------------------+-------------+-------------+
         ```
      1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
         
         ```bash
         yc alb virtual-host list \
           --http-router-name <имя_HTTP-роутера> \
           --http-router-id <идентификатор_HTTP-роутера>
         ```
         
         Результат:
         
         ```text
         +-------------------+-------------+-------------+----------------------+
         |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
         +-------------------+-------------+-------------+----------------------+
         | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
         | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
         +-------------------+-------------+-------------+----------------------+
         ```
      1. Чтобы узнать текущий порядок маршрутов в виртуальном хосте, выполните команду, указав в ней имя виртуального хоста и имя или идентификатор HTTP-роутера соответственно в параметре `--http-router-name` или `--http-router-id`:
         
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
                  max_timeout: 60s
                  idle_timeout: 5s
                  auto_host_rewrite: false
            - name: my-second-route
              grpc:
                match:
                  fqmn:
                    prefix_match: helloworld/
                route:
                  backend_group_id: ds7dq9nsrgpc********
                  max_timeout: 10s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "4"
              disable_security_profile: true
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "100"
          ```
    
          {% endcut %}
    
      1. Добавьте маршрут, указав его имя и дополнительные параметры:
    
          ```bash
          yc alb virtual-host insert-grpc-route <имя_маршрута> \
            --http-router-name <имя_HTTP-роутера> \
            --virtual-host-name <имя_виртуального_хоста> \
            --exact-fqmn-match <полный_FQMN> \
            --prefix-fqmn-match <префикс_FQMN> \
            --regex-fqmn-match <регулярное_выражение> \
            --backend-group-name <имя_группы_бэкендов> \
            --request-max-timeout <таймаут_запроса>s \
            --request-idle-timeout <таймаут_ожидания_запроса>s \
            --rate-limit rps=<лимит_запросов>,requests-per-ip \
            --disable-security-profile \
            --before <имя_последующего_маршрута> \
            --after <имя_предшествующего_маршрута>
          ```
    
          Где:
    
          * `--http-router-name` — имя HTTP-роутера, в котором создается маршрут.
          
              Вместо имени HTTP-роутера вы можете указать его идентификатор в параметре `--http-router-id`.
          * `--virtual-host-name` — имя виртуального хоста, в котором создается маршрут.
          * Параметры с условиями маршрутизации на основе FQMN:
          
              * `--exact-fqmn-match` — маршрутизировать запросы, FQMN в которых идентичен заданному.
              * `--prefix-fqmn-match` — маршрутизировать запросы, FQMN в которых начинается с заданного префикса. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
              * `--regex-fqmn-match` — маршрутизировать запросы, FQMN в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}`.
          
              {% note warning %}
              
              FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.
              
              {% endnote %}
          
              {% note info %}
          
              Параметры `--exact-fqmn-match`, `--prefix-fqmn-match` и `--regex-fqmn-match` — взаимоисключающие: вы можете использовать только один из них.
          
              {% endnote %}
          
          * `--backend-group-name` — имя [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
            
            Вместо имени группы бэкендов вы можете указать ее идентификатор в параметре `--backend-group-id`.
          * `--request-max-timeout` — максимальное время, на которое может быть установлено соединение. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута.
          * `--request-idle-timeout` — максимальное время в секундах, в течение которого соединение может простаивать без передачи данных.
          * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
            
            * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
            * `all-requests` — ограничение на все входящие запросы.
            * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.
            
            Для одного маршрута вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.
            
            Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.
          * `--disable-security-profile` — параметр, отключающий для маршрута использование [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md), заданного для виртуального хоста. Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. в разделе [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр. По умолчанию профиль безопасности, привязанный к виртуальному хосту, действует в отношении всех создаваемых маршрутов.
    
          * `--before` — имя маршрута, перед которым в общем списке маршрутов виртуального хоста будет добавлен новый маршрут.
          * `--after` — имя маршрута, после которого в общем списке маршрутов виртуального хоста будет добавлен новый маршрут.
          
          {% note info %}
          
          Параметры `--before` и `--after` — взаимоисключающие: вы можете указать только один из них.
          
          {% endnote %}
    
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
                  max_timeout: 60s
                  idle_timeout: 5s
                  auto_host_rewrite: false
            - name: my-third-route
              grpc:
                match:
                  fqmn:
                    prefix_match: myapp/
                route:
                  backend_group_id: ds7dq9nsrgpc********
                  max_timeout: 10s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "4"
              disable_security_profile: true
            - name: my-second-route
              grpc:
                match:
                  fqmn:
                    prefix_match: helloworld/
                route:
                  backend_group_id: ds7dq9nsrgpc********
                  max_timeout: 10s
                  idle_timeout: 5s
                  rate_limit:
                    requests_per_ip:
                      per_second: "4"
              disable_security_profile: true
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "100"
          ```
    
          {% endcut %}
    
          Подробную информацию о команде `yc alb virtual-host insert-grpc-route` с полным перечнем параметров см. в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-grpc-route.md).
    
    {% endlist %}

  {% endlist %}

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  {% note info %}
  
  Маршруты виртуального хоста будут применяться к поступающим запросам в том порядке, в котором они описаны в конфигурационном файле {{ TF }}.
  
  {% endnote %}

  1. Опишите в конфигурационном файле параметры маршрута как ресурса, вложенного в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host). С помощью {{ TF }} вы можете добавлять в виртуальный хост разные [типы](../concepts/http-router.md#routes-types) маршрутов:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        ```hcl
        ...
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
        ...
        ```

        Где:

        * `route` — описание маршрута виртуального хоста:

            * `name` — имя маршрута.
            * `disable_security_profile` — (опционально) опция отключения [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md). Возможные значения: `true` (профиль отключен) или `false` (профиль включен). По умолчанию профиль безопасности включен (значение `false`).

            * `http_route` — описание маршрута для HTTP-трафика:
            
                * `http_match` — (опционально) параметр для фильтрации входящих HTTP-запросов:
            
                    * `http_method` — (опционально) список HTTP-[методов](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми будут маршрутизироваться. По умолчанию маршрутизируются запросы с любыми методами.
                    * `path` — (опционально) параметры для фильтрации пути входящего запроса:
            
                        * `exact` — маршрутизировать запросы, путь в которых идентичен заданному пути. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
                        * `prefix` — маршрутизировать запросы, путь в которых начинается с заданного префикса.
                        * `regex` — маршрутизировать запросы, путь в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}\/`.
            
                        Параметры `exact`, `prefix` и `regex` — взаимоисключающие: вы можете использовать только один из них.
            
                * `http_route_action` — параметр для указания действия с HTTP-трафиком.
            
                    * `backend_group_id` — идентификатор [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых создается маршрут.
                    * `host_rewrite` — (опционально) замена заголовка Host в запросе на указанное значение. Вместо параметра `host_rewrite` вы можете указать параметр `auto_host_rewrite` — в этом случае заголовок Host в запросе автоматически будет заменяться на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
                    * `timeout` — (опционально) максимальное время, на которое может быть установлено соединение, в секундах. Значение по умолчанию — 60 секунд.
                    * `idle_timeout` — (опционально) максимальное время keep-alive, в течение которого соединение может простаивать без передачи данных. Если не задано, соединение без передачи данных будет сразу разрываться.
                    * `prefix_rewrite` — (опционально) значение, на которое будет заменен путь или часть пути запроса, указанные в параметре `path`.
                    * `rate_limit` — (опционально) параметр для ограничения количества запросов за единицу времени:
                      
                      * `all_requests` — (опционально) ограничение на все входящие запросы:
                      
                          * `per_second` — максимальное количество входящих запросов, которые могут поступать в маршрут за одну секунду.
                          * `per_minute` — максимальное количество входящих запросов, которые могут поступать в маршрут за одну минуту.
                      
                          Параметры `per_second` и `per_minute` — взаимоисключающие: вы можете использовать только один из них.
                      * `requests_per_ip` — (опционально) ограничение на входящие запросы с одного IP-адреса:
                      
                          * `per_second` — максимальное количество входящих запросов с одного IP-адреса, которые могут поступать в маршрут за одну секунду.
                          * `per_minute` — максимальное количество входящих запросов с одного IP-адреса, которые могут поступать в маршрут за одну минуту.
                      
                          Параметры `per_second` и `per_minute` — взаимоисключающие: вы можете использовать только один из них.

      - gRPC {#grpc}

        ```hcl
        ...
        route {
          name                      = "<имя_маршрута>"
          disable_security_profile  = true|false
        
          grpc_route {
            grpc_match {
              fqmn {
                prefix = "/<префикс_FQMN_запроса>"
                # или exact = "<FQMN_запроса>"
                # или regex = "<регулярное_выражение>"
              }
            }
        
            grpc_route_action {
              backend_group_id = "<идентификатор_группы_бэкендов>"
              host_rewrite = "<значение_заголовка_Host>"
              max_timeout = "<таймаут_соединения>s"
              idle_timeout = "<таймаут-простоя>s"
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

            * `name` — имя маршрута.
            * `disable_security_profile` — (опционально) опция отключения [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md). Возможные значения: `true` (профиль отключен) или `false` (профиль включен). По умолчанию профиль безопасности включен (значение `false`).

            * `grpc_route` — описание маршрута для gRPC-трафика:
            
                * `grpc_match.fqmn` — (опционально) параметр для фильтрации входящих gRPC-запросов по FQMN:
            
                    * `exact` — маршрутизировать запросы, FQMN в которых идентичен заданному.
                    * `prefix` — маршрутизировать запросы, FQMN в которых начинается с заданного префикса. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
                    * `regex` — маршрутизировать запросы, FQMN в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}`.
            
                    Параметры `exact`, `prefix` и `regex` — взаимоисключающие: вы можете использовать только один из них.
                    
                * `grpc_route_action` — параметр для указания действия с gRPC-трафиком.
            
                    * `backend_group_id` — идентификатор [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых создается маршрут.
                    * `host_rewrite` — (опционально) замена заголовка Host в запросе на указанное значение. Вместо параметра `host_rewrite` вы можете указать параметр `auto_host_rewrite` — в этом случае заголовок Host в запросе автоматически будет заменяться на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
                    * `max_timeout` — (опционально) максимальный таймаут ожидания запроса в секундах. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута. Значение по умолчанию — 60 секунд.
                    * `idle_timeout` — (опционально) максимальное время keep-alive, в течение которого соединение может простаивать без передачи данных. Если не задано, соединение без передачи данных будет сразу разрываться.
                    * `rate_limit` — (опционально) параметр для ограничения количества запросов за единицу времени:
                      
                      * `all_requests` — (опционально) ограничение на все входящие запросы:
                      
                          * `per_second` — максимальное количество входящих запросов, которые могут поступать в маршрут за одну секунду.
                          * `per_minute` — максимальное количество входящих запросов, которые могут поступать в маршрут за одну минуту.
                      
                          Параметры `per_second` и `per_minute` — взаимоисключающие: вы можете использовать только один из них.
                      * `requests_per_ip` — (опционально) ограничение на входящие запросы с одного IP-адреса:
                      
                          * `per_second` — максимальное количество входящих запросов с одного IP-адреса, которые могут поступать в маршрут за одну секунду.
                          * `per_minute` — максимальное количество входящих запросов с одного IP-адреса, которые могут поступать в маршрут за одну минуту.
                      
                          Параметры `per_second` и `per_minute` — взаимоисключающие: вы можете использовать только один из них.

      {% endlist %}

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% note warning "Ограничения по времени" %}
      
      Провайдер {{ TF }} ограничивает время на выполнение операций с HTTP-роутерами и виртуальными хостами {{ alb-name }} 10 минутами.
      
      Операции, которые длятся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию HTTP-роутера и виртуального хоста блоки `timeouts` (ресурсы `yandex_alb_http_router` и `yandex_alb_virtual_host` соответственно).
      
      Пример:
      
      ```hcl
      resource "yandex_alb_http_router" "<имя_роутера>" {
        ...
        timeouts {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md).

  {% note info %}
  
  Маршруты виртуального хоста будут применяться к поступающим запросам в том порядке, в котором они описаны в теле запроса.
  
  {% endnote %}

{% endlist %}

## Изменить маршрут {#update-route}

Чтобы изменить маршрут в [виртуальном хосте](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете изменять маршрут виртуального хоста.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором находится нужный маршрут.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с виртуальным хостом, в котором находится нужный маршрут, в строке с именем нужного маршрута нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне, в зависимости от [типа](../concepts/http-router.md#routes-types) маршрута:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        1. В поле **{{ ui-key.yacloud.alb.label_route-type }}** выберите `{{ ui-key.yacloud.alb.label_proto-http }}`.
        1. В поле **{{ ui-key.yacloud.alb.label_path }}** выберите одну из опций:
           
           * `{{ ui-key.yacloud.alb.label_match-exact }}` — чтобы маршрутизировать запросы, путь в которых идентичен пути, заданному в текстовом поле справа. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
           * `{{ ui-key.yacloud.alb.label_match-prefix }}` — чтобы маршрутизировать запросы, путь в которых начинается с префикса, заданного в текстовом поле справа.
           * `{{ ui-key.yacloud.alb.label_match-regex }}` — чтобы маршрутизировать запросы, путь в которых удовлетворяет [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax), заданному в текстовом поле справа. Например: `\/[a-z]{10}[0-9]{3}`.
        1. В поле **{{ ui-key.yacloud.alb.label_http-methods }}** выберите нужные HTTP-[методы](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми необходимо маршрутизировать.
        1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}`, `{{ ui-key.yacloud.alb.label_route-action-redirect }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:
           
           {% list tabs %}
           
           - {{ ui-key.yacloud.alb.label_route-action-route }}
           
             * В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите [группу бэкендов](../concepts/backend-group.md), расположенную в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_prefix-rewrite }}** укажите путь, по которому HTTP-роутер должен перенаправлять трафик. Если ранее в поле **{{ ui-key.yacloud.alb.label_path }}** вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен. Если была выбрана опция `{{ ui-key.yacloud.alb.label_match-prefix }}`, будет изменено только начало.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_host-rewrite }}** выберите одну из опций:
               
               * `none` — заголовок Host в запросе не изменяется.
               * `rewrite` — заголовок Host в запросе заменяется на указанное значение.
               * `auto` — заголовок Host в запросе автоматически заменяется на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
             * (Опционально) Включите опции **{{ ui-key.yacloud.alb.label_limit-all-requests }}** и/или **{{ ui-key.yacloud.alb.label_limit-requests-per-ip }}** и задайте соответствующие ограничения на количество запросов, которые будут обрабатываться для данного маршрута за единицу времени.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_timeout }}** укажите максимальное время, на которое может быть установлено соединение.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время keep-alive, в течение которого соединение может простаивать без передачи данных.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_upgrade-types }}**:
           
                 * (Опционально) Укажите список протоколов, на которые группа бэкендов может перейти в рамках TCP-соединения по запросу клиента. Используйте кнопку **{{ ui-key.yacloud_billing.alb.button_add-upgrade-type }}**, чтобы добавлять дополнительные протоколы.
                 * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_web-socket }}**, если вы хотите использовать протокол [WebSocket](https://ru.wikipedia.org/wiki/WebSocket).
           
           - {{ ui-key.yacloud.alb.label_route-action-redirect }}
           
             * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код, по которому будет осуществляться перенаправление:
           
                 * `301 Moved Permanently`;
                 * `302 Found`;
                 * `303 See Other`;
                 * `307 Temporary Redirect`;
                 * `308 Permanent Redirect`.
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace }}** и укажите тип модификации пути, по которому HTTP-роутер должен перенаправлять трафик:
           
                 * `{{ ui-key.yacloud.alb.label_replace-exact }}` — чтобы полностью заменить путь запроса на значение, заданное в поле справа.
                 * `{{ ui-key.yacloud.alb.label_replace-prefix }}` — чтобы изменить префикс пути запроса на значение, заданное в поле справа.
           
                 {% note info %}
           
                 Если в поле **{{ ui-key.yacloud.alb.label_path }}** выше вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен, даже если в поле **{{ ui-key.yacloud.alb.label_replace }}** выбрана опция `{{ ui-key.yacloud.alb.label_replace-prefix }}`.
           
                 {% endnote %}
           
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_strict-query }}**, чтобы удалять из запросов все query-параметры.
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-scheme }}**, чтобы изменять схему в запросах на схему, заданную в поле справа.
           
                 Если в исходном URI использована схема `http` (`https`) и указан порт `80` (`443`), при изменении схемы порт будет удален.
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-host }}** и в поле справа укажите новый хост.
             * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-port }}** и в поле справа укажите новый порт.
           
           - {{ ui-key.yacloud.alb.label_route-action-statusResponse }}
           
             * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код статического ответа, который будет отправляться на запрос.
             * В поле **{{ ui-key.yacloud.alb.label_body }}** задайте тело статического ответа на запросы. Для этого нажмите кнопку **{{ ui-key.yacloud.alb.button_select }}** и в открывшемся окне:
           
                 * В поле **{{ ui-key.yacloud.component.file-content-dialog.field_method }}** выберите:
           
                     * `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` — чтобы выбрать текстовый файл, содержащий тело ответа.
                     * `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` — чтобы указать текст ответа в текстовом поле.
                     * Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
           
           {% endlist %}

      - gRPC {#grpc}

        1. В поле **{{ ui-key.yacloud.alb.label_route-type }}** выберите `{{ ui-key.yacloud.alb.label_proto-grpc }}`.
        1. В поле **{{ ui-key.yacloud.alb.label_fqmn }}** выберите одну из опций:
           
           * `{{ ui-key.yacloud.alb.label_match-exact }}` — чтобы маршрутизировать запросы, FQMN которых идентичен FQMN, заданному в текстовом поле справа.
           * `{{ ui-key.yacloud.alb.label_match-prefix }}` — чтобы маршрутизировать запросы, FQMN в которых начинается с префикса, заданного в текстовом поле справа. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
           * `{{ ui-key.yacloud.alb.label_match-regex }}` — чтобы маршрутизировать запросы, FQMN в которых удовлетворяет [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax), заданному в текстовом поле справа.
           
           {% note warning %}
           
           FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.
           
           {% endnote %}
        1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:
           
           {% list tabs %}
           
           - {{ ui-key.yacloud.alb.label_route-action-route }}
           
             * В поле **{{ ui-key.yacloud.alb.label_backend-group }}** выберите [группу бэкендов](../concepts/backend-group.md), расположенную в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых вы создаете маршрут.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_host-rewrite }}** выберите одну из опций:
               
               * `none` — заголовок Host в запросе не изменяется.
               * `rewrite` — заголовок Host в запросе заменяется на указанное значение.
               * `auto` — заголовок Host в запросе автоматически заменяется на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
             * (Опционально) Включите опции **{{ ui-key.yacloud.alb.label_limit-all-requests }}** и/или **{{ ui-key.yacloud.alb.label_limit-requests-per-ip }}** и задайте соответствующие ограничения на количество запросов, которые будут обрабатываться для данного маршрута за единицу времени.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_max-timeout }}** укажите максимальное время, на которое может быть установлено соединение. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута.
             * (Опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время, в течение которого соединение может простаивать без передачи данных.
           
           - {{ ui-key.yacloud.alb.label_route-action-statusResponse }}
           
             В поле **{{ ui-key.yacloud.alb.label_grpc-status-code }}** выберите код статического ответа, отправляемого балансировщиком в ответ на запрос:
           
             * `OK`;
             * `INVALID_ARGUMENT`;
             * `NOT_FOUND`;
             * `PERMISSION_DENIED`;
             * `UNAUTHENTICATED`;
             * `UNIMPLEMENTED`;
             * `INTERNAL`;
             * `UNAVAILABLE`.
           
           {% endlist %}

      {% endlist %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  С помощью {{ yandex-cloud }} CLI вы можете изменять в виртуальном хосте разные [типы](../concepts/http-router.md#routes-types) маршрутов:

  {% list tabs group=alb_route_type%}

  - HTTP {#http}

    1. Посмотрите описание команды CLI для изменения маршрута виртуального хоста:

        ```bash
        yc alb virtual-host update-http-route --help
        ```
    1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
       
       ```bash
       yc alb http-router list
       ```
       
       Результат:
       
       ```text
       +----------------------+--------------------+-------------+-------------+
       |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
       +----------------------+--------------------+-------------+-------------+
       | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
       | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
       +----------------------+--------------------+-------------+-------------+
       ```
    1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
       
       ```bash
       yc alb virtual-host list \
         --http-router-name <имя_HTTP-роутера> \
         --http-router-id <идентификатор_HTTP-роутера>
       ```
       
       Результат:
       
       ```text
       +-------------------+-------------+-------------+----------------------+
       |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
       +-------------------+-------------+-------------+----------------------+
       | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
       | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
       +-------------------+-------------+-------------+----------------------+
       ```
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
        * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
          
          * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
          * `all-requests` — ограничение на все входящие запросы.
          * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.
          
          Для одного маршрута вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.
          
          Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.

            Чтобы очистить заданные для маршрута настройки частоты запросов, передайте в команде параметр `--clear-rate-limit`.
        * `--disable-security-profile` — параметр, отключающий для маршрута использование [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md), заданного для виртуального хоста. Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. в разделе [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр. По умолчанию профиль безопасности, привязанный к виртуальному хосту, действует в отношении всех создаваемых маршрутов.

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
    1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
       
       ```bash
       yc alb http-router list
       ```
       
       Результат:
       
       ```text
       +----------------------+--------------------+-------------+-------------+
       |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
       +----------------------+--------------------+-------------+-------------+
       | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
       | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
       +----------------------+--------------------+-------------+-------------+
       ```
    1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
       
       ```bash
       yc alb virtual-host list \
         --http-router-name <имя_HTTP-роутера> \
         --http-router-id <идентификатор_HTTP-роутера>
       ```
       
       Результат:
       
       ```text
       +-------------------+-------------+-------------+----------------------+
       |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
       +-------------------+-------------+-------------+----------------------+
       | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
       | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
       +-------------------+-------------+-------------+----------------------+
       ```
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

            {% note warning %}
            
            FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.
            
            {% endnote %}

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
        * `--rate-limit` — ограничение на частоту запросов. Возможные свойства:
          
          * `rps` или `rpm` — количество запросов, которые можно принять в секунду или в минуту.
          * `all-requests` — ограничение на все входящие запросы.
          * `requests-per-ip` — ограничение на количество запросов для каждого IP-адреса клиента в отдельности.
          
          Для одного маршрута вы можете задать только один вид ограничения: либо свойство `all-requests`, либо — `requests-per-ip`.
          
          Необязательный параметр: если не задан, ограничение на частоту запросов не применяется.

            Чтобы очистить заданные для маршрута настройки частоты запросов, передайте в команде параметр `--clear-rate-limit`.
        * `--disable-security-profile` — параметр, отключающий для маршрута использование [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md), заданного для виртуального хоста. Профиль безопасности позволяет настроить фильтрацию входящих запросов, подключить [WAF](../../smartwebsecurity/concepts/waf.md) и установить лимиты на количество запросов для защиты от вредоносной активности. Подробнее см. в разделе [{#T}](../../smartwebsecurity/concepts/profiles.md). Необязательный параметр. По умолчанию профиль безопасности, привязанный к виртуальному хосту, действует в отношении всех создаваемых маршрутов.

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

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Измените в конфигурационном файле параметры маршрута как ресурса, вложенного в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host). С помощью {{ TF }} вы можете изменять в виртуальном хосте разные [типы](../concepts/http-router.md#routes-types) маршрутов:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        ```hcl
        ...
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
        ...
        ```

        Где:

        * `route` — описание маршрута виртуального хоста:

            * `name` — имя маршрута.
            * `disable_security_profile` — (опционально) опция отключения [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md). Возможные значения: `true` (профиль отключен) или `false` (профиль включен). По умолчанию профиль безопасности включен (значение `false`).

            * `http_route` — описание маршрута для HTTP-трафика:
            
                * `http_match` — (опционально) параметр для фильтрации входящих HTTP-запросов:
            
                    * `http_method` — (опционально) список HTTP-[методов](https://ru.wikipedia.org/wiki/HTTP#Методы), запросы с которыми будут маршрутизироваться. По умолчанию маршрутизируются запросы с любыми методами.
                    * `path` — (опционально) параметры для фильтрации пути входящего запроса:
            
                        * `exact` — маршрутизировать запросы, путь в которых идентичен заданному пути. Например, чтобы маршрутизировать все запросы, укажите путь `/`.
                        * `prefix` — маршрутизировать запросы, путь в которых начинается с заданного префикса.
                        * `regex` — маршрутизировать запросы, путь в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}\/`.
            
                        Параметры `exact`, `prefix` и `regex` — взаимоисключающие: вы можете использовать только один из них.
            
                * `http_route_action` — параметр для указания действия с HTTP-трафиком.
            
                    * `backend_group_id` — идентификатор [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых создается маршрут.
                    * `host_rewrite` — (опционально) замена заголовка Host в запросе на указанное значение. Вместо параметра `host_rewrite` вы можете указать параметр `auto_host_rewrite` — в этом случае заголовок Host в запросе автоматически будет заменяться на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
                    * `timeout` — (опционально) максимальное время, на которое может быть установлено соединение, в секундах. Значение по умолчанию — 60 секунд.
                    * `idle_timeout` — (опционально) максимальное время keep-alive, в течение которого соединение может простаивать без передачи данных. Если не задано, соединение без передачи данных будет сразу разрываться.
                    * `prefix_rewrite` — (опционально) значение, на которое будет заменен путь или часть пути запроса, указанные в параметре `path`.
                    * `rate_limit` — (опционально) параметр для ограничения количества запросов за единицу времени:
                      
                      * `all_requests` — (опционально) ограничение на все входящие запросы:
                      
                          * `per_second` — максимальное количество входящих запросов, которые могут поступать в маршрут за одну секунду.
                          * `per_minute` — максимальное количество входящих запросов, которые могут поступать в маршрут за одну минуту.
                      
                          Параметры `per_second` и `per_minute` — взаимоисключающие: вы можете использовать только один из них.
                      * `requests_per_ip` — (опционально) ограничение на входящие запросы с одного IP-адреса:
                      
                          * `per_second` — максимальное количество входящих запросов с одного IP-адреса, которые могут поступать в маршрут за одну секунду.
                          * `per_minute` — максимальное количество входящих запросов с одного IP-адреса, которые могут поступать в маршрут за одну минуту.
                      
                          Параметры `per_second` и `per_minute` — взаимоисключающие: вы можете использовать только один из них.

      - gRPC {#grpc}

        ```hcl
        ...
        route {
          name                      = "<имя_маршрута>"
          disable_security_profile  = true|false
        
          grpc_route {
            grpc_match {
              fqmn {
                prefix = "/<префикс_FQMN_запроса>"
                # или exact = "<FQMN_запроса>"
                # или regex = "<регулярное_выражение>"
              }
            }
        
            grpc_route_action {
              backend_group_id = "<идентификатор_группы_бэкендов>"
              host_rewrite = "<значение_заголовка_Host>"
              max_timeout = "<таймаут_соединения>s"
              idle_timeout = "<таймаут-простоя>s"
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

            * `name` — имя маршрута.
            * `disable_security_profile` — (опционально) опция отключения [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) сервиса [{{ sws-full-name }}](../../smartwebsecurity/index.md). Возможные значения: `true` (профиль отключен) или `false` (профиль включен). По умолчанию профиль безопасности включен (значение `false`).

            * `grpc_route` — описание маршрута для gRPC-трафика:
            
                * `grpc_match.fqmn` — (опционально) параметр для фильтрации входящих gRPC-запросов по FQMN:
            
                    * `exact` — маршрутизировать запросы, FQMN в которых идентичен заданному.
                    * `prefix` — маршрутизировать запросы, FQMN в которых начинается с заданного префикса. Например, вы можете указать первое слово в имени сервиса: `/helloworld`.
                    * `regex` — маршрутизировать запросы, FQMN в которых удовлетворяет заданному [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). Например: `\/[a-z]{10}[0-9]{3}`.
            
                    Параметры `exact`, `prefix` и `regex` — взаимоисключающие: вы можете использовать только один из них.
                    
                * `grpc_route_action` — параметр для указания действия с gRPC-трафиком.
            
                    * `backend_group_id` — идентификатор [группы бэкендов](../concepts/backend-group.md), расположенной в том же каталоге, в котором находятся [HTTP-роутер](../concepts/http-router.md) и виртуальный хост, для которых создается маршрут.
                    * `host_rewrite` — (опционально) замена заголовка Host в запросе на указанное значение. Вместо параметра `host_rewrite` вы можете указать параметр `auto_host_rewrite` — в этом случае заголовок Host в запросе автоматически будет заменяться на адрес целевой [виртуальной машины](../../compute/concepts/vm.md).
                    * `max_timeout` — (опционально) максимальный таймаут ожидания запроса в секундах. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута. Значение по умолчанию — 60 секунд.
                    * `idle_timeout` — (опционально) максимальное время keep-alive, в течение которого соединение может простаивать без передачи данных. Если не задано, соединение без передачи данных будет сразу разрываться.
                    * `rate_limit` — (опционально) параметр для ограничения количества запросов за единицу времени:
                      
                      * `all_requests` — (опционально) ограничение на все входящие запросы:
                      
                          * `per_second` — максимальное количество входящих запросов, которые могут поступать в маршрут за одну секунду.
                          * `per_minute` — максимальное количество входящих запросов, которые могут поступать в маршрут за одну минуту.
                      
                          Параметры `per_second` и `per_minute` — взаимоисключающие: вы можете использовать только один из них.
                      * `requests_per_ip` — (опционально) ограничение на входящие запросы с одного IP-адреса:
                      
                          * `per_second` — максимальное количество входящих запросов с одного IP-адреса, которые могут поступать в маршрут за одну секунду.
                          * `per_minute` — максимальное количество входящих запросов с одного IP-адреса, которые могут поступать в маршрут за одну минуту.
                      
                          Параметры `per_second` и `per_minute` — взаимоисключающие: вы можете использовать только один из них.

      {% endlist %}

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Обновите ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы. Проверить появление, изменение ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% note warning "Ограничения по времени" %}
      
      Провайдер {{ TF }} ограничивает время на выполнение операций с HTTP-роутерами и виртуальными хостами {{ alb-name }} 10 минутами.
      
      Операции, которые длятся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию HTTP-роутера и виртуального хоста блоки `timeouts` (ресурсы `yandex_alb_http_router` и `yandex_alb_virtual_host` соответственно).
      
      Пример:
      
      ```hcl
      resource "yandex_alb_http_router" "<имя_роутера>" {
        ...
        timeouts {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [updateRoute](../api-ref/VirtualHost/updateRoute.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/UpdateRoute](../api-ref/grpc/VirtualHost/updateRoute.md).

{% endlist %}

## Изменить порядок маршрутов {#sort-routes}

Чтобы изменить порядок маршрутов в [виртуальном хосте](../concepts/http-router.md#virtual-host) HTTP-роутера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете изменять порядок маршрутов виртуального хоста.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором находится нужный виртуальный хост.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с нужным виртуальным хостом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Чтобы изменить порядок маршрутов, нажмите кнопку **{{ ui-key.yacloud.alb.button_routes-sort }}** и в открывшемся окне:
  
      1. С помощью мышки методом перетаскивания выстройте нужный порядок маршрутов.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  В {{ yandex-cloud }} CLI в настоящий момент нет отдельной команды, позволяющей изменять порядок маршрутов в виртуальном хосте.
  
  Чтобы изменить порядок маршрутов с помощью CLI, воспользуйтесь следующим порядком действий:
  1. [Удалите](manage-routes.md#delete-route) нужный маршрут из виртуального хоста.
  1. Заново [добавьте](manage-routes.md#create-route) маршрут в нужное место в списке маршрутов.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  {% note info %}
  
  Маршруты виртуального хоста будут применяться к поступающим запросам в том порядке, в котором они описаны в конфигурационном файле {{ TF }}.
  
  {% endnote %}

  1. Измените в конфигурационном файле порядок маршрутов как ресурсов, вложенных в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

      {% cut "Пример конфигурации виртуального хоста:" %}
      
      ```hcl
      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name           = "test-virtual-host"
        http_router_id = "ds76j5n6a39g********"
      
        rate_limit {
          all_requests {
            per_second = 5
          }
          requests_per_ip {
            per_second = 3
          }
        }
      
        route {
          name = "my-first-http-route"
          disable_security_profile = false
      
          http_route {
            http_match {
              http_method = ["GET","POST"]
              path {
                prefix = "/myapp/"
              }
            }
      
            http_route_action {
              backend_group_id = "ds7dnf2s5dco********"
              host_rewrite = "myapp"
              idle_timeout = "3s"
              prefix_rewrite = "/yourapp/"
              rate_limit {
                all_requests {
                  per_second = 12
                }
                requests_per_ip {
                  per_minute = 120
                }
              }
              timeout = "10s"
            }
          }
        }
      
        route {
          name = "my-first-grpc-route"
          disable_security_profile = false
      
          grpc_route {
            grpc_match {
              fqmn {
                prefix = "/"
              }
            }
      
            grpc_route_action {
              backend_group_id = "ds7dq9nsrgpc********"
              host_rewrite = "myapp"
              idle_timeout = "5s"
              max_timeout = "10s"
              rate_limit {
                all_requests {
                  per_minute = 0
                  per_second = 12
                }
                requests_per_ip {
                  per_minute = 0
                  per_second = 6
                }
              }
            }
          }
        }
      
        authority        = ["example.com"]
      
        modify_request_headers {
          name           = "Accept-Language"
          append         = "ru-RU"
        }
      
        modify_response_headers {
          name           = "Accept-Language"
          append         = "ru-RU"
        }
      
        route_options {
          security_profile_id = "fevu5fnuk6vf********"
        }
      }
      ```
      
      {% endcut %}

      Информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Обновите ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление, порядок ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% note warning "Ограничения по времени" %}
      
      Провайдер {{ TF }} ограничивает время на выполнение операций с HTTP-роутерами и виртуальными хостами {{ alb-name }} 10 минутами.
      
      Операции, которые длятся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию HTTP-роутера и виртуального хоста блоки `timeouts` (ресурсы `yandex_alb_http_router` и `yandex_alb_virtual_host` соответственно).
      
      Пример:
      
      ```hcl
      resource "yandex_alb_http_router" "<имя_роутера>" {
        ...
        timeouts {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md).

  {% note info %}
  
  Маршруты виртуального хоста будут применяться к поступающим запросам в том порядке, в котором они описаны в теле запроса.
  
  {% endnote %}

{% endlist %}

## Модифицировать параметры HTTP-запросов {#modify-http-parameters}

Маршруты [виртуальных хостов](../concepts/http-router.md#virtual-host) в [HTTP-роутерах](../concepts/http-router.md) {{ alb-full-name }} позволяют при необходимости модифицировать параметры HTTP-запросов, заменяя части запроса, удовлетворяющие [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax), другими значениями.

Например, такая модификация может быть полезна для управления версиями API, для микросервисной маршрутизации, для обеспечения обратной совместимости и нормализации URL, а также при [A/B тестировании](https://ru.wikipedia.org/wiki/A/B-тестирование) и в [канареечных релизах](../../api-gateway/concepts/extensions/canary.md).

Модифицировать параметры HTTP-запросов в маршрутах вы можете с помощью [{{ yandex-cloud }} CLI](../../cli/index.md), [{{ TF }}]({{ tf-provider-link }}) или [API](../api-ref/authentication.md).

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

      * `regex` — регулярное выражение стандарта RE2, при соответствии которому строка пути запроса будет изменена. В приведенном примере регулярное выражение описывает путь, начинающийся с префикса `/api/users/`, после которого следует любое количество любых символов (или не следует ничего). При этом все, что следует после префикса, сохраняется в группу (карман).
      * `substitute` — строка, на которую будет заменен путь, соответствующий регулярному выражению, которое задано в свойстве `regex`. В приведенном примере путь будет заменен на строку, состоящую из префикса `/api/v1/users/` и содержимого группы (кармана), которое было сохранено в регулярном выражении.

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

                  * `regex` — регулярное выражение стандарта RE2, при соответствии которому строка пути запроса будет изменена. В приведенном примере регулярное выражение описывает путь, начинающийся с префикса `/api/users/`, после которого следует любое количество любых символов (или не следует ничего). При этом все, что следует после префикса, сохраняется в группу (карман).
                  * `substitute` — строка, на которую будет заменен путь, соответствующий регулярному выражению, которое задано в свойстве `regex`. В приведенном примере путь будет заменен на строку, состоящую из префикса `/api/v1/users/` и содержимого группы (кармана), которое было сохранено в регулярном выражении.

              {% note info %}

              Параметры `regex_rewrite` и `prefix_rewrite` — взаимоисключающие: вы можете использовать только один из них.

              {% endnote %}

          Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Создайте или обновите ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление, изменение ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):

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
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../concepts/http-router.md), в котором находится нужный маршрут.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с виртуальным хостом, в котором находится нужный маршрут, в строке с именем нужного маршрута нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  С помощью {{ yandex-cloud }} CLI вы можете удалять из виртуального хоста разные [типы](../concepts/http-router.md#routes-types) маршрутов:

  {% list tabs group=alb_route_type%}

  - HTTP {#http}

    1. Посмотрите описание команды CLI для удаления маршрута виртуального хоста:

        ```bash
        yc alb virtual-host remove-http-route --help
        ```
    1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
       
       ```bash
       yc alb http-router list
       ```
       
       Результат:
       
       ```text
       +----------------------+--------------------+-------------+-------------+
       |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
       +----------------------+--------------------+-------------+-------------+
       | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
       | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
       +----------------------+--------------------+-------------+-------------+
       ```
    1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
       
       ```bash
       yc alb virtual-host list \
         --http-router-name <имя_HTTP-роутера> \
         --http-router-id <идентификатор_HTTP-роутера>
       ```
       
       Результат:
       
       ```text
       +-------------------+-------------+-------------+----------------------+
       |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
       +-------------------+-------------+-------------+----------------------+
       | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
       | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
       +-------------------+-------------+-------------+----------------------+
       ```
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
    1. Посмотрите список HTTP-роутеров в каталоге по умолчанию:
       
       ```bash
       yc alb http-router list
       ```
       
       Результат:
       
       ```text
       +----------------------+--------------------+-------------+-------------+
       |          ID          |        NAME        | VHOST COUNT | ROUTE COUNT |
       +----------------------+--------------------+-------------+-------------+
       | ds76j5n6a39g******** | sample-http-router |           1 |           2 |
       | ds76jk27sdf3******** | new-http-router    |           2 |           7 |
       +----------------------+--------------------+-------------+-------------+
       ```
    1. Посмотрите список виртуальных хостов в нужном HTTP-роутере, указав его имя или идентификатор соответственно в параметре `--http-router-name` или `--http-router-id`:
       
       ```bash
       yc alb virtual-host list \
         --http-router-name <имя_HTTP-роутера> \
         --http-router-id <идентификатор_HTTP-роутера>
       ```
       
       Результат:
       
       ```text
       +-------------------+-------------+-------------+----------------------+
       |        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
       +-------------------+-------------+-------------+----------------------+
       | my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
       | test-virtual-host | example.com |           2 | fevug3d25bv6******** |
       +-------------------+-------------+-------------+----------------------+
       ```
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

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Удалите в конфигурационном файле описание маршрута как ресурса, вложенного в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

      {% cut "Пример конфигурации виртуального хоста:" %}
      
      ```hcl
      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name           = "test-virtual-host"
        http_router_id = "ds76j5n6a39g********"
      
        rate_limit {
          all_requests {
            per_second = 5
          }
          requests_per_ip {
            per_second = 3
          }
        }
      
        route {
          name = "my-first-http-route"
          disable_security_profile = false
      
          http_route {
            http_match {
              http_method = ["GET","POST"]
              path {
                prefix = "/myapp/"
              }
            }
      
            http_route_action {
              backend_group_id = "ds7dnf2s5dco********"
              host_rewrite = "myapp"
              idle_timeout = "3s"
              prefix_rewrite = "/yourapp/"
              rate_limit {
                all_requests {
                  per_second = 12
                }
                requests_per_ip {
                  per_minute = 120
                }
              }
              timeout = "10s"
            }
          }
        }
      
        route {
          name = "my-first-grpc-route"
          disable_security_profile = false
      
          grpc_route {
            grpc_match {
              fqmn {
                prefix = "/"
              }
            }
      
            grpc_route_action {
              backend_group_id = "ds7dq9nsrgpc********"
              host_rewrite = "myapp"
              idle_timeout = "5s"
              max_timeout = "10s"
              rate_limit {
                all_requests {
                  per_minute = 0
                  per_second = 12
                }
                requests_per_ip {
                  per_minute = 0
                  per_second = 6
                }
              }
            }
          }
        }
      
        authority        = ["example.com"]
      
        modify_request_headers {
          name           = "Accept-Language"
          append         = "ru-RU"
        }
      
        modify_response_headers {
          name           = "Accept-Language"
          append         = "ru-RU"
        }
      
        route_options {
          security_profile_id = "fevu5fnuk6vf********"
        }
      }
      ```
      
      {% endcut %}

      Информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Обновите ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы. Проверить появление, удаление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% note warning "Ограничения по времени" %}
      
      Провайдер {{ TF }} ограничивает время на выполнение операций с HTTP-роутерами и виртуальными хостами {{ alb-name }} 10 минутами.
      
      Операции, которые длятся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию HTTP-роутера и виртуального хоста блоки `timeouts` (ресурсы `yandex_alb_http_router` и `yandex_alb_virtual_host` соответственно).
      
      Пример:
      
      ```hcl
      resource "yandex_alb_http_router" "<имя_роутера>" {
        ...
        timeouts {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [removeRoute](../api-ref/VirtualHost/removeRoute.md) для ресурса [VirtualHost](../api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/RemoveRoute](../api-ref/grpc/VirtualHost/removeRoute.md).

{% endlist %}