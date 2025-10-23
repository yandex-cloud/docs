Add the route by specifying its name and additional parameters:

```bash
yc alb virtual-host append-grpc-route <route_name> \
  --http-router-name <HTTP_router_name> \
  --virtual-host-name <virtual_host_name> \
  --exact-fqmn-match <full_FQMN> \
  --prefix-fqmn-match <FQMN_prefix> \
  --regex-fqmn-match <regular_expression> \
  --backend-group-name <backend_group_name> \
  --request-max-timeout <request_timeout>s \
  --request-idle-timeout <request_idle_timeout>s \
  --rate-limit rps=<request_limit>,requests-per-ip \
  --disable-security-profile
```