# Setting access rights for queues

{% note warning %}

By default, only the queue owner can configure a queue.

{% endnote %}

## Setting access rights for queues {#set-access}

By default, users are not restricted from accessing queue issues

If you restrict access to your queue, only the users specified in the following fields will have access to its issues by default: **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--author }}**, **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--assignee }}**, **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--followers }}**, and **Access**.


{% note warning %}

To create and edit issues, the user needs [full access](../access.md) to {{ tracker-name }} (except for accessing the queue). For more information, see [{#T}](../role-model.md).

{% endnote %}


You can change access settings for specific users, groups, or roles:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--permissions }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.tab--queue }}** tab.

1. Add users and groups to configure access for:
   * **{{ ui-key.startrek.blocks-desktop_roles-table.users }}**: Individual settings for individual users. To add a user to this category, enter their login or name in the search bar located at the top of the table.
   * **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.permissions-group--groups }}**: Settings applying to all employees.


   * **{{ ui-key.startrek.blocks-desktop_roles-table.roles }}**: Settings for users who have specific roles in queue issues:
      * **{{ ui-key.startrek-backend.roles.role.name.access }}**: Users listed in the **{{ ui-key.startrek-backend.fields.issue.access }}** field of an issue.
      * **{{ ui-key.startrek-backend.roles.role.name.follower-key-value }}**: Users subscribed to the issue.
      * **{{ ui-key.startrek-backend.roles.role.name.author }}**: The person who created the issue.
      * **{{ ui-key.startrek-backend.roles.role.name.assignee }}**: The person assigned to the issue.
      * **{{ ui-key.startrek-backend.roles.role.name.queue-lead }}**.
      * **{{ ui-key.startrek-backend.roles.role.name.team-member }}**: Users added to the [queue team](queue-team.md). This role is not on the list by default: you can add it using the search bar at the top of the table.

1. Set permissions for queue actions:
   * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--create }}**: Users allowed to create new issues in this queue.
   * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--read }}**: Users allowed to add comments to an issue and change its status, but not to edit issue field values.

      {% note info %}

      To [bulk change multiple issues' statuses](bulk-change.md#change-status), view permissions are not sufficient. This requires permission to edit issues.

      {% endnote %}

   * **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--write }}**: Users allowed to add comments to an issue, change its status, and edit issue fields (change its deadline, add followers, etc.).
   * **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**: Users allowed to edit [queue settings](edit-queue-general.md).

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.save }}**.

If the user is assigned multiple roles, they can perform all the actions allowed by the settings of these roles.

> **Example**
>
> ![](../../_assets/tracker/access-roles.png)
>
> If a user is both the reporter and the assignee, they are allowed to **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--create }}**, **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--read }}**, and **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.column-title--write }}**.

## Adding a message for users who can't access issues {#deny-message}

When a user is trying to open an issue from a queue that they don't have access to, a message saying <q>Contact the queue owner</q> pops out with the owner's name specified.

This message can be changed. For example, you can specify another user with administrative rights for the queue so that other users can request access from them. You can also explain here what was the reason for closing access to the queue.

To change the message shown to the users who do not have access to the queue:

1. Open the [queue page](../user/queue.md).

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--permissions }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.tab--queue }}** tab.

1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.access-denied-msg }}**, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.update-access-denied-msg-btn }}**.

1. Write your message and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.save }}**.


## Setting access rights to issues with components {#access-components}

You can set up access to different [components](components.md) of the queue. This way, you can set different settings for the queue's issues without components or issues with components.

{% note warning %}

Rights of access to a component prevail over the rights of access to the queue.

{% endnote %}

To configure access to component issues:

1. Open the [queue page](../user/queue.md).

1. [Add components to your queue](components.md#create-component) so that you can differentiate access to issues.

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--permissions }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.tab--components }}** tab.

1. Add users and groups to configure access for:
   * **{{ ui-key.startrek.blocks-desktop_roles-table.users }}**: Individual settings for individual users. To add a user to this category, enter their login or name in the search bar located at the top of the table.

   * **{{ ui-key.startrek.blocks-desktop_issues-filter-update-modal.permissions-group--groups }}**: Settings applying to all employees.


   * **{{ ui-key.startrek.blocks-desktop_roles-table.roles }}**: Settings for users who have specific roles in queue issues:
      * **{{ ui-key.startrek-backend.roles.role.name.access }}**: Users listed in the **{{ ui-key.startrek-backend.fields.issue.access }}** field of an issue.
      * **{{ ui-key.startrek-backend.roles.role.name.follower-key-value }}**: Users subscribed to the issue.
      * **{{ ui-key.startrek-backend.roles.role.name.author }}**: The person who created the issue.
      * **{{ ui-key.startrek-backend.roles.role.name.assignee }}**: The person assigned to the issue.
      * **{{ ui-key.startrek-backend.roles.role.name.queue-lead }}**.
      * **{{ ui-key.startrek-backend.roles.role.name.team-member }}**: Users added to the [queue team](queue-team.md). This role is not on the list by default: you can add it using the search bar at the top of the table.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.save }}**.

   {% note tip %}

   To disable special access rights for a component, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_permissions.reset }}**.

   {% endnote %}

1. To add access for a specific issue that is different from the settings of the entire queue, add a component to the issue.

If an issue has multiple components, then all the users who have access to at least one of the components have access to the issue.

> **Example**
>
> ![](../../_assets/tracker/access-components.png)
>
> If an issue has the **Hardware** and **Software** components, it can be accessed by users from both the <q>Product development</q> and <q>Application development</q> groups.

