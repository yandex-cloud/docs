# Assigning and changing access permissions

Only a user with `{{ permission-admin }}` access can assign or change access permissions for an object or folder, either directly or by confirming a request. By default, objects inherit the permissions of the parent folder.

Before assigning access permissions to a user, [add](../../security/add-new-user.md) this user to {{ datalens-short-name }}.

## Assigning access permissions for an object {#grant-object}

1. On the [navigation page]({{ link-datalens-main }}/navigation), find the object of interest.

   {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the object and select **Permissions**.
1. In the window that opens, click the button to set up permissions to the respective object: connection, dataset, chart, or dashboard.
1. Enter a username or select the **All** group.


   {% include [datalens-workbooks-collections-access-note](../../../_includes/datalens/operations/datalens-workbooks-collections-access-note.md) %}
   

1. (Optional) Write a comment for the user you are granting permissions to.
1. Specify the appropriate permissions and click **Add**.

## Assign access permissions for linked objects {#grant-linked-objects}

You can assign access to linked objects. For example, if you grant access to a chart, you can also grant access to a dataset and connection. To do this, when [assigning access permissions](#grant-object) for the current object, enable **Linked objects** and grant permissions to other objects linked to it.

Only a user with `{{ permission-admin }}` access to linked objects can assign access permissions for them. If there is no access to administer a linked object, an access request is created. The access request must be [confirmed](#confirm-request) by a user with `{{ permission-admin }}` access to the object.

## Assigning access permissions for a folder {#grant-folder}

1. On the [navigation page]({{ link-datalens-main }}/navigation), find the folder of interest.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the folder and select **Permissions**.
1. Assign access permissions:

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

1. On the [navigation page]({{ link-datalens-main }}/navigation), find the folder or access object of interest.

   {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the object or folder and select **Permissions**.
1. In the window that opens, click **![image](../../../_assets/console-icons/check.svg)** next to the request.
1. (Optional) Select permissions.
1. (Optional) Write a comment for the user requesting access.
1. Click **Confirm request**.

## Updating permissions {#change}

To update folder or object permissions:

1. On the [navigation page]({{ link-datalens-main }}/navigation), find the folder or access object of interest.

   {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the object or folder and select **Permissions**.
1. Select the user with the permission you want to update or choose the **All** group.
1. In the window that opens, specify the appropriate permissions and click **Save**.
