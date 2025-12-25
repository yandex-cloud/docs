#### Can I migrate users from a {{ PG }} source cluster to a {{ mpg-name }} destination cluster? {#user-migration}

No, you cannot automatically migrate users from a third-party {{ PG }} cluster or {{ mpg-name }} cluster to a {{ mpg-name }} cluster. You will need to [re-create the users](../../managed-postgresql/operations/cluster-users.md#adduser) in the target cluster.

#### How to create a role using SQL queries? {#create-role}

You cannot create a role using SQL queries.

In {{ PG }}, a role is a database user or group of users. In {{ mpg-name }}, you can [create a user](../../managed-postgresql/operations/cluster-users.md#adduser) only via the management console, {{ yandex-cloud }} CLI, {{ TF }}, or API. For more information about creating users, see this [{{ PG }} guide](https://www.postgresql.org/docs/current/sql-createuser.html).

You can [assign user privileges](../../managed-postgresql/operations/grant.md), which decide the actions the user can perform with database objects.
