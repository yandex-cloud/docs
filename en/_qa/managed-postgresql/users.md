#### Can I migrate users from a {{ PG }} source cluster to a {{ mpg-name }} target cluster? {#user-migration}

No, you cannot automatically migrate users from a third-party {{ PG }} cluster or a {{ mpg-name }} cluster to a {{ mpg-name }} cluster. You have to [create users](../../managed-postgresql/operations/cluster-users.md#adduser) once again in the target cluster.
