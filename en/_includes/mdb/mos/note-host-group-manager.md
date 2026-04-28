{% note warning %}

If you add a host group with the `MANAGER` role to a cluster where this role is assigned to hosts with the `DATA` role, you will be unable to delete that group. The only way to restore the previous host configuration is to [restore the cluster from a backup](../../../managed-opensearch/operations/cluster-backups.md#restore).

{% endnote %}
