#### Can I connect to the DB via SSH and get superuser permissions? {#super-user}

No, you cannot connect via SSH, nor can you get superuser permissions. This is done for the sake of security and user cluster fault tolerance because direct changes inside hosts can render them completely inoperable. However, you can connect to the DB as an admin user with the `mdb_admin` role. The privileges it has match those of the superuser. For more information, see [{#T}](../../managed-greenplum/concepts/cluster-users.md#mdb_admin).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mgp-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-greenplum/operations/connect.md).

#### How do I set up user authentication? {#auth-user}

You can set up user authentication in {{ mgp-name }} using [rules](../../managed-greenplum/operations/user-auth-rules.md).

For more information, see [{#T}](../../managed-greenplum/concepts/user-authentication.md).
