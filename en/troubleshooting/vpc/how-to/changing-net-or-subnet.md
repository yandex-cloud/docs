# How to change the network or subnet for an MDB cluster



## Case description {#case-description}

You need to change the cloud network or subnet for your MDB cluster.

## Solution {#case-resolution}

You can only specify the network when creating a cluster. Alternatively, you can restore the existing cluster from a backup and specify the relevant network under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**.

You can learn more about backup recovery in [this guide](../../../managed-clickhouse/operations/cluster-backups.md#restore).