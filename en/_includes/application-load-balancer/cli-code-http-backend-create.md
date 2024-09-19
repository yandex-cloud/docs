```bash
yc alb backend-group add-http-backend \
  --backend-group-name <backend_group_name> \
  --name <name_of_backend_being_added> \
  --weight <backend_weight> \
  --port <backend_port> \
  --target-group-id=<target_group_ID> \
  --panic-threshold 90 \
  --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
timeout=10s,interval=2s,host=<host_address>,path=<path>
```