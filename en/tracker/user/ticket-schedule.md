# Scheduled issue creation

You can use {{ tracker-name }} to set up scheduled issue creation using a template. For example, this lets you automatically create a data backup issue every week.

Such issues are only created in queues where auto updates are configured. The reporter for these issues is the Tracker robot.

{% note tip %}

Make sure the robot has permission to create issues in the queue.

{% endnote %}

To set up scheduled issue creation:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. On the left-hand panel, select **Automation** → **Auto actions** and click **Create auto action**.

1. Choose **Create issues**.

1. Set up your issue creation schedule:

    1. Select the units of time for setting the issue creation schedule: hours, days, or weeks.

    1. Set the schedule based on those units. To do this, enter a number between 1 and 1000 in the **Every** field.

       For example, if you specify <q>Every 4 days</q>, a new issue is created every 4 days.

       ![](../../_assets/tracker/schedule-setup.png)

       If your schedule is based on days, you can also choose **Every work day** and [work schedule](../manager/schedule.md).

       If your schedule is based on weeks, choose the days to create new issues on.

    1. Set the dates and time for when automatic issue creation starts and ends. If you don't specify the start and end dates, issues will continue to be created.

1. Under **Queue action**, click **Create issue**.

1. Fill in the fields of the automatic issue creation template in the **Create issues** window and click **Save**.

1. If you wish to include multiple issues in one auto action, click **Create issue** again and fill in the fields for the new issue.

1. To save an auto action, click **Create**.

