```bash
psql "host=<особый_FQDN> \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<имя_БД> \
      user=<имя_пользователя> \
      target_session_attrs=read-write"
```
