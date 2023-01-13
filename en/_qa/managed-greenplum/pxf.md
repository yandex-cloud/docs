# Working with external tables

#### How are user credentials passed when working with external tables? {#pxf-users}

When working with [external tables using the PXF protocol](../../managed-greenplum/operations/external-tables.md), user credentials are transmitted in clear text. Therefore, the credentials are available only to the [administrator user with the MDB_ADMIN role](../../managed-greenplum/concepts/cluster-users.md), the credentials are not available to other users for security reasons.