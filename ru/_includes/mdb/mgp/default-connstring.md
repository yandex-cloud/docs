```bash
psql "host=c-<идентификатор_кластера>.rw.{{ dns-zone }} \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=postgres \
      user=<имя_пользователя> \
      target_session_attrs=read-write"
```
