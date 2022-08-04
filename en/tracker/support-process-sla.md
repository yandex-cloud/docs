# Tracking the time it takes to process a request

When gauging the efficiency of your support team, the most common method is to track the time of their first response and the total time it takes to process a request. The lower these indicators are, the faster your team is at resolving users' issues.

To manage the response handling time in {{ tracker-name }}, [configure SLA rules](manager/sla.md) for your queue's issues. An SLA rule lets you set the time limit for processing a request and enable a timer that starts and stops as certain events are triggered (for example, during issue creation, a status change, when adding an assignee, and so on).

Let's set up SLA rules that will track the time of the support team's first response and the total request processing time.

### First response time

To measure your support team's first response time, set up a timer that starts when an issue is created and stops when an employee sends a comment or email from the issue page.

1. Go to **SLA** in the queue settings and click [**Create rule**](manager/sla.md).

1. Set the rule's name and choose [Work schedule](manager/schedule.md) so that the timer is only active during business hours.

1. Under **Timeframes for issues**, set the following parameters for all issues in the queue:

    - Set the time limit for the first response in the **Time until expiration** field. For example, if you want to set the time to 2 hours and 30 minutes, write `2h 30m`.

    - In the **Time until warning** field, choose a time limit which triggers an automatic email reminder after expiring.

    {% note info %}

    If you want different issue groups to have different time limits, click **Create new filter** and set parameters for grouping these issues.

    {% endnote %}

    ![](../_assets/tracker/support-sla-time-response.png)

1. Set the conditions that start and stop the timer:

    1. Under **Start**, add the condition **Issue created**.

    1. Under **Stop**, add the condition **Received response from queue team**.

    ![](../_assets/tracker/support-sla-timer.png)

1. If you want to automatically email the employee responsible for the issue once the first response time has expired, select **Notification** → **Overdue time limit** and specify that employee's name or username in **Email**.

1. Save your rule.

Now the timer will be automatically enabled after the issue is created in the support team queue. It will count down until a support staff member from the [queue team](manager/queue-team.md) sends a comment or email from the issue page.

### Total request processing time

If you want to measure the total request processing time, set up a timer that triggers during issue creation and stops once the issue status is updated to <q>Resolved</q> or <q>Closed</q>. You can pause the timer while the issue is in the <q>Need info</q> status so that the waiting time is not counted towards the total processing time.

1. Go to **SLA** in the queue settings and click [**Create rule**](manager/sla.md).

1. Set the rule's name and choose [Work schedule](manager/schedule.md) so that the timer is only active during business hours.

1. Under **Timeframes for issues**, set the following parameters for all issues in the queue:

    - Set the time limit for resolving the issue in the **Time until expiration** field. For example, specify `8h` if you want the limit to be 8 working hours.

    - In **Time until warning**, choose a time limit which triggers an automatic email reminder after expiring. For example, specify `6h` if you want the limit to be 6 working hours.

    {% note info %}

    If you want different issue groups to have different time limits, click **Create new filter** and set parameters for grouping these issues.

    {% endnote %}

    ![](../_assets/tracker/support-sla-time-total.png)

1. Set the conditions that start and stop the timer:

    1. Under **Start**, add the condition **Issue created**.

    1. Under **Pause**, add the condition **Issue has the status** → **Needs info**.

    1. Under **Stop**, add the condition **Issue status changed to** and select the **Resolved** and **Closed** statuses.

    ![](../_assets/tracker/support-sla-timer-total.png)

1. Under **Notification**, set up notifications that trigger once the time limit is expired:

    - If you specified the warning time limit under **Timeframes for issues**, choose **Email** in the **Warning** field and specify the name or username of the employee responsible for the issue. This way, they will receive a notification once the set time limit expires.

    - If you want to automatically email the employee responsible for the issue once the resolution time limit has expired, under **Overdue time limit**, specify that employee's name or username in **Email**.

1. Save your rule.

Now the timer will be automatically enabled after the issue is created in the support team queue. The timer will be active until the issue status is updated to <q>Resolved</q> or <q>Closed</q>. If a support specialist asks the requester for additional information and updates the issue status to <q>Need info</q>, the timer will be paused and can only be unpaused after another status change.

