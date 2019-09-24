# Managing database users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster users, run the command:

  ```
  $ yc managed-clickhouse user list
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of folder clusters](#list-clusters).

{% endlist %}

## Add a user {#adduser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter the database username and password (from 8 to 128 characters).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user in a cluster, run the command:

  ```
  $ yc managed-clickhouse user create <username>
       --cluster-name=<cluster name>
       --password=<DB user password>
       --permissions=<list of DBs the user can access>
  ```

  The cluster name can be requested with a [list of folder clusters](#list-clusters).

{% endlist %}

## Changing users {#updateuser}

{% list tabs %}

- Management console

  In the management console, you can only change the password of a database user:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user's password or the list of databases available to the user, run:

  ```
  $ yc managed-clickhouse user update <username>
       --cluster-name=<cluster name>
       --password=<DB user password>
       --permissions=<list of DBs the user can access>
  ```

  The cluster name can be requested with a [list of folder clusters](#list-clusters).

{% endlist %}

## Deleting users {#removeuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a user, run:

  ```
  $ yc managed-clickhouse user delete <username>
       --cluster-name=<cluster name>
  ```

  The cluster name can be requested with a [list of folder clusters](#list-clusters).

{% endlist %}

