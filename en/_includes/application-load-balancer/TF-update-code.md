```hcl
resource "yandex_alb_backend_group" "test-backend-group" {
  name                     = "<backend_group_name>"

  stream_backend {
    name                   = "<backend_name>"
    weight                 = 1
    port                   = 80
    target_group_ids       = ["<target_group_ID>"]
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
        send               = "<data_to_endpoint>"
        receive            = "<data_from_endpoint>"
      }
    }
  }
}
```