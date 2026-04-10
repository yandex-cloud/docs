```bash
psql "host=<list_of_cluster_hosts> \
      port={{ port-mpg }} \
      sslmode=verify-full \
      dbname=<DB_name> \
      user=<username> \
      target_session_attrs=read-write"
```
