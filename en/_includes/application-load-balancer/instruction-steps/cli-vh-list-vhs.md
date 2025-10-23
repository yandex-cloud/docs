View the list of virtual hosts in an HTTP router by specifying the router name or ID, respectively, in the `--http-router-name` or `--http-router-id` parameter:

```bash
yc alb virtual-host list \
  --http-router-name <HTTP_router_name> \
  --http-router-id <HTTP_router_ID>
```

Result:

```text
+-------------------+-------------+-------------+----------------------+
|        NAME       | AUTHORITIES | ROUTE COUNT | SECURITY PROFILE ID  |
+-------------------+-------------+-------------+----------------------+
| my-virtual-host   | *           |           1 | fevu5fnuk6vf******** |
| test-virtual-host | example.com |           2 | fevug3d25bv6******** |
+-------------------+-------------+-------------+----------------------+
```