```hcl
resource "yandex_alb_backend_group" "test-backend-group" {
  name                     = "<имя_группы_бэкендов>"

  stream_backend {
    name                   = "<имя_бэкенда>"
    weight                 = 1
    port                   = 80
    target_group_ids       = ["<идентификатор_целевой_группы>"]
    load_balancing_config {
      panic_threshold      = 90
    }
    enable_proxy_protocol  = true
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15 
      stream_healthcheck {
        send               = "<данные_к_эндпоинту>"
        receive            = "<данные_от_эндпоинта>"
      }
    }
  }
}
```