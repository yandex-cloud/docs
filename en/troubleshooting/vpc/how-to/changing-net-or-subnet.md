# How to change the network or subnet for an MDB cluster


## Scenario description {#case-description}

You need to change the cloud network or subnet for the MDB cluster.

## Solution {#case-resolution}

The network where the cluster is located can only be specified at cluster creation. Alternatively, you can restore the existing cluster from a backup, specifying the relevant network under "Network settings" during recovery.

The process of recovery from a backup is detailed in the [documentation](../../../managed-clickhouse/operations/cluster-backups#restore).
