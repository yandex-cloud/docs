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

Подробную информацию о команде `yc alb virtual-host append-grpc-route` с полным перечнем параметров см. в [справочнике CLI](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-grpc-route.md).