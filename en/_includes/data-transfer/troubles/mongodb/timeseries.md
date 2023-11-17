### Error when transferring timeseries collections {#timeseries}

Error messages:

```text
Unable to find any tables
```

```text
Cannot execute mongo activate hook:
Failed in accordance with configuration:
some tables from include list are missing in the source database: [<collection_name>]
```

The service does not support transfers of [Time Series collections]({{ mg.docs.comd }}/core/timeseries-collections/).

**Solution:** [exclude](../../../../data-transfer/operations/endpoint/source/mongodb.md#additional-settings) any Time Series collections from the transfer and [reactivate](../../../../data-transfer/operations/transfer.md#activate) it.
