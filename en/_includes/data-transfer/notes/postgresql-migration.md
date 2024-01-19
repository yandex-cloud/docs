{% note info %}

[Enable](../../../managed-postgresql/operations/extensions/cluster-extensions.md) the `pg_tm_aux` extension for your {{ PG }} cluster. This will allow replication to continue following a replacement of the master host. In some cases, a transfer may end in an error after you replace a master in your cluster. For more information, see [Troubleshooting](../../../data-transfer/troubleshooting/index.md#master-change).

{% endnote %}
