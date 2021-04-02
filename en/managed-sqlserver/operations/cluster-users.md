# Managing users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- API

  Use the [list](../api-ref/User/list.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Enter a database username and password (from 8 to 128 characters).
  1. Select one or more databases that the user should have access to:
     1. Click **Add database**.
     1. Select the database from the drop-down list.
     1. Repeat the previous two steps until all the required databases are selected.
     1. To delete a database that was added by mistake, click ![image](../../_assets/cross.svg) to the right of the database name.
  1. [Set up user roles](grant.md#grant-role) for each of the selected databases.
  1. Click **Create**.

- API

  Use the [create](../api-ref/User/create.md) API method and pass the following in the request:
  - ID of the cluster where you want to create a user, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Username, in the `userSpec.name` parameter.
  - User password, in the `userSpec.password` parameter.
  - One or more databases that the user must have access to, in one or more `userSpec.permissions.databaseName` parameters.
  - [User roles](grant.md#predefined-db-roles) for each of the selected databases, in one or more `userSpec.permissions.roles` parameters.

{% endlist %}

## Changing a password {#change-password}

{% list tabs %}

- Management console

  To change the user's password:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![options](../../_assets/horizontal-ellipsis.svg) and select **Change password**.
  1. Set a new password and click **Edit**.

- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the user is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Username, in the `userName` parameter. To find out the username, [get a list of users in the cluster](#list-users).
  - New user password, in the `password` parameter.
  - List of user configuration fields to be changed (in this case, the `password`), in the `updateMask` parameter.

  {% note warning %}

  This API method resets any settings that aren't passed explicitly in the request to their defaults.
  To avoid this, be sure to pass the name of the user password field: `password`, in the `updateMask` parameter.

  {% endnote %}

{% endlist %}

## Changing user settings {#update-settings}

{% list tabs %}

- Management console

  To change the user settings:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.
  1. Set up user permissions to access certain databases:
     1. To grant access to the required databases:
        1. Click **Add database**.
        1. Select the database from the drop-down list.
        1. Repeat the previous two steps until all the required databases are selected.
     1. To revoke access to a specific database, remove it from the list by clicking ![image](../../_assets/cross.svg) to the right of the database name.
  1. Set up user roles for each of the selected databases.
  1. Click **Save**.

- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the user is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Username, in the `userName` parameter. To find out the username, [get a list of users in the cluster](#list-users).
  - New values for user settings.
  - List of user configuration fields to be changed, in the `updateMask` parameter.

  {% note warning %}

  This API method resets any settings that aren't passed explicitly in the request to their defaults.
  To avoid this, in the `updateMask` parameter, list the settings you want to change (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
  1. Confirm user deletion.

- API

  Use the [delete](../api-ref/User/delete.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the user is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Username, in the `userName` parameter. To find out the username, [get a list of users in the cluster](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mms-user-examples.md) %}

