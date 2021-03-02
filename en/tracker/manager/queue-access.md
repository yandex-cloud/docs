# Set access rights for queues

{% note warning %}

By default, only the queue owner can configure a queue.

{% endnote %}

## Set access rights for queues {#section_bvq_dc3_3z}

By default, users have unrestricted access to issues in a queue.

If you restrict access to your queue, only the users specified in the following fields will have access to its issues by default: **Reporter**, **Assignee**, **Followers**, and **Access**.

You can change access settings for individual users, groups, or roles:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **Access** → **All issues** tab.

1. Add users and groups to configure access permissions for:

    - **Users and robots**: Individual settings for individual users. To add a user to this category, enter the login or the user's name in the search bar at the top of the table.

    - **Groups**: Settings for departments and teams. To add a new department, enter its name in the search bar at the top of the table.

        {% note tip %}

        To add all company employees, select the `All employees` group.

        {% endnote %}

    - **Roles**: Settings for users who have specific roles in queue issues:
        - **Access**: Users listed in the **Access** field of an issue.
        - **Follower**: Users who subscribed to the issue.
        - **Reporter**: The person who created the issue.
        - **Assignee**: The person assigned to the issue.
        - **Queue owner**.
        - **Queue team member**: Users added to the [queue team](queue-team.md). This role isn't on the list by default, but you can add it via the search bar at the top of the table.

1. Set permissions to perform queue actions:

    - **Create issues**: Users can create issues for this queue.

    - **View issues**: Users can comment on an issue and change its status, but they can't edit the issue field values.

        {% note warning %}

        The View Issues permission isn't sufficient for a [bulk change of multiple issue statuses at once](bulk-change.md#section_kkf_tjr_fgb). Users need permissions to edit issues.

        {% endnote %}

    - **Edit issues**: Users can comment on an issue, change its status, and edit field values (for instance, update the deadline, add followers, and so on).

    - **Queue settings**: Users can edit the [queue settings](edit-queue-general.md).

1. Click **Save**.

If a user has multiple roles, they gain all access rights associated with each role.

> **Example**

![](../../_assets/tracker/access-roles.png)

If a user is both the reporter and the assignee, they're allowed to **Create issues**, **View issues**, and **Edit issues**.

## Add a message for users who can't access issues {#deny-message}

When a user is trying to open an issue from a queue they don't have access to, a message pops out that says <q>Contact the queue owner</q> with the owner's name.

This message can be changed, however. For instance, you can specify another user with queue admin rights who can give access to issues. You can also specify the reason for restricting access to the queue.

To edit the message displayed to users with no access to the queue, do the following:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **Access** → **All issues** tab.

1. Under **Message for users without access**, click **Edit**.

1. Write your message and click **Save**.

   If you want to add a link to a user profile in your message, specify their username followed by the `@` symbol, such as `login@`.

## Set access rights to issues with components {#section_tbh_cs5_qbb}

You can configure access to various components of the queue. This lets you create separate setups for issues that have components and those that do not. The rules for component access take priority over the rules for queue access.

To configure access to issues by component:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to **Access** → **Issues with component**.

1. Add users and groups to configure access permissions for:

    - **Users and robots**: Individual settings for individual users. To add a user to this category, enter the login or the user's name in the search bar at the top of the table.

    - **Groups**: Settings for departments and teams. To add a new department, enter its name in the search bar at the top of the table.

        {% note tip %}

        To add all company employees, select the `All employees` group.

        {% endnote %}

    - **Roles**: Settings for users who have specific roles in queue issues:
        - **Access**: Users listed in the **Access** field of an issue.
        - **Follower**: Users who subscribed to the issue.
        - **Reporter**: The person who created the issue.
        - **Assignee**: The person assigned to the issue.
        - **Queue owner**.
        - **Queue team member**: Users added to the [queue team](queue-team.md). This role isn't on the list by default, but you can add it via the search bar at the top of the table.

1. Click **Save**.

If an issue has several associated components, all users with access to at least one of them will be able to access the issue.

> **Example**

![](../../_assets/tracker/access-components.png)

If an issue has the **Hardware** and **Software** components, it can be accessed by users from both the <q>Product development</q> and <q>Application development</q> groups.

## Set access rights to issues in private queues {#section_kgf_gmm_52b}

{% note info %}

Creating a _private_ queue allows you to only grant access to important information to one or a limited number of users.

{% endnote %}

You can configure access so that users can work with some issues in your queue without having access to this queue. To do this:

1. Open the queue page.

1. To the left of the queue name, choose ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **Access** → **All issues** tab.

1. Configure roles so that only the queue owner can **Create issues**, **View issues**, **Edit issues**, and change the **Queue settings**.

1. Go to the **Issues with component** tab.

1. Open the settings of the component you need. Set access rights to issues with components for individual users or roles.

1. Click **Save**.



[Contact support](../troubleshooting.md)

