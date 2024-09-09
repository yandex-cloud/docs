#### How are user credentials transmitted when working with external tables? {#pxf-users}

When working with [external tables using the PXF protocol](../../managed-greenplum/concepts/external-tables.md), user credentials are provided as plain text. Therefore, such credentials are only available to the administrator user with the `mdb_admin` [role](../../managed-greenplum/concepts/cluster-users.md#mdb_admin). Other users have no access to the credentials for security reasons.
