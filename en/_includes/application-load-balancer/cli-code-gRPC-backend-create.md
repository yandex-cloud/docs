```bash
yc alb backend-group add-grpc-backend \
  --backend-group-name <backend_group_name> \
  --name <name_of_backend_you_are_adding> \
  --weight <backend_weight> \
  --port <backend_port> \
  --target-group-id=<target_group_ID> \
  --panic-threshold 90 \
  --grpc-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
timeout=10s,interval=2s,service-name=<gRPC_service_name>
```