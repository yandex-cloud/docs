{% note info %}

{% if audience != "internal" %}

Технология [Point-in-Time-Recovery](../../managed-mongodb/concepts/backup.md) для {{ mmg-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md): воспользоваться ей можно только при восстановлении из резервной копии с помощью CLI. На стадии General Availability это ограничение будет снято. Технология [включается по запросу](../../managed-mongodb/operations/cluster-list.md#get-cluster).

{% else %}

Технология [Point-in-Time-Recovery](../../managed-mongodb/concepts/backup.md) для {{ mmg-name }} находится на стадии Preview: воспользоваться ей можно только при восстановлении из резервной копии с помощью CLI. На стадии General Availability это ограничение будет снято. Технология [включается по запросу](../../managed-mongodb/operations/cluster-list.md#get-cluster).

{% endif %}

{% endnote %}