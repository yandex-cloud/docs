```bash
psql "host=c-<идентификатор кластера>.rw.{{ dns-zone }} \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<имя БД> \
      user=<имя пользователя> \
      target_session_attrs=read-write"
```
