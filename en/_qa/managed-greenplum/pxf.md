#### How are user credentials transmitted when working with external tables? {#pxf-users}

When working with [external tables over the PXF protocol](../../managed-greenplum/concepts/external-tables.md), user credentials are transmitted as plaintext. Therefore, such credentials are only available to [the administrator with the MDB_ADMIN role](../../managed-greenplum/concepts/cluster-users.md), while other users have no access to them for security reasons.
