```bash
yc alb backend-group add-stream-backend \
  --backend-group-name <имя_бэкенд_группы> \
  --name <имя_добавляемого_бэкенда> \
  --weight <вес_бэкенда> \
  --port <порт_бэкенда> \
  --target-group-id=<идентификатор_целевой_группы> \
  --panic-threshold 90 \
  --enable-proxy-protocol \
  --keep-connections-on-host-health-failure \
  --stream-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
timeout=10s,interval=2s,send-text=<данные_к_эндпоинту>,receive-text=<данные_от_эндпоинта>
```