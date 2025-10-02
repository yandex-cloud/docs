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