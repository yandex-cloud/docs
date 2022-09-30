### dataproc.agent {#mdb-dataproc-agent}

The `dataproc.agent` role allows the service account assigned to the {{ dataproc-name }} cluster to notify the service of the status of each host in the cluster.

This role must be assigned to the service account specified when [creating the cluster](../data-proc/operations/cluster-create.md).

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}

### mdb.dataproc.agent {#mdb-dataproc-agent-deprecated}

{% note warning %}

The `mdb.dataproc.agent` role will soon be discontinued. Users with this role will automatically be assigned the [dataproc.agent](#mdb-dataproc-agent) role with the same rights. We do not recommend using this role.

{% endnote %}

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
