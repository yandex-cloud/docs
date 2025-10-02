Добавьте маршрут, указав его имя и дополнительные параметры:

```bash
yc alb virtual-host append-http-route <имя_маршрута> \
  --http-router-name <имя_HTTP-роутера> \
  --virtual-host-name <имя_виртуального_хоста> \
  --match-http-method <метод_1>,<метод_2>,...<метод_n> \
  --exact-path-match <полный_путь> \
  --prefix-path-match <префикс_пути> \
  --regex-path-match <регулярное_выражение> \
  --backend-group-name <имя_группы_бэкендов> \
  --request-timeout <таймаут_запроса>s \
  --request-idle-timeout <таймаут_ожидания_запроса>s \
  --rate-limit rps=<лимит_запросов>,requests-per-ip \
  --disable-security-profile
```