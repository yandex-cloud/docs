## Examples {#examples}

### Creating a read-only user {#user-readonly}

Let's say you need to add a new user named `user2` to an existing cluster, where:

* The user has access to the db1 database of the cluster, including:
   - Access to the `Products` table in the default `public` schema.
   - Access to all tables in the `myschema` schema.
* The access is read-only, so the user isn't allowed to change any settings.

To do this, follow these steps:

1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser) with the name `user2`. Select the databases that the user should have access to.

1. Connect to the db1 database under the account of the database owner.

1. Run the following commands:

    ```postgresql
    GRANT SELECT ON public.Products TO user2;
    
    GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
    GRANT USAGE ON SCHEMA myschema TO user2;
    ```

1. To revoke the granted privileges, run the commands:

    ```postgresql
    REVOKE SELECT ON public.Products FROM user2;
    
    REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
    REVOKE USAGE ON SCHEMA myschema FROM user2;
    ```

