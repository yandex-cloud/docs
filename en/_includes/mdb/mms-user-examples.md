## Examples {#examples}

### Add a user with read-only permissions {#user-read-only}

To add a new user `user2` to an existing cluster with read-only access to the `db1` database:

1. [Create a user](../../managed-sqlserver/operations/cluster-users.md#adduser) with the name `user2`. Select the databases that the user should have access to.

1. [Connect](../../managed-sqlserver/operations/connect.md#connection-string) to the `db1` database under the account of the database owner.

1. To only grant access rights to the `Products` table, in the default `dbo` schema, run the command:

   ```sql
   GRANT SELECT ON dbo.Products TO user2;
   GO
   ```

1. To grant access permissions to all the `myschema` schema tables, run the command:

   ```sql
   GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::myschema TO user2;
   GO
   ```

To revoke the granted privileges, run the commands:

```sql
REVOKE SELECT ON dbo.Products FROM user2;
REVOKE SELECT, INSERT, UPDATE, DELETE ON SCHEMA::myschema FROM user2;
GO
```

