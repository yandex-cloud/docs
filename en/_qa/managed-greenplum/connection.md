#### Can I connect to the database as a superuser? {#super-user}

No, you cannot. However, you can connect as an admin user with the `mdb_admin` role. The privileges it has matches those of the superuser. For more information, see [{#T}](../../managed-greenplum/concepts/cluster-users.md#mdb_admin).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mgp-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-greenplum/operations/connect.md).

#### How do I set up user authentication? {#auth-user}

You can set up user authentication in {{ mgp-name }} using [rules](../../managed-greenplum/operations/user-auth-rules.md).

For more information, see [{#T}](../../managed-greenplum/concepts/user-authentication.md).
