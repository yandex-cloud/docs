### No data transfer after changing a source endpoint {#no-data-transfer}

After adding tables to the **List of included tables** in the source endpoint parameters, a data transfer restarted and stopped.

**Solution:**

* Create tables in the target database manually.

   1\. Create new tables with a `Primary key` and without a `Foreign key` in the target database.
   2\. Add the new tables to the **List of included tables** in the [source endpoint parameters](../../../../data-transfer/operations/endpoint/source/postgresql#additional-setting).
   3\. Transfer a dump with historical data to the target database.
   4\. If there are errors in the logs, fix them depending on a specific error.
   5\. If there are no errors but the logs are empty, contact [technical support]({{ link-console-support }}) or your account manager for a dump of goroutines. This may help resume replication without a restart.

* [Deactivate](../../../../data-transfer/operations/transfer.md#deactivate) and [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
* [Create](../../../../data-transfer/operations/transfer.md#create) a separate transfer of the _{{ dt-type-copy }}_ type for the new tables. Deactivating the original transfer is not required.
