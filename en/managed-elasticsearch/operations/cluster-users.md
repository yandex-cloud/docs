# Managing {{ ES }} users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster you need and then select the **Users** tab.

- API

  To get a list of users, use the [list](../api-ref/User/list.md) method.

{% endlist %}

## Adding a user {#adduser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click **Add**.
  1. Set the username and password (from 8 to 128 characters).
  1. Click **Add**.

{% endlist %}

## Changing a password {#updateuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Change password**.
  1. Set a new password, enter it again in the **Confirm password** field and click **Change**.

{% endlist %}

## Deleting a user {#removeuser}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster you need and select the tab **Users**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.

{% endlist %}

