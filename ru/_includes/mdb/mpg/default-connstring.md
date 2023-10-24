```bash
psql "host=c-<идентификатор_кластера>.rw.{{ dns-zone }} \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<имя_БД> \
      user=<имя_пользователя> \
      target_session_attrs=read-write"
```
