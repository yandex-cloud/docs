```bash
psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=postgres \
      user=<username> \
      target_session_attrs=read-write"
```
