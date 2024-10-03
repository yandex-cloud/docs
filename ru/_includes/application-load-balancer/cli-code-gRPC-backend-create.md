```bash
yc alb backend-group add-grpc-backend \
  --backend-group-name <имя_бэкенд_группы> \
  --name <имя_добавляемого_бэкенда> \
  --weight <вес_бэкенда> \
  --port <порт_бэкенда> \
  --target-group-id=<идентификатор_целевой_группы> \
  --panic-threshold 90 \
  --grpc-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
timeout=10s,interval=2s,service-name=<имя_gRPC-сервиса>
```