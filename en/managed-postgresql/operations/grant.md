# Granting user permissions and roles

The user created with a {{ mpg-name }} cluster is automatically assigned the `OWNER` role for the first database in the cluster. After that, you can create other users and configure their permissions as you wish.

Atomic permissions in {{ PG }} are called _privileges_ and permission groups are called _roles_. For more information about access permissions, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/user-manag.html).

To grant a **privilege** to a particular user, [create](cluster-users.md) a user via the Yandex.Cloud management console, CLI, or API and run the `GRANT` command on behalf of the DB owner. For example:

```postgresql
GRANT SELECT ON DATABASE db1 TO user2;
```

To assign a user a **role**, use the Yandex.Cloud CLI or API: role assignment from a `GRANT` request is canceled when the next database operation is performed.

## Updating the list of user roles {#grant-role}

To add a role, request the list of available roles with [user information](cluster-users.md), add the desired role to the list, and send the updated list in a request. Similarly, to revoke a role, remove it from the list of roles and send the updated list in a request.

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign roles to a cluster user, pass the list of required roles in the `--grants` parameter. This completely overwrites existing roles: if you want to extend or reduce the available list, first request the current roles with user information by running the `{{ yc-mdb-pg }} user get` command.

  To assign roles, run the command:

  ```
  $ {{ yc-mdb-pg }} user update <username>
       --cluster-name <cluster name>
       --grants="<role1, role2>"
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md) and the username with the [list of users](../operations/cluster-users.md#list-users).

- API

  To pass the list of required user roles, you can use the [update](../api-ref/User/update.md) method.

  This completely overwrites the existing roles: if you want to extend or reduce the available list, first request the current roles with user information via the [get](../api-ref/User/get.md) method.

{% endlist %}

## Example {#example}

### Creating a read-only user {#creating-a-read-only-user}

To create a user who can access data in the database but not change it:

1. [Create a user](cluster-users.md#adduser) in the cluster.

1. On behalf of the DB owner, grant the new user `SELECT` and, if necessary, `USAGE` privileges for the appropriate database or table. For example:

   ```postgresql
   GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
   GRANT USAGE ON SCHEMA myschema TO user2;
   ```

