### Error when replicating data from an external source {#external-replication}

Error message:

```text
[XX000] ERROR: could not connect to the publisher:
SSL error: certificate verify failed FATAL:
no pg_hba.conf entry for replication connection
from host "<{{ PG }}_host_IP_address>", user "postgres", SSL off
```

**Solution:** Prepare the source as described in [Preparing for the transfer](../../../../data-transfer/operations/prepare.md#source-pg).
