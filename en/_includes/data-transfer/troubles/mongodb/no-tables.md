### No tables found {#no-tables}

Error message:

```text
Unable to find any tables
```

An empty number of collections was extracted from the database. This error may occur if the user lacks permissions for the database used in the transfer.

**Solution**: Grant `readWrite` permissions for the database being trasferred to the user on whose behalf the transfer is connecting to the source.
