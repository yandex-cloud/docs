# Managing database users

You can add and remove users, as well as manage their individual settings.

{% note warning %}

You can use SQL commands to assign privileges to users, but you can't use them to add or change users. For more information, see [{#T}](grant.md).

{% endnote %}

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
       --cluster-name <cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter a database username and password (from 8 to 128 characters).
  1. Select one or more databases that the user should have access to:
     1. Select the database from the **Database** drop-down list.
     1. Click **Add** to the right of the drop-down list.
     1. Repeat the previous two steps until all the required databases are selected.
     1. To delete a database that was added by mistake, click ![image](../../_assets/cross.svg) to the right of the database name in the **Permissions** list.
  1. Configure the [DBMS settings](../concepts/settings-list.md#dbms-user-settings) for the user.
  1. Click **Add**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```
  $ {{ yc-mdb-pg }} user create <username>
       --cluster-name <cluster name>
       --password=<user password>
       --permissions=<list of DBs the user can access>
       --conn-limit=<maximum number of connections per user>
  ```

  This command configures only the main user settings.

  To customize the DBMS for the user, use the parameters described in [User settings](../concepts/settings-list.md#dbms-user-settings).

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

{% note info %}

When created, the user only gets the `CONNECT` privilege for the selected databases and can't perform any operations with the databases. To provide the user with access to the database, [grant](grant.md) them the required privileges or roles.

{% endnote %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console

  To change the user's password:
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.
  1. Set a new password and click **Edit**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user's password, run the command:

  ```
  $ {{ yc-mdb-pg }} user update <username>
       --cluster-name=<cluster name>
       --password=<new password>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Changing user settings {#update-settings}

{% note info %}

The privileges and roles in {{ PG }} are not affected by these settings and are configured separately.

For information on setting up user privileges and roles, see [{#T}](grant.md).

{% endnote %}

{% list tabs %}

- Management console

  To change the user settings:
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Settings**.
  1. Set up user permissions to access certain databases:
     1. To grant access to the required databases:
        1. Select the database from the **Database** drop-down list.
        1. Click **Add** to the right of the drop-down list.
        1. Repeat the previous two steps until all the required databases are selected.
     1. To revoke access to a specific database, remove it from the **Permissions** list by clicking ![image](../../_assets/cross.svg) to the right of the database name.
  1. Change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user in **DBMS settings**.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can change the user settings from the command line interface:

  1. To set up the user's permissions to access certain databases, run the command, listing the database names in the `--permissions` parameter:

     ```
     $ {{ yc-mdb-pg }} user update <username>
          --cluster-name=<cluster name>
          --permissions=<list of DBs the user can access>
     ```

     The cluster name can be requested with a [list of folder clusters](#list-clusters).

     This command grants the user the permission to access the databases listed.

     To revoke access to a specific database, remove its name from the list and pass the updated list to the command.

  1. To change the [{{ PG }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, pass their parameters in the command:

     ```
     $ {{ yc-mdb-pg }} user update <username>
          --cluster-name=<cluster name>
          --<setting 1>=<value 1>
          --<setting 2>=<value 2>
          --<setting 3>=<list of values>
          ...
     ```

     The cluster name can be requested with a [list of folder clusters](#list-clusters).

{% endlist %}

## Deleting a user {#removeuser}

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
       --cluster-name <cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}

