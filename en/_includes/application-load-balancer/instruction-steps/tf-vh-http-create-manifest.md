```hcl
resource "yandex_alb_virtual_host" "my-virtual-host" {
  name           = "<virtual_host_name>"
  http_router_id = "<HTTP_router_ID>"

  rate_limit {
    all_requests {
      per_second = <requests_per_second>
      # or per_minute = <requests_per_minute>
    }
    requests_per_ip {
      per_second = <requests_per_second>
      # or per_minute = <requests_per_minute>
    }
  }

  route {
    name                      = "<route_name>"
    disable_security_profile  = true|false

    http_route {
      http_match {
        http_method = ["<HTTP_method_1>","<HTTP_method_2>",...,"<HTTP_method_n>"]
        path {
          prefix = "<request_path_prefix>/"
          # or exact = "<request_path>"
          # or regex = "<regular_expression>"
        }
      }

      http_route_action {
        backend_group_id  = "<backend_group_ID>"
        host_rewrite      = "<Host_header_value>"
        timeout           = "<connection_timeout>s"
        idle_timeout      = "<idle_timeout>s"
        prefix_rewrite    = "<new_request_path_prefix>/"
        rate_limit {
          all_requests {
            per_second = <requests_per_second>
            # or per_minute = <requests_per_minute>
          }
          requests_per_ip {
            per_second = <requests_per_second>
            # or per_minute = <requests_per_minute>
          }
        }
      }
    }
  }

  authority        = ["<domain_1>","<domain_2>",...,"<domain_n>"]

  modify_request_headers {
    name           = "<header_name>"
    append         = "<string_added_to_header_content>"
    # or replace  = "<new_header_content>"
    # or remove   = true|false
  }

  modify_response_headers {
    name           = "<header_name>"
    append         = "<string_added_to_header_content>"
    # or replace  = "<new_header_content>"
    # or remove   = true|false
  }

  route_options {
    security_profile_id = "<security_profile_ID>"
  }
}
```