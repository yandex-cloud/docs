{% cut "Result:" %}

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