# Setting up access rights for queues

{% note warning %}

By default, only the queue owner can configure a queue.

{% endnote %}

## Setting access rights for queues {#set-access}

By default, users are not restricted from accessing queue issues.

If you restrict access to your queue, only the users specified in the following fields will have access to its issues by default: **Author**, **Assignee**, **Followers**, and **Access**.



{% note warning %}

To create and edit issues, you need [full access](../access.md) to {{ tracker-name }} along with queue access. For more information, see [{#T}](../role-model.md).

{% endnote %}


You can change access settings for individual users, groups, or roles:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to **Access** → **All issues**.

1. Add users and groups to configure access for:
    - **Users and robots**: Individual settings for individual users. To add a user to this category, enter the login or the user's name in the search bar at the top of the table.
    - **Groups**: Settings for all employees.



    - **Roles**: Settings for users who have specific roles in queue issues:
        - **Access**: Users listed in the **Access** field of an issue.
        - **Follower**: Users who subscribed to the issue.
        - **Reporter**: The person who created the issue.
        - **Assignee**: The person assigned to the issue.
        - **Queue owner**.
        - **Queue team members**: Users added to the [queue team](queue-team.md). This role isn't on the list by default, but you can add it via the search bar at the top of the table.

1. Set permissions for queue actions:

    - **Create issues**: Users are allowed to create new issues in this queue.

    - **View issues**: Users are allowed to add comments to an issue and change its status, but not to edit issue field values.

        {% note info %}

        To [bulk change multiple issues' statuses](bulk-change.md#section_kkf_tjr_fgb), view permissions are not sufficient. This requires permission to edit issues.

        {% endnote %}

    - **Edit issues**: Users are allowed to comment on an issue, change its status, and edit issue fields (such as changing its deadline, adding followers, and so on).

    - **Queue settings**: Users are allowed to edit [queue settings](edit-queue-general.md).

1. Click **Save**.

If a user has multiple roles, they gain all access rights associated with each role.

> **Example**
>
>![](../../_assets/tracker/access-roles.png)
>
>If a user is both the reporter and assignee, they are allowed to **Create issues**, **View issues**, and **Edit issues**.

## Adding a message for users who can't access issues {#deny-message}

When a user is trying to open an issue from a queue that they don't have access to, a message saying <q>Contact the queue owner</q> pops out with the owner's name specified.

This message can be changed. For instance, you can specify another user with queue admin rights who can give access to issues. You can also specify the reason for restricting access to the queue.

To edit the message displayed to users with no access to the queue, do the following:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to **Access** → **All issues**.

1. Under **Message for users without access**, click **Edit**.

1. Write your message and click **Save**.



## Setting access rights to issues with components {#section_tbh_cs5_qbb}

You can configure access to various [components](components.md) of the queue. This lets you create separate setups for issues that have components and those that do not.

{% note warning %}

The rules for component access take priority over the rules for queue access.

{% endnote %}

To configure access to issues by component:

1. Open the [queue page](../user/queue.md).

1. [Add to the queue components](components.md#section_zrt_szk_xz) to control access to issues with.

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to **Access** → **Issues with component**.

1. Add users and groups to configure access for:

    - **Users and robots**: Individual settings for individual users. To add a user to this category, enter the login or the user's name in the search bar at the top of the table.

    - **Groups**: Settings for all employees.



    - **Roles**: Settings for users who have specific roles in queue issues:
        - **Access**: Users listed in the **Access** field of an issue.
        - **Follower**: Users who subscribed to the issue.
        - **Reporter**: The person who created the issue.
        - **Assignee**: The person assigned to the issue.
        - **Queue owner**.
        - **Queue team members**: Users added to the [queue team](queue-team.md). This role isn't on the list by default, but you can add it via the search bar at the top of the table.

1. Click **Save**.

{% note tip %}

To disable special access rights for a component, click **Clear**.

{% endnote %}

1. To configure access to an individual issue that differs from the access settings for the entire queue, add a component to the issue.

If an issue has several associated components, all users with access to at least one of them will be able to access the issue.


![](../../_assets/tracker/access-components.png)

If an issue has the **Hardware** and **Software** components, it can be accessed by users from both the <q>Product development</q> and <q>Application development</q> groups.



