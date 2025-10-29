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