```bash
psql "host=c-<идентификатор кластера>.rw.{{ dns-zone }} \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=postgres \
      user=<имя пользователя> \
      target_session_attrs=read-write"
```
