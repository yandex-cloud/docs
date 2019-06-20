# How to manage database users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To get a list of cluster users, run the command:
  
  ```
  $ {{ yc-mdb-mg }} user list
       --cluster-name <cluster name>
  ```
  
  The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).
  
{% endlist %}

## Adding users {#adduser}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter the database user name and password (from 8 to 128 characters).
  
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
     $ {{ yc-mdb-mg }} user create <user name>
        --cluster-name <cluster name>
        --password <user password>
        --permission database=<DB name>,role=<role>,role=<another role>,...
        --permission database=<another DB name>,role=<role>,...
     ```
  
     The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).
  
{% endlist %}

## Updating users {#updateuser}

{% list tabs %}

- Management console
  
  In the management console, you can only change the password of a database user:
  
  1. Go to the folder page and click **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To change the user's password or the list of databases available to the user:
  
  1. See the description of the CLI's update user command:
  
     ```
     $ {{ yc-mdb-mg }} user update --help
     ```
  
  1. Specify the user properties in the create command:
  
     ```
     $ {{ yc-mdb-mg }} user update <user name>
        --cluster-name <cluster name>
        --password <user password>
        --permission database=<DB name>,role=<role>,role=<another role>,...
        --permission database=<another DB name>,role=<role>,...
     ```
  
     The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).
  
{% endlist %}

## Removing a user {#removeuser}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To remove a user, run:
  
  ```
  $ {{ yc-mdb-mg }} user delete <user name>
       --cluster-name <cluster name>
  ```
  
  The cluster name can be requested with a [list of folder clusters](cluster-list.md#list-clusters).
  
{% endlist %}

