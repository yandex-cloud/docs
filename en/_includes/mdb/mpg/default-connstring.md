```bash
psql "host=c-<cluster ID>.rw.{{ dns-zone }} \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<user name> \
      target_session_attrs=read-write"
```
