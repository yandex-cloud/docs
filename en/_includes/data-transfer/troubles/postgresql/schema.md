### Error when transferring all schema tables {#schema}

Error message:

```text
Unable to apply DDL of type 'TABLE', name '<schema>'.'<table>', error:
ERROR: schema "<schema name>" does not exist (SQLSTATE 3F000)
```

A transfer fails if tables of a specific schema are listed as `<schema>.*`. This occurs due to the specifics of `pg_dump` that is used for a schema transfer. When specifying tables of the entire schema in `<schema>.*` format in the [source endpoint parameter](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings) **Table filter** → **Included tables**, the {{ PG }} types from this schema aren't extracted even if it contains tables that depend on these types.

**Solution:** Create {{ PG }} types in the target database manually.
