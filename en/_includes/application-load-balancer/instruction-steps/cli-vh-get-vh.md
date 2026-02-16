To find out the current route order in the virtual host, run the command below specifying the virtual host name and the HTTP router name or ID in the `--http-router-name` or `--http-router-id` parameter, respectively:

```bash
yc alb virtual-host get <virtual_host_name> \
  --http-router-name <HTTP_router_name> \
  --http-router-id <HTTP_router_ID>
```