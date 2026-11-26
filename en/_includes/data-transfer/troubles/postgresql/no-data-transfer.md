### No data transfer after changing a source endpoint {#no-data-transfer}

After adding tables to the **List of included tables** in the source endpoint parameters, a data transfer restarted and stopped.

**Solution:**

* Create tables in the target database manually.

    1\. In the target database, create new tables with `Primary key` and without `Foreign key`.
    2\. Add the new tables to the **List of included tables** in the [source endpoint parameters](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings).
    3\. Transfer a dump with historical data to the target database.
    4\. If there are errors in the logs, fix them depending on a specific error.
    5\. If there are no errors but the logs are empty, contact [technical support]({{ link-console-support }}) or your account manager to take a goroutine dump. This may help resume replication without restarting the transfer.

* [Deactivate](../../../../data-transfer/operations/transfer.md#deactivate) and [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
* [Create](../../../../data-transfer/operations/transfer.md#create) a separate transfer of the _{{ dt-type-copy }}_ type for the new tables. Deactivating the original transfer is not required.
