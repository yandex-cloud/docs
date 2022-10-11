### Transfer failure {#overloaded}

A _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfer is interrupted with an error.

Error message:

```text
/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED
```

Transfers are aborted due to the cloud [quota]({{ link-console-quotas }}) on the number of operations with {{ ydb-name }}.

**Solution:**

1. Increase the **Number of schema transactions per minute** property in the {% if audience != "internal" %}[{{ ydb-name }} quotas](../../../ydb/concepts/limits.md){% else %}{{ ydb-name }} quotas{% endif %} for the cloud with the required database.
1. [Restart](../../../data-transfer/operations/transfer.md#reupload) the transfer.
