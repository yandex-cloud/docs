{{ yandex-cloud }} CLI позволяет использовать три разных команды для добавления HTTP-маршрутов в виртуальный хост:

* `yc alb virtual-host append-http-route` — добавляет маршрут в конец списка маршрутов виртуального хоста.
* `yc alb virtual-host prepend-http-route` — добавляет маршрут в начало списка маршрутов виртуального хоста.
* `yc alb virtual-host insert-http-route` — добавляет маршрут в указанное место внутри списка маршрутов виртуального хоста.

{% list tabs %}

- append-http-route

  1. {% include [cli-vh-append-http-route-help](./cli-vh-append-http-route-help.md) %}
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. {% include [cli-vh-append-http-route-code](./cli-vh-append-http-route-code.md) %}

      Где:

      {% include [cli-http-route-creation-legend](./cli-http-route-creation-legend.md) %}

      {% include [cli-vh-append-http-route-output](./cli-vh-append-http-route-output.md) %}

- prepend-http-route

  1. Посмотрите описание команды CLI для добавления маршрута в начало списка маршрутов:

      ```bash
      yc alb virtual-host prepend-http-route --help
      ```
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
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

      {% include [cli-http-route-creation-legend](./cli-http-route-creation-legend.md) %}

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

      Подробную информацию о команде `yc alb virtual-host prepend-http-route` с полным перечнем параметров см. в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-http-route.md).

- insert-http-route

  1. Посмотрите описание команды CLI для добавления маршрута в заданное место в списке маршрутов:

      ```bash
      yc alb virtual-host insert-http-route --help
      ```
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. {% include [cli-vh-get-vh](./cli-vh-get-vh.md) %}

      {% include [cli-vh-get-vh-output](./cli-vh-get-vh-output.md) %}

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

      {% include [cli-http-route-creation-legend](./cli-http-route-creation-legend.md) %}

      {% include [cli-grpc-route-creation-legend-before-after](./cli-grpc-route-creation-legend-before-after.md) %}

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

      Подробную информацию о команде `yc alb virtual-host insert-http-route` с полным перечнем параметров см. в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-http-route.md).

{% endlist %}