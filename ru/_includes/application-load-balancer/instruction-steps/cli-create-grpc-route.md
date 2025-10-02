{{ yandex-cloud }} CLI позволяет использовать три разных команды для добавления gRPC-маршрутов в виртуальный хост:

* `yc alb virtual-host append-grpc-route` — добавляет маршрут в конец списка маршрутов виртуального хоста.
* `yc alb virtual-host prepend-grpc-route` — добавляет маршрут в начало списка маршрутов виртуального хоста.
* `yc alb virtual-host insert-grpc-route` — добавляет маршрут в указанное место внутри списка маршрутов виртуального хоста.

{% list tabs %}

- append-grpc-route

  1. {% include [cli-vh-append-grpc-route-help](./cli-vh-append-grpc-route-help.md) %}
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. {% include [cli-vh-append-grpc-route-code](./cli-vh-append-grpc-route-code.md) %}

      Где:

      {% include [cli-grpc-route-creation-legend](./cli-grpc-route-creation-legend.md) %}

      {% include [cli-vh-append-grpc-route-output](./cli-vh-append-grpc-route-output.md) %}

- prepend-grpc-route

  1. Посмотрите описание команды CLI для добавления маршрута в начало списка маршрутов:

      ```bash
      yc alb virtual-host prepend-grpc-route --help
      ```
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
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

      {% include [cli-grpc-route-creation-legend](./cli-grpc-route-creation-legend.md) %}

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

      Подробную информацию о команде `yc alb virtual-host prepend-grpc-route` с полным перечнем параметров см. в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-grpc-route.md).


- insert-grpc-route

  1. Посмотрите описание команды CLI для добавления маршрута в заданное место в списке маршрутов:

      ```bash
      yc alb virtual-host insert-grpc-route --help
      ```
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. {% include [cli-vh-get-vh](./cli-vh-get-vh.md) %}

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

      {% include [cli-grpc-route-creation-legend](./cli-grpc-route-creation-legend.md) %}

      {% include [cli-grpc-route-creation-legend-before-after](./cli-grpc-route-creation-legend-before-after.md) %}

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

      Подробную информацию о команде `yc alb virtual-host insert-grpc-route` с полным перечнем параметров см. в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-grpc-route.md).

{% endlist %}