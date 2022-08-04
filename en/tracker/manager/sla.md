# Configuring rules

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

## Creating a rule {#section_n1s_42g_vdb}

The rule will apply to all new issues within the queue. The SLA timer will not be displayed in issues created before the rule.

To create a new SLA rule:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **SLA** tab.

1. Click **Create rule**.

1. Click ![](../../_assets/tracker/icon-edit.png) and name the rule.

1. Select a [work schedule](schedule.md). The schedule defines the time when the rule is active. The timer will be paused automatically during non-work hours.

1. You can use filters to select issues the rule will apply to. The filter is set to<q>All issues in queue</q> by default.

   * To add a new filter, click **Create new filter** and set the criteria for selecting issues.

    * To edit an existing filter, click ![](../../_assets/tracker/icon-edit.png).

   * To remove a filter, click ![](../../_assets/tracker/icon-delete.png).

   You can set up multiple filters for a single rule.

1. For each group, set the timeframe for completing issues in `00h 00m` format:

    - **Time until warning** (optional): When this time expires, {{ tracker-name }} sends a warning that the time to process the issue is running out.

    - **Time until expiration**: The time limit for processing the issue. At the end of this time, {{ tracker-name }} sends out a notification saying that the time is up.

1. Set the conditions for starting, pausing, or stopping the timer:

    - **Start**: The timer starts if any of the listed conditions are met. If the timer was paused, timing will continue from where it left off.

    - **Pause**: The timer pauses if any of the listed conditions is met. The timer will start when a condition from the **Start** list is met.

        {% note alert %}

        If the pause condition is set to "Issue has the status", the timer will start as soon as the issue is switched to any other status.

        {% endnote %}

    - **Stop**: The timer stops if any of the listed conditions is met.

    Possible conditions:

Condition | Description 
----- | -----
Assigned | The condition is met when the issue's assignee is changed.
Customer answer received | The condition is met when the issue is commented on by a user who is not a member of the [queue team](queue-team.md).
Issue created | This condition can only be selected for **Start**. The timer will start immediately after the issue is created.
Issue status changed to | The condition is met when the issue is switched to one of the specified statuses.
Resolution deleted | The condition is met when a previously set resolution is removed from the issue.
Issue has the status | This condition can only be selected for **Pause**. The timer will be paused while the issue has one of the specified statuses. After the status changes, the timer will start automatically.
Resolution set | The condition is met when one of the resolutions in the issue is set.
Received response from queue team | The condition is met when the issue is commented on by a user who is on the [queue team](queue-team.md).

1. In the **Notifications** section, specify how and whom to notify about overdue issues.

1. Click **Save**.

> **Example**
>
>Let's create a rule for monitoring response time to new issues. The timer for this rule will start as soon as the issue has been assigned, and will stop when the assignee starts working on it. If the assignee does not react to the issue within 15 minutes, you will receive an email notification.
>
>To create a rule, do the following:
>
>1. Under **Timeframes for issues**, set the maximum response time for an issue.
>
>   - Leave the **Time until warning** field blank.
>
>   - In the **Time until expiration** field, enter the maximum response time (for example, `15m`.
>
>1. Set up a timer:
>
>   - **Start**: Assignee set.
>
>   - **Stop**: The issue is switched to the <q>In progress</q> status.
>
>&emsp;Leave the **Pause** section empty.
>
>1. Set up notifications for overdue issues:
>
>   - **Method**: Email.
>
>   - **Recipients**: Your username in {{ tracker-full-name }}.

## View SLA rules {#section_nbs_r2g_vdb}

To view a list of SLA rules that apply in the queue:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **SLA** tab.

To view the rule settings, click the name of the rule:

- **Work schedule**

    The schedule defines the time when the rule is active. The timer will be paused automatically during non-work hours.

- **Timeframes for issues**

    The rule can be applied to all issues in the queue, or to specific groups of issues. You can set a different timeframe for each group:

    - **Time until warning** (optional): When this time expires, {{ tracker-name }} sends a warning that the time to process the issue is running out.

    - **Time until expiration**: The time limit for processing the issue. At the end of this time, {{ tracker-name }} sends out a notification saying that the time is up.

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

## Changing an SLA rule {#section_ljk_gb3_vdb}

To change an SLA rule:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **SLA** tab.

1. Select the rule.

1. Click **Edit**.

1. Make your changes and click **Save**.

