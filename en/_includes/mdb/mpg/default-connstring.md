```bash
psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<user_name> \
      target_session_attrs=read-write"
```
