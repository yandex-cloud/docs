# {{ ydb-full-name }} and {{ yds-full-name }}

In certain cases, transfers of type _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ terminate with the following error: `/Ydb.PersQueue.V1.PersQueueService/AddReadRule failed: OVERLOADED`.

It results from a limitation on the cloud quota for the number of transactions with {{ ydb-name }}.

To resolve the problem:

1. Increase the **Number of schema transactions per minute** property in the {{ ydb-name }} quotas for the cloud with the required database.
1. [Restart](../operations/transfer.md#reupload) the transfer.
