# Managing database users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the command:

  ```
  $ {{ yc-mdb-mg }} user list
       --cluster-name <cluster name>
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  To get a list of users, use the [list](../api-ref/User/list.md) method.

{% endlist %}

## Add a user {#adduser}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click on the name of the cluster you need and select the tab **Users**.

  1. Click **Add**.

  1. Enter the database username and password (from 8 to 128 characters).

  1. Configure the [roles](../concepts/users-and-roles.md) for the user:
     1. Select the database where you want to grant a role.
     1. Select the role and click **Add** under the list of roles.

     You can grant multiple roles to a user in different databases.

  1. Click **Add**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster:

  1. See the description of the CLI's create user command:

     ```
     $ {{ yc-mdb-mg }} user create --help
     ```

  1. Specify the user properties in the create command:

     ```
     $ {{ yc-mdb-mg }} user create <username>
        --cluster-name <cluster name>
        --password <user password>
        --permission database=<DB name>,role=<role>,role=<another role>,...
        --permission database=<another DB name>,role=<role>,...
     ```

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  You can add users using the [create](../api-ref/User/create.md) method.

{% endlist %}

## Changing users {#updateuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. To change the user's password, click ![image](../../_assets/options.svg) and select **Change password**.
  1. To change the user's [roles](../concepts/users-and-roles.md):
     1. Click ![image](../../_assets/options.svg), and select **Configure**.
     1. To add a role, select the database and role, then click **Add** under the list of roles.
     1. To delete a role, click ![image](../../_assets/cross.svg) next to the role.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a user's password or list of roles:

  1. See the description of the CLI's update user command:

     ```
     $ {{ yc-mdb-mg }} user update --help
     ```

  1. Specify the user properties in the create command:

     ```
     $ {{ yc-mdb-mg }} user update <username>
        --cluster-name <cluster name>
        --password <user password>
        --permission database=<DB name>,role=<role>,role=<another role>,...
        --permission database=<another DB name>,role=<role>,...
     ```

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  To edit the user's data, use the [update](../api-ref/User/update.md) method.

{% endlist %}

## Deleting users {#removeuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/options.svg), and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  $ {{ yc-mdb-mg }} user delete <username>
       --cluster-name <cluster name>
  ```

  You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  You can delete a user using the [delete](../api-ref/User/delete.md) method.

{% endlist %}

