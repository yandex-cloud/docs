# Permissions


### How do I add a user and send them a link to the dashboard? {#how-add-user-send-ref}

To allow another user to open your dashboard, configure access to {{ datalens-full-name }}:

1. [Invite a user](../../organization/operations/add-account.md#send-invitation) with a Yandex account or [add a federated user](../../organization/operations/add-account.md#add-user-sso).
1. Make sure that the user has access to the dashboard:

   1. Open the dashboard.
   1. In the **Add member** field, enter "All" or the name of the user who needs extended permissions.
   1. Go to the **Current object** section and set the permissions for the dashboard:

      * View: Read only is available.
      * Edit: View and edit options are available.
      * Administration: View, edit, and manage options are available.

   1. Enable the **Linked objects** option to grant permissions to other dashboard-related objects, such as connections, dashboards, and charts.

The user is granted access to your {{ datalens-short-name }} and objects with **All** permissions. You can assign this user individual permissions to objects.

You can send the link to the dashboard from the browser. For more information about permissions to {{ datalens-short-name }} objects, see the [documentation](../security/index.md#permissions).

You can also make your dashboard public using [{#T}](../concepts/datalens-public.md).

{% include [permission-error](../../_qa/datalens/permission-error.md) %}

{% include [copy-into-folder](../../_qa/datalens/copy-into-folder.md) %}

{% include [revoke-token.md](../../_qa/datalens/revoke-token.md) %}


