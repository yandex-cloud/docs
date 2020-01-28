# Managing database users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the command:

  ```
  $ {{ yc-mdb-pg }} user list
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Add a user {#adduser}

Once created, the user only gets the `CONNECT` privilege and can't perform any database operations. To give the user access to the database, [grant](grant.md) them the required privileges or roles.

{% note info %}

The user assigned as database owner when creating the DB gets the `OWNER` privilege. It lets them make changes to the DB.

{% endnote %}

When adding a user, {{ mpg-short-name }} reserves 50 connections to the {{ PG }} cluster (the `connlimit` parameter) by default. The minimum number of connections per user is 10.

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter the database username and password (from 8 to 128 characters).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```
  $ {{ yc-mdb-pg }} user create <username>
       --cluster-name=<cluster name>
       --password=<DB user password>
       --permissions=<list of DBs the user can access>
       --conn-limit=<maximum number of connections per user>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Changing users {#updateuser}

For the user, you can change:

- Their name and password.
- The list of databases the user can access.
- The limit on the number of database connections and other settings specific to {{ PG }}.

For information setting up user privileges and roles, see [{#T}](grant.md).

{% list tabs %}

- Management console

  In the management console, you can only change the password of a database user:
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user's password or the list of databases available to the user, run:

  ```
  $ {{ yc-mdb-pg }} user update <username>
       --cluster-name=<cluster name>
       --password=<DB user password>
       --permissions=<list of DBs the user can access>
       --conn-limit=<maximum number of connections per user>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Deleting users {#removeuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  $ {{ yc-mdb-pg }} user delete <username>
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

