# Queue access permissions

{% note warning %}

Configure queue access rights cautiously to avoid unintentionally locking yourself out. This can happen, for example, if you configure denied access for a group you belong to or remove access settings that allowed you to manage access. If any of the above happens, contact the [organization administrators](queue-access.md#implicit-access).

{% endnote %}

Access can be restricted in the queue settings. To open settings:

1. In the left-hand panel, click **Queues** and select a queue from the list.

1. Click **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}** → **{{ ui-key.startrek.ui_Queues_pages_page-queue-admin_QueueAdminPageContent.menu-item-permissions }}**. If you do not see the **{{ ui-key.startrek.ui_Queues_pages_PageQueue_header.settings }}** button, it means you have no rights to configure the queue. If you need these rights, contact the queue owner.

Queue access is configured using the following permissions:

* `Queue settings`: View and edit queue settings. This permission does not include access to queue issues and, therefore, does not overlap with other permissions.
* `Edit issues`: View all issues in the queue, leave comments, and edit the issue description and any issue fields.
* `Create issues`: Create issues in the queue. When creating a new issue, the user is assigned the reporter role with permissions to view and edit the issue.
* `View issues`: View queue issues and leave comments.

The set of permissions changes depending on the [permissions setup tool](#set-access).

{% note info %}

If invited to comment on an issue, the user will appear in the **Access** field. After the first comment, the user is automatically added to the **Followers** list.

{% endnote %}

## How to configure queue access {#set-access}

Queue access can be restricted using these four tools:

* [Main queue team members](#main): Use to grant access rights to specific users, user groups, or robots. The final access forms from all sources: if a user has individual permissions and permissions within each group they are a member of, the final access will be based on the maximum access level.
* [Roles in issues](#task-role): Complements the first tool and allows editing user permissions based on their role in a specific issue: reporter, assignee, follower, or individual added to the **Access** field. This works well when a user has no access to the queue, but gains such access as soon as added to the issue.
* [Issues with the component](#access-component): Allows to completely reconfigure access to the issues in which it is active.
* [Denied access](#prohibit): Deny any access to queue issues to a user or group of users.

These tools can be combined and mixed.

{% note info %}

Changes to queue access rights settings are not applied instantly but synchronized within an hour.

{% endnote %}

### Main queue participants {#main}

Under **Main participants**, you can select users who should have specific accesses in the queue. All four accesses are valid. This feature works well when a user has no access to the queue, but gains such access as soon as added to the issue.

To select queue participants:

1. Click **Add** and use search to find a user or user group.

1. Choose the accesses you are ready to grant to a user or user group. If a user already has group rights, you will see which groups they belong to in the same window.

1. Click **Save**.

### Roles in issues {#task-role}

Under **Roles in issues**, you can modify the rights of issue participants. These rights will be granted in addition to those configured under **Main queue participants** section. Two accesses are valid for issue participants: `View issues` and `Edit issues`.

To modify accesses for an issue role:

1. Select from the list the role for which to update access.

1. Click **Change access**.

1. In the access editing window, you can select access from the list or revoke extended access for this role. In this case, only the rights from the **Main participants** section will apply for an issue participant with this role.

1. Click **Save**.

{% note info %}

When granting access with the `Edit issues` permission, you do not need to check the `View issues` permission as `Edit issues` already includes `View issues`.

{% endnote %}

### Issues with the component {#access-component}

You can set up access to different [components](components.md) of the queue. This way, you can set different settings for the queue issues without components or issues with components.

{% note warning %}

Access rules for a component prevail over queue-level access rules, but do not override [denied access](#prohibit).
If permissions are not configured in the component, the **Access** field for that component displays `Does not affect access`.

{% endnote %}

Three accesses are valid: `Edit issues`, `Create issues`, and `View issues`. Components do not allow reconfiguring the rights to edit queue settings.

To configure access to a component:

1. Under **Issues with the component**, you will see a list of all queue components. If there are no components in the queue yet, click **Create** and fill out the [component creation form](components.md#create-component).

1. Click the arrow in the line with the component.

1. In the window that opens, you can reconfigure accesses:

* **Deny access**: In the list, select the user, user group, or user role to be denied access to issues with this component.
* **Main participants**: Create a list of users who will get the selected access to the queue issues with the component.
* **Roles in issues**: Reconfigure accesses available to issue participants.

{% note info %}

Access to a component stands in for accesses to an issue. If an issue relates to multiple components, their permissions are combined, and all the users with access to at least one of the components will have access to the issue.

{% endnote %}

### Denied access {#prohibit}

To deny any access to queue issues, under **Access denied**, click **Add** and use the search to find a user or user group. Click **Deny access**.

Denied access can also be configured for the queue owner.

{% note warning %}

Denied access cannot be overridden by other accesses. That is, if a user is denied access to the queue, and [Roles in issues](#task-role) permit followers to edit the issue, even if we make the user a follower, they will not be able to view the issue. Reconfiguring is only valid for [Main queue participants](#main), [Roles in issues](#task-role), and [Issues with the component](#access-component).

{% endnote %}



## Bulk editing of access permissions in groups

You can use bulk editing in the [Main queue participants](#main), [Roles in issues](#task-role), [Issues with the component](#access-component), and [Access denied](#prohibit) groups. They work differently in each block.

### Main queue participants

1. Check one or more items in the group.

1. Change or revoke [access permissions](#acces-types) in the block that appears below.

   * If you selected **Change access**, configure the relevant issue access permissions in the **Queue access** window that opens.

   * If you selected **Revoke access permissions**, double-check your choice in the **Revoke queue access permissions** window that opens.

1. Click **Save**.

### Roles in issues

1. Check one or more items in the group.

1. In the block that appears below, change access.

1. Click **Change access**.

1. In the **Queue access** window that opens, enable **Extend access**: the user will get extra permissions when given a role in the issue. You will be able to add such permissions as **View issues** and **Edit issues**.

1. Click **Save**.

### Issues with the component

1. Check one or more items in the group.

1. In the block that appears below, click **Grant access to components**.

1. In the **Add participants to components** window, enter the user's full name or email, group name or ID in the search box.

1. Click **Save**.

### Access denied

1. Check one or more items in the group.

1. In the block that appears below, click **Remove restrictions**.
