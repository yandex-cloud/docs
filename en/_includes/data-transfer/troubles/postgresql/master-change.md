### Transfer error when changing a master host {#master-change}

The error occurs in _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfers due to required Write-Ahead Log (WAL) parts missing. This occurs when the Write Ahead Log (WAL) logical replication lag between the current master and a replica is greater than the allowable WAL size on other hosts, so, when switching from the master to the replica, the replication slot can't sync to the WAL on the new master.

**Solution:** set a limit in the [additional target endpoint parameter](../../../../data-transfer/operations/endpoint/source/postgresql#additional-setting) **Maximum WAL size for the replication slot** and [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
