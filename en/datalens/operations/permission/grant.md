# Granting and updating permissions

Only a user with `{{ permission-admin }}` access privileges can grant or update permissions for an object or folder: they can do so directly or by confirming a request. By default, objects inherit the permissions of the parent folder.

Before granting permissions to a user, [add](../../security/add-new-user.md) them to {{ datalens-short-name }}.

## Granting object permissions {#grant-object}

1. On the [navigation page]({{ link-datalens-main }}/navigation), find the access object.

   {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the object and select **Permissions**.
1. In the window that opens, click the button to set up permissions to the respective object: connection, dataset, chart, or dashboard.
1. Enter a username or select the **All** group.
1. (Optional) Write a comment for the user you are granting permissions to.
1. Specify the appropriate permissions and click **Add**.

   {% include [multi-access-note](../../../_includes/datalens/datalens-multi-access-note.md) %}

## Granting folder permissions {#grant-folder}

1. On the [navigation page]({{ link-datalens-main }}/navigation), find the folder.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the folder and select **Permissions**.
1. Grant access to:

   {% list tabs %}

   - Folder

      1. In the window that opens, click **Folder access**.
      1. Enter a username or select the **All** group.
      1. (Optional) Write a comment for the user you are granting permissions to.
      1. Specify the appropriate permissions and click **Add**.

         The selected user or group is granted the specified access permissions to the current folder only.

   - Folder and content

      1. In the window that opens, click **Folder and content access**.
      1. Enter a username or select the **All** group.
      1. (Optional) Write a comment for the user you are granting permissions to.
      1. Specify the appropriate permissions and click **Apply**.

         The selected user or group is granted the specified access permissions to the current folder and all nested objects, including connections, datasets, and other folders and files.

         {% include [folder-access-note](../../../_includes/datalens/datalens-folder-access-note.md) %}

   {% endlist %}

## Confirm request {#confirm-request}

To confirm a [request](request.md) for access permission to a folder or object:

1. On the [navigation page]({{ link-datalens-main }}/navigation), find the folder or access object.

   {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the object or folder and select **Permissions**.
1. In the window that opens, click **![image](../../../_assets/console-icons/check.svg)** next to the request you need.
1. (Optional) Select permissions.
1. (Optional) Write a comment for the user requesting access.
1. Click **Confirm request**.

## Updating permissions {#change}

To update folder or object permissions:

1. On the [navigation page]({{ link-datalens-main }}/navigation), find the folder or access object.

   {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the object or folder and select **Permissions**.
1. Select the user with the permission you want to update or choose the **All** group.
1. In the window that opens, specify the appropriate permissions and click **Save**.