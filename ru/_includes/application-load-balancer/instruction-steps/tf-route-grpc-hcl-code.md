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