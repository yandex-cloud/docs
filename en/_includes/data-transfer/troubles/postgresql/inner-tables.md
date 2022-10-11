### Error when transferring nested transactions {#inner-tables}

Transfers of {{ PG }} below version 14 don't support a transfer of tables with committed transactions that are nested more than 1024 times with replication changes at each nesting level. The degree of nesting depends on the number of nested `begin; .. commit;` statements.

**Solution:**

* Use {{ PG }} 14 or higher.
* Exclude transactions with a nesting level like this from a transfer.
