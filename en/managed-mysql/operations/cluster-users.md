# Managing database users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the command:

  ```
  $ {{ yc-mdb-my }} user list
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Add a user {#adduser}

{% note info %}

Assign roles to users via the management console or API. Roles assigned by the `GRANT` database command will be reset on making changes via the management console or API.

{% endnote %}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter the database username and password (from 8 to 128 characters).
  1. Select the database to grant the user access to.
  1. Select the user role and click **Add** under the list of roles. Repeat the action for all the roles that the user needs.
  1. Click **Add** in the new user window.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```
  $ {{ yc-mdb-my }} user create <username>
       --cluster-name=<cluster name>
       --password=<user password>
       --permissions=<list of DBs the user will get access to>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Changing users {#updateuser}

For the user, you can change:

- Their name and password.
- The list of databases the user can access.
- Limitation on the number of DB connections.

{% list tabs %}

- Management console

  In the management console, you can only change the password of a database user:
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user's password or the list of databases available to the user, run:

  ```
  $ {{ yc-mdb-my }} user update <username>
       --cluster-name=<cluster name>
       --password=<user password>
       --permissions=<list of DBs the user can access>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Deleting users {#removeuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  $ {{ yc-mdb-my }} user delete <username>
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

