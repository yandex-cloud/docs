---
title: Users and permissions
description: This page presents FAQ about users and access permissions management.
---

# Users and access management


### Does {{ datalens-short-name }} support login via SSO? {#sso-in-datalens}

In {{ datalens-full-name }}, you can [configure authentication](../security/add-new-user.md#federated-user) using SSO or [identity federation](../../organization/concepts/add-federation.md), if you have one. {{ datalens-short-name }} users can get authenticated using their corporate accounts.


### How do I add a user and send them a link to the dashboard? {#how-add-user-send-ref}

To allow another user to open your dashboard, configure access to {{ datalens-full-name }}:

1. [Invite a user](../../organization/operations/add-account.md#send-invitation) with a Yandex account or add a [federated](../../organization/operations/add-account.md#add-user-sso) or [local](../../organization/operations/add-account.md#local) user.
1. Make sure the user has access permissions for the dashboard:

   1. Open the dashboard.
   1. In the **Add member** field, enter **All** or the name of the user who needs extended permissions.
   1. Go to the **Current object** section and set the permissions for the dashboard:

      * View: Viewing only.
      * Edit: Viewing and editing.
      * Administration: Viewing, editing, and management.

   1. Enable the **Linked objects** option to grant permissions for other objects linked to the dashboard, i.e., the connection, datasets, and charts.

The user will get access to your {{ datalens-short-name }} instance and objects with **All** permissions. You can assign this user individual permissions for objects.

You can send the link to the dashboard from the browser. For more information about permissions for {{ datalens-short-name }} objects, see [this guide](../security/index.md#permissions).

You can also make your dashboard public using [{#T}](../concepts/datalens-public.md).

{% include [permission-error](../../_qa/datalens/permission-error.md) %}

{% include [copy-into-folder](../../_qa/datalens/copy-into-folder.md) %}

{% include [revoke-token.md](../../_qa/datalens/revoke-token.md) %}



