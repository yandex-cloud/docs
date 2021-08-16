# Managing {{ MY }} users

You can add and remove users, as well as manage their individual settings.

{% note warning %}

You can use SQL commands to assign privileges to users, but you can't use them to add or change users. For more information, see [{#T}](grant.md).

{% endnote %}

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

## Adding a user {#adduser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter a database username and password (from 8 to 128 characters).
  1. Select one or more databases that the user should have access to:
      1. Click **Add database**.
      1. Select the database from the drop-down list.
      1. Repeat the previous two steps until all the required databases are selected.
      1. To delete a database added by mistake, hover over the row with the database name and click ![image](../../_assets/cross.svg) at the end of the line.
  1. Set up [user roles](grant.md#db-roles) for each of the selected databases:
      1. Click ![image](../../_assets/plus-sign.svg) in the **Roles** column.
      1. Select the role you want to add to the user from the drop-down list.
      1. Repeat the previous two steps until all the required roles are added.
  1. To revoke a role granted by mistake, click ![image](../../_assets/cross.svg) to the right of its name.
  1. If necessary, configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for the user.
  1. Click **Add**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```
  $ {{ yc-mdb-my }} user create <username>
       --cluster-name=<cluster name>
       --password=<user password>
       --permissions=<list of DBs the user can access>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Change password**.
  1. Set a new password and click **Edit**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user's password, run the command:

  ```
  $ {{ yc-mdb-my }} user update <username>
       --cluster-name=<cluster name>
       --password=<new password>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Changing user settings {#update-settings}

To change a list of databases available to the user and the database access level, follow the [instructions on changing a list of roles](grant.md#grant-role).

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.
  1. Configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for the user.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To configure the [{{ MY }} settings](../concepts/settings-list.md#dbms-user-settings) for the user, run the command:

  ```
  $ {{ yc-mdb-my }} user update <username>
       --cluster-name=<cluster name>
       --global-permissions=<comma-separated list of global privileges>
       --authentication-plugin=<authentication plugin>
       --max-questions-per-hour=<maximum number of requests per hour>
       --max-updates-per-hour=<maximum number of UPDATE requests per hour>
       --max-connections-per-hour=<maximum number of connections per hour>
       --max-user-connections=<maximum number of simultaneous connections>
  ```

  The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.

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

{% include [user-ro](../../_includes/mdb/mmy-user-examples.md) %}

