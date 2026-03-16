```bash
psql "host=<список_хостов_кластера> \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<имя_БД> \
      user=<имя_пользователя> \
      target_session_attrs=read-write"
```
