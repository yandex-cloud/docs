Добавьте маршрут, указав его имя и дополнительные параметры:

```bash
yc alb virtual-host append-grpc-route <имя_маршрута> \
  --http-router-name <имя_HTTP-роутера> \
  --virtual-host-name <имя_виртуального_хоста> \
  --exact-fqmn-match <полный_FQMN> \
  --prefix-fqmn-match <префикс_FQMN> \
  --regex-fqmn-match <регулярное_выражение> \
  --backend-group-name <имя_группы_бэкендов> \
  --request-max-timeout <таймаут_запроса>s \
  --request-idle-timeout <таймаут_ожидания_запроса>s \
  --rate-limit rps=<лимит_запросов>,requests-per-ip \
  --disable-security-profile
```