### External table has more URLs than segments error {#external_table_url_limit}

Error example:

```pgsql
Unable to select and insert with external WRITABLE table: ERROR: external table has more URLs than available primary segments that can write into them
```

This error occurs if the number of threads exceeds the number of tables.

**Solution**: Set the number of threads to not exceed the number of tables.