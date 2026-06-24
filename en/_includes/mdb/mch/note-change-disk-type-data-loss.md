{% note warning %}

When you change the disk type, the cluster hosts get recreated. The system automatically saves the replicated tables data. The non-replicated tables data will be lost. If you need to preserve data in non-replicated tables, [convert it to replicated]({{ ch.docs }}{{ lang }}/sql-reference/statements/attach#attach-mergetree-table-as-replicatedmergetree) before you change the disk type.

{% endnote %}
