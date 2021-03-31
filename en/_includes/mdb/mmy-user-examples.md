## Examples {#examples}

### Add a user with read-only permissions {#user-read-only}

To add a new user `user2` to an existing cluster with read-only access to the `db1` database:

1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) with the name `user2`. Select the databases that the user should have access to.

1. [Connect](../../managed-mysql/operations/connect.md#connection-string) to the `db1` database under the account of the database owner.

1. To assign access rights for the `Products` table only, in the `db1` database, run the command:

   ```sql
   GRANT SELECT ON Products TO user2;
   ```

1. To grant access rights to the `db1` database, run the command:

   ```sql
   GRANT SELECT ON db1.* TO user2;
   ```

To revoke the granted privileges, run the commands:

```sql
REVOKE SELECT ON Products FROM user2;

REVOKE SELECT ON db1.* FROM user2;
```

