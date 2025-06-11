---
title: Users and permissions
description: This page presents FAQ about users and access permissions management.
---

# Users and access management


### Does {{ datalens-short-name }} support login via SSO? {#sso-in-datalens}

In {{ datalens-full-name }}, you can [configure authentication](../security/add-new-user.md#federated-user) using SSO or [identity federation](../../organization/concepts/add-federation.md), if you have one. {{ datalens-short-name }} users can get authenticated using their corporate accounts.

Starting January, 2025, SSO authentication in {{ datalens-full-name }} will be available only for the Business [service plan](../../datalens/pricing.md#service-plans).


To avoid authentication issues, Community users that use SSO have until January 29, 2025 to decide whether
* to switch to Business and continue using SSO
* or switch to authentication with a [Yandex account](../../iam/concepts/users/accounts.md#passport) that you need to add to your [organization](../concepts/organizations.md). You can finalize this in [{{ datalens-short-name }}](../security/add-new-user.md#dl-user) or in [{{ org-full-name }}](../security/add-new-user.md#passport-user).

### How do I add a user and send them a link to the dashboard? {#how-add-user-send-ref}

To allow another user to open your dashboard, configure access to {{ datalens-full-name }}:

1. [Invite a user](../../organization/operations/add-account.md#send-invitation) with a Yandex account or [add a federated user](../../organization/operations/add-account.md#add-user-sso).
1. Make sure the user has access permissions to the dashboard:

   1. Open the dashboard.
   1. In the **Add member** field, enter _All_ or the name of the user who needs extended permissions.
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


