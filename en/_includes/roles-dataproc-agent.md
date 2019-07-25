#### mdb.dataproc.agent {#mdb-dataproc-agent}

The `mdb.dataproc.agent` role allows a service account attached to the {{ dataproc-name }} cluster to communicate status of each host in the cluster to the service.

This role must be assigned to the service account specified during [cluster creation](../data-proc/operations/cluster-create.md).

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}