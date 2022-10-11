### No table found {#no-tables}

Error message:

```text
Unable to find any tables
```

An empty number of collections was extracted from the database. The user might be missing permissions for the database used in the transfer.

**Solution:** for the database to be transferred, grant the user the transfer uses to connect to the source `readWrite` permissions.
