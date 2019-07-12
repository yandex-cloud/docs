# How to manage database users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **Managed Service for MySQL**.
  1. Click on the name of the cluster you need and then select the **Users** tab.
  
{% endlist %}

## Adding users {#adduser}

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **Managed Service for MySQL**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter the database user name and password (from 8 to 128 characters).
  
{% endlist %}

## Updating users {#updateuser}

For the user, you can change:

- Name and password.
- List of databases the user can access.
- Limitation on the number of DB connections.

{% list tabs %}

- Management console
  
  In the management console, you can only change the password of a database user:
  
  1. Go to the folder page and click **Managed Service for MySQL**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.
  
{% endlist %}

## Removing a user {#removeuser}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **Managed Service for MySQL**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.
  
{% endlist %}

