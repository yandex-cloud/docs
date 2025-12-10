{% note alert "Important" %}

When restoring a backup to a cluster without any {{ ZK }} hosts, all the `ReplicatedMergeTree` tables will be converted to simple `MergeTree` tables. Converted tables will contain the same data. For more information, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/).

{% endnote %}

