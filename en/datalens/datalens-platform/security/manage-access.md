---
title: Managing access permissions in {{ datalens-platform-full-name }}
description: Follow this guide to configure access permissions for {{ datalens-platform-short-name }} and its objects as well as handle access requests.
---

# Managing access permissions

Access to {{ datalens-platform-short-name }}, data, and individual objects is managed using [roles](roles.md). We recommend assigning all roles in the {{ datalens-platform-short-name }} UI.

## Configuring service access permissions {#service-access}

You can configure service access permissions on the **Service settings** page.

To grant service access to a user:

1. Open the ![image](../../../_assets/console-icons/sliders.svg) **Service settings** page and navigate to the **Access permissions** tab.

   The tab lists users, user groups, and service accounts with assigned roles. Use search by name or email to find the entry you need.

1. Click ![image](../../../_assets/console-icons/person-plus.svg) **Grant access**.
1. In the window that opens:

   * In the **Assignee** field, click ![image](../../../_assets/console-icons/person-plus.svg) **Add** and select users, user groups, or service accounts.
   * In the **Roles** field, click **+ Add role** and select one or multiple roles: [for service access](roles.md#service-roles) and [for data access](roles.md#data-roles).

1. Click **Grant**.

## Configuring access permissions for an object {#set-access}

Only the administrator of an object, e.g., a collection, workbook, or REST catalog, can configure access permissions for it. To configure access permissions for an object 

1. Open the object you want to configure access permissions for.
1. In the top-right corner, click ![image](../../../_assets/console-icons/persons-lock.svg) **Access permissions**.

   This will open the **Access permissions** window. On the **For an object** tab, you will see a list of those who have access to the object: users, user groups, service accounts, and users invited to the organization. Next to each item, you will see assigned roles, including inherited ones. To hide inherited roles, enable the **Hide inherited** setting.

1. Click ![image](../../../_assets/console-icons/person-plus.svg) **Add**.
1. In the **Adding users** window:

   * In the **Roles** section, click **+ Add role** and select one or multiple [roles for accessing objects](roles.md#object-roles).
   * In the **Assignee section**, select an organization user or enter an email of a new user for them to get an invitation.

1. Click **Add**.

## Handling access requests {#access-requests}

Users can request access to {{ datalens-platform-short-name }} objects. A user that manages object access permissions can handle such a request, i.e., approve or reject it.

To handle access requests:

1. In the left-hand panel, click ![image](../../../_assets/console-icons/lock-open.svg) **Access requests**.

   The page shows a list of requests with the following information: who requested access, what role is requested, to which object, as well as request date and status. A request can have one of these statuses:

   * **Pending**: Request is pending.
   * **Approved**: Access is granted.
   * **Rejected**: Access is denied.
   * **Cancelled**: Request is cancelled by the sender.

1. Find the request you need. To filter the list, use search by name, email, or object; **Status filer**, or **I am author** and **For approval** filters.
1. Click ![image](../../../_assets/console-icons/thumbs-up.svg) to approve the request or ![image](../../../_assets/console-icons/thumbs-down.svg) to reject it.

Requests for access to a specific object can be handled in the access permission settings of that object:

1. Open the object.
1. In the top-right corner, click ![image](../../../_assets/console-icons/persons-lock.svg) **Access permissions**.
1. Go to the **Access requests** tab. It shows access requests for this object.

#### Useful links {#see-also}

* [{#T}](index.md)
* [{#T}](roles.md)
