### Long transfer activation {#long-time}

**Solution:** If a transfer [being activated](../../../data-transfer/operations/transfer.md#activate) is in the {{ dt-status-creation }} status for a long time, it's not an error. It takes time to create {{ compute-full-name }} resources that are allocated for each transfer individually. For some sources, a database schema is extracted, which also takes time.
