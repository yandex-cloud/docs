### Insufficient replication slots in a source database {#replication-slots}

Error message:

```text
Warn(Activate): failed to create a replication slot "<transfer_ID>" at source:
failed to create a replication slot:
failed to create a replication slot:
ERROR: all replication slots are in use
(SQLSTATE 53400)
```

**Solution:** Increase the number of [replication slots]({{ pg-docs }}/logical-replication-config.html) in the source database (by default, `10`).
