# Configuring rules

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

## Create an SLA rule {#section_n1s_42g_vdb}

To create a new SLA rule:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **SLA** tab.

1. Click **Create a rule**.

1. Click ![](../../_assets/tracker/icon-edit.png) and enter a name for the rule.

2. Choose [work schedule](schedule.md). The schedule defines the time when the rule is active. The timer will be paused automatically during non-work hours.

3. The rule can be applied to all issues in the queue, or to specific groups of issues. To add a new group of issues, click **Create a new filter** and set the criteria for selecting issues.

   To change an existing group, click ![](../../_assets/tracker/icon-edit.png).

4. For each group, set the timeframe for completing issues in `00h 00m` format:

    - **Time until warning** (optional): When this time expires, {{ tracker-name }} sends a warning that the time to process the issue is running out.

    - **Time until expiration**: The time limit for processing the issue. When this time ends, {{ tracker-name }} sends out a notification saying that the time is up.

5. Set the conditions for starting, pausing, or stopping the timer:

    - **Start**: The timer starts if any of the listed conditions is met. If the timer was paused, timing will continue from where it left off.

    - **Pause**: The timer pauses if any of the listed conditions is met. The timer starts when a condition from the **Start** list is met.

        {% note alert %}

        If the pause condition is set to "Issue has the status", the timer will start as soon as the issue is switched to any other status.

        {% endnote %}

    - **Stop**: The timer stops if any of the listed conditions is met.

    Possible conditions:
    
    Condition | Description
    ----- | -----
    Assigned | The condition is met when the issue's assignee is changed.
    Response from requester | This condition is considered fulfilled when a user not on the [queue team](queue-team.md) adds a comment to the issue.
    Issue created | This condition can only be applied to **Start**. The timer will start immediately after the issue is created.
    Issue status changed to | The condition is met when the issue is switched to one of the specified statuses.
    Resolution deleted | The condition is met when a previously set resolution is removed from the issue.
    Issue has the status | This condition can only be selected for **Pause**. The timer will be paused while the issue has one of the specified statuses. After the status changes, the timer will start automatically.
    Resolution set | This condition is met when the one of the resolutions in the issue is set.
    Queue team responded | This condition is considered fulfilled if a user on the [queue team](queue-team.md) adds a comment to the issue.

6. In the **Notifications** section, specify how and who to notify of overdue issues.

7. Click **Save**.

> **Example**
Let's create a rule for monitoring response time to new issues. The timer for this rule will start as soon as the issue has been assigned, and will stop when the assignee starts working on it. If the assignee does not react to the issue within 15 minutes, you will receive an email notification.

To create a rule, do the following:

1\. Under **Timeframes for issues**, set the maximum response time for an issue.

   - Leave the **Time until warning** field blank.

   - In the **Time until expiration** field, enter the maximum response time (for example, `15m`).

2\. Set up a timer:

   - **Start**: Assignee set.

   - **Stop**: The issue is switched to the status <q>In progress</q>.

&emsp;Leave the **Pause** section empty.

3\. Set up notifications for overdue issues:

   - **Notify via**: Email.

   - **Recipients**: Your username.

## View SLA rules {#section_nbs_r2g_vdb}

To view a list of SLA rules that apply in the queue:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **SLA** tab.

To view the rule settings, click the name of the rule:

- **Work schedule**

    The schedule defines the time when the rule is active. The timer will be paused automatically during non-work hours.

- **Timeframes for issues**

    The rule can be applied to all issues in the queue, or to specific groups of issues. You can set a different timeframe for each group:

    - **Time until warning** (optional): When this time expires, {{ tracker-name }} sends a warning that the time to process the issue is running out.

    - **Time until expiration**: The time limit for processing the issue. When this time ends, {{ tracker-name }} sends out a notification saying that the time is up.

- **Timer settings**

    Events that start, pause, or stop the timer:

    - **Start**: The timer starts if any of the listed conditions is met. If the timer was paused, timing will continue from where it left off.

    - **Pause**: The timer pauses if any of the listed conditions is met. The timer starts when a condition from the **Start** list is met.

        {% note info %}

        If the pause condition is set to <q>Issue has the status</q>, the timer will start as soon as the issue is switched to any other status.

        {% endnote %}

    - **Stop**: The timer stops if any of the listed conditions is met.

- **Notifications**

    Who gets notified of overdue issues and how {{ tracker-name }} sends notifications.

## Change a rule {#section_ljk_gb3_vdb}

To change an SLA rule:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **SLA** tab.

1. Select the rule.

1. Click **Edit**.

1. Make your changes and click **Save**.


[Contact support](../troubleshooting.md)

