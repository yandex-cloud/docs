# Granting permissions

Only a user with `{{ permission-admin }}` access privileges can assign access rights to an object or folder: they can do so directly or by confirming a request. By default, objects inherit the access rights of the parent folder.

Before granting a user access permissions, [add](../../security/index.md#add-new-user) the user to the respective organization or cloud.

## Granting object permissions {#grant-object}

1. On the navigation page, find the relevant access object.

   {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

1. Click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) next to the object and select **Permissions**.
1. In the window that opens, click **<Object> access**, where `<Object>` is a connection, dataset, chart, or dashboard.
1. Enter a username or select the **All** group. If necessary, write a comment for the user you're requesting access from. Specify the appropriate permissions and click **Add**.

   {% include [multi-access-note](../../../_includes/datalens/datalens-multi-access-note.md) %}

## Granting folder permissions {#grant-folder}

1. On the navigation page, find the relevant folder.
1. Click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) next to the folder and select **Permissions**.
1. Grant access to:

   {% list tabs %}

   - Folder

     1. In the window that opens, click **Folder access**.
     1. Enter a username or select the **All** group. If necessary, write a comment for the user you're granting permissions to. Specify the appropriate permissions and click **Add**.

        The selected user or group is granted the specified access permissions to the current folder only.

   - Folder and content

     1. In the window that opens, click **Folder and content access**.
     1. Enter a username or select the **All** group. If necessary, write a comment for the user you're granting permissions to. Specify the appropriate permissions and click **Apply**.

        The selected user or group is granted the specified access permissions to the current folder and all nested objects, including connections, datasets, and other folders and files.

        {% include [folder-access-note](../../../_includes/datalens/datalens-folder-access-note.md) %}

   {% endlist %}

## Confirm request{#confirm-request}

To confirm a [request](request.md) for access permission to a folder or object:

1. On the navigation page, find the relevant directory or access object.

   {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

1. Click the ![image](../../../_assets/datalens/horizontal-ellipsis.svg) by the object or directory and select **Permissions**.
1. In the resulting window next to the desired request, click **![image](../../../_assets/datalens/check.svg)**.
1. If necessary, write a comment for the user requesting access.
1. Click **Confirm request**.
