### Required user permissions missing {#permission-denied}

Error message:

```text
Warn(Activate): failed to load schema using pg_dump:
unable to execute pg_dump to get sequence data:
Unable to exec pg_dump: exit status 1;
stderr: pg_dump: error: query failed: ERROR: permission denied for
```

**Solution:** [prepare a source](../../../data-transfer/operations/prepare.md#source) and [reactivate](../../../data-transfer/operations/transfer.md#activate) the transfer.
