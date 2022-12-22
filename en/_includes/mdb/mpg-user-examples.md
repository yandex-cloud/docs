## Examples {#examples}

### Add a user with read-only permissions {#user-readonly}

To add a new user `user2` to an existing cluster with read-only access to the `db1` database:

1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser) named `user2`. Select the databases that the user should have access to.
1. [Connect](../../managed-postgresql/operations/connect.md#connection-string) to the `db1` database under the account of the database owner.
1. To only grant access rights to the `Products` table, in the default `public` schema, run the command:

   ```sql
   GRANT SELECT ON public.Products TO user2;
   ```

1. To grant access to all the `myschema` schema tables, run the command:

   ```sql
   GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
   GRANT USAGE ON SCHEMA myschema TO user2;
   ```

To revoke the granted privileges, run the commands:

```sql
REVOKE SELECT ON public.Products FROM user2;

REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
REVOKE USAGE ON SCHEMA myschema FROM user2;
```
