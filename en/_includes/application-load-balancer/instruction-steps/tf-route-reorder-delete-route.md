{% cut "Example of a virtual host configuration:" %}

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
          prefix = "myapp/"
        }
      }

      http_route_action {
        backend_group_id = "ds7dnf2s5dco********"
        host_rewrite = "myapp"
        idle_timeout = "3s"
        prefix_rewrite = "yourapp/"
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