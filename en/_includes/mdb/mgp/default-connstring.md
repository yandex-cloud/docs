```bash
psql "host=<primary_master_host_FQDN>,<standby_master_host_FQDN> \
      port={{ port-mgp }} \
      sslmode=verify-full \
      dbname=postgres \
      user=<username> \
      target_session_attrs=read-write"
```
