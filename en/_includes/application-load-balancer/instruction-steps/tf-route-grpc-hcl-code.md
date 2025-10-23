```hcl
...
route {
  name                      = "<route_name>"
  disable_security_profile  = true|false

  grpc_route {
    grpc_match {
      fqmn {
        prefix = "/<request_FQMN_prefix>"
        # or exact = "<request_FQMN>"
        # or regex = "<regular_expression>"
      }
    }

    grpc_route_action {
      backend_group_id = "<backend_group_ID>"
      host_rewrite = "<Host_header_value>"
      max_timeout = "<connection_timeout>s"
      idle_timeout = "<idle_timeout>s"
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
...
```