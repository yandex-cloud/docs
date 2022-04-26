{% note alert "Important" %}

When restoring a backup to a cluster without any {{ ZK }} hosts, all the tables in the ReplicatedMergeTree family engine are converted to simple MergeTree tables. Data in the converted tables is saved. For more information, see the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/engines/table-engines/mergetree-family/replication/).

{% endnote %}

