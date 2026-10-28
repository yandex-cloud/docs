# Managing data tiering in {{ mrd-name }}

You can enable [data tiering](../concepts/storage.md#data-tiering) to move infrequently used data from RAM to disk.

{% list tabs group=instructions %}

- Management console {#console}

    Enable data tiering in a {{ mrd-name }} cluster:

    * When [creating a cluster](cluster-create.md), select `Valkey TS 9.1` for DBMS version.

    * For an existing cluster, [upgrade](cluster-version-update.md) to `Valkey TS 9.1`. If your cluster’s version is lower than `9.1`, first, upgrade the cluster to this version.

{% endlist %}
