---
title: "How to set up access to a queue"
description: "Follow this guide to set up access to a queue."
---

# Setting up access for a queue

The queue owner can configure access to the queue. The owner can also delegate this right to other users, in the queue settings. By default, all users in the organization have full access to issues in the queue.

Access can be restricted in the queue settings. To open settings:

1. In the left-hand panel, click **Queues** and select a queue from the list.

1. Click **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}** → **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-permissions }}**. If you do not see the **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}** button, it means you have no rights to configure the queue. If you need these rights, contact the queue owner.

The queue access rights setup page will open. Here you can see which rights are active for the queue, but that in the context of the rights of the user viewing this page. For example, if your access to certain issues is restricted, such issues will not be counted.

{% note warning %}

Configure queue access rights cautiously to avoid unintentionally locking yourself out. If this happens, contact the [organization administrators](#implicit-access).

{% endnote %}

## Users that always have access to the queue {#implicit-access}

Some users always have access to the queue, and you cannot restrict their access. These users are:


* [Organization administrators](../role-model.md#admin).
* {{ tracker-name }} robot.



## What accesses are active in the queue {#acces-types}

Queue access is configured using the following rights:

* `Queue settings`: View and edit queue settings. This right does not include access to queue issues and, therefore, does not overlap with other rights.
* `Edit issues`: View all issues in the queue, leave comments, and edit the issue description and any issue fields.
* `Create issues`: Create issues in the queue. When creating a new issue, the user is assigned the Author role, granting them the right to view and edit the issue.
* `View issues`: View queue issues and leave comments.

The set of rights changes depending on the [access rights setup tool](#set-access).

## How to configure queue access {#set-access}

Queue access can be restricted using these four tools:

* [Main queue team members](#main): Use this tool to assign access to specific users, user groups, or robots.
* [Roles in issues](#task-role): This tool complements the first one and allows updating user permissions based on their role in a specific issue: author, assignee, follower, or an individual added to the **Access** field.
* [Issues with a component](#access-component): This tool allows you to completely reconfigure access to the issues in which it is active.
* [Denied access](#prohibit): Deny any access to queue issues to a user or group of users.

These tools can be combined and mixed.

{% note info %}

Changes to queue access rights settings are not applied instantly but synchronized within an hour.

{% endnote %}

### Main queue participants {#main}

Under **Main participants**, you can select users who should have specific accesses in the queue. All four [accesses](#access-types) are active.

To select queue participants:

1. Click **Add** and use search to find a user or user group.

1. Choose the accesses you are ready to grant to a user or user group. If a user already has group rights, you will see which groups they belong to in the same window.

1. Click **Save**.

### Roles in issues {#task-role}

Under **Roles in issues**, you can modify the rights of issue participants. These rights will be granted in addition to those configured under **Main queue participants** section. Two types of [access](#access-types) permissions can be granted to issue participants: `View issues` and `Edit issues`.

To modify accesses for an issue role:

1. Select from the list the role for which to update access.

1. Click **Change access**.

1. In the access editing window, you can select access from the list or revoke extended access for this role. In this case, only the rights from the **Main participants** section will apply for an issue participant with this role.

1. Click **Save**.

### Issues with the component {#access-component}

You can set up access to different [components](components.md) of the queue. This way, you can set different settings for the queue issues without components or issues with components. Access rules for a component prevail over queue-level access rules, but do not override [denied access](#prohibit).

Three types of [access](#access-types) permissions can be granted: `Edit issues`, `Create issues`, and `View issues`. Components do not allow reconfiguring the rights to edit queue settings.

To configure access to a component:

1. Under **Issues with the component**, you will see a list of all queue components. If there are no components in the queue yet, click **Create** and fill out the [component creation form](components.md#create-component).

1. Click the arrow in the line with the component.

1. In the window that opens, you can reconfigure accesses:

* **Deny access**: In the list, select the user, user group, or user role to be denied access.
* **Main participants**: Create a list of users who will get the selected [access](#access-types) to the queue issues with the component.
* **Roles in issues**: Reconfigure accesses available to issue participants.

{% note info %}

If an issue has multiple components, then all the users who have access to at least one of the components have access to the issue.

{% endnote %}

### Denied access {#prohibit}

To deny any access to queue issues, under **Access denied**, click **Add** and use the search to find a user or user group. Click **Deny access**.


