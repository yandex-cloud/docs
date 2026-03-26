```bash
psql "host=<FQDN_первичного_хоста-мастера>,<FQDN_резервного_хоста-мастера> \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=postgres \
      user=<имя_пользователя> \
      target_session_attrs=read-write"
```
