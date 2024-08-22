### No new tables are added {#no-new-tables}

No new tables are added to _{{ dt-type-copy-repl}}_ transfers.

**Solution**:

* [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) and [reactivate](../../../data-transfer/operations/transfer.md#activate) the transfer.
* Create tables in the target database manually.
* [Create](../../../data-transfer/operations/transfer.md#create) a separate transfer of the _{{ dt-type-copy }}_ type and only add to it the newly created tables. Deactivating the original _{{ dt-type-copy-repl}}_ transfer is not required.
