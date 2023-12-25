---
title: "How to set up rules"
description: "Follow this guide to set up rules."
---

# Configuring rules

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

## Creating a rule {#create-rule}

The rule will be applied to all the new issues in the queue. The SLA timer will not appear in the issues created earlier than the rule.

To create a new SLA rule:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **SLA** tab.

1. Click **Create rule**.

1. Click the ![](../../_assets/tracker/icon-edit.png
   ) icon and name the rule.

1. Select a [work schedule](schedule.md). The schedule sets the time when the rule is active. The timer will not count outside your working hours.

1. You cannot use filters to select the issues that the rule will be applied to. The <q>{{ ui-key.startrek-backend.defaults.sla.default.filter.name }}</q> filter is enabled by default.

   * To add an issue filter, click **Create a new filter** and set the criteria for selecting issues.

   * To change an existing filter, click ![](../../_assets/tracker/icon-edit.png
      ).

   * To delete the filter, click ![](../../_assets/tracker/icon-delete.png).

   You can set up multiple filters per rule.

1. For each group, set the timeframe for completing issues in `00h 00m` format:

   * **Time until warning** (optional): When this time expires, {{ tracker-name }} sends a warning that the time to process the issue is running out.

   * **Time until expiration**: Time limit for processing the issue. At the end of this time, {{ tracker-name }} sends out a notification saying that the time is up.

1. Set the conditions on which the timer will start, pause, or stop.

   * **Start**: The timer starts if any of the listed conditions is met. If the timer was on pause, the time count will resume.

   * **Pause**: The timer pauses if any of the listed conditions is met. The timer will restart when a condition from the **Start** list is met.

      {% note alert %}

      If the pause condition is set to "{{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }}", the timer will start as soon as the issue is switched to any other status.

      {% endnote %}

   * **Stop**: The timer stops if any of the listed conditions is met.

   Possible conditions:
   Condition | Timer mode | Description
   ----- | ----- | -----
   {{ ui-key.startrek-backend.messages.sla.assignee.deleted.timer.trigger.condition.type }} | **Start**, **Stop** | The condition is met when the issue assignee is removed.
   {{ ui-key.startrek-backend.messages.sla.assignee.set.timer.trigger.condition.type }} | **Start**, **Stop** | The condition is met when a new assignee is set for the issue.
   {{ ui-key.startrek-backend.messages.sla.client.commented.timer.trigger.condition.type }} | **Start**, **Stop** | The condition is met when the issue is commented on by a user who is not a member of the [queue team](queue-team.md).
   {{ ui-key.startrek-backend.messages.sla.issue.created.timer.trigger.condition.type }}
    | **Start** | The timer starts once the issue is created.
   {{ ui-key.startrek-backend.messages.sla.status.changed.timer.trigger.condition.type }}
    | **Start**, **Stop** | The condition is met when the issue is switched to one of the specified statuses.
   {{ ui-key.startrek-backend.messages.sla.resolution.deleted.timer.trigger.condition.type }}
    | **Start** | The condition is met when a previously set resolution is removed from the issue.
   {{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }}
    | **Pause** | The timer will be paused while the issue is in one of the specified statuses. After the status changes, the timer will start automatically.
   {{ ui-key.startrek-backend.messages.sla.resolution.set.timer.trigger.condition.type }}
    | **Stop** | The condition is met when one of the resolutions in the issue is set.
   {{ ui-key.startrek-backend.messages.sla.team.commented.timer.trigger.condition.type }}
    | **Stop** | The condition is met when the issue is commented on by a user who is a member of the [queue team](queue-team.md).
   {{ ui-key.startrek-backend.messages.sla.issue.has.assignee.condition.type }}
    | **Pause** | The timer will be paused while the issue has an assignee set. Once the assignee is removed, the timer will restart automatically.
   {{ ui-key.startrek-backend.messages.sla.issue.has.no.assignee.condition.type }} | **Pause** | The timer will be paused while the issue has no assignee set. Once the assignee is set, the timer will start automatically.

1. You can configure the timer to reset if the start conditions are met. To do this, select **Restart the timer each time start conditions are triggered** under **Restart**. In this case, instead of resuming the time count, it will restart after the pause.

1. In the **Notifications** section, specify who should be notified of overdue issues and which way.

1. Click **Save**.

### Example {#example}

Let's create a rule to control the response time to new issues. The timer of the rule will start as soon as the issue is assigned and paused as soon as the assignee starts working on the issue. If the assignee does not respond to the issue within 15 minutes, you will get notified by email.

To create a rule:

1. Under **Timeframes for issues**, set the maximum response time for an issue:
   * Leave the **Time until warning** field blank.

   * In the **Time until expiration** field, enter the maximum response time, such as `15m`.

1. Set up a timer:
   * **Start**: Assignee set.

   * **Stop**: The issue is switched to the <q>In progress</q> status.

   * Leave the **Pause** section empty.

1. Set up a notification about overdue deadlines.
   * **Notify via**: Email.

   * **Recipients**: Your username in Yandex Tracker.

## View SLA rules {#section_nbs_r2g_vdb}

To view a list of SLA rules in the queue:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **SLA** tab.

To view the parameters of the rule, click its name:

* **Schedule**

   The schedule sets the time when the rule is active. The timer will not count outside your working hours.

* **Timeframes for issues**

   The rule can be not only applied to all the issues in the queue, but also to specific issue groups. You can set up individual timeframes for each group:

   * **Time until warning** (optional): When this time expires, {{ tracker-name }} sends a warning that the time to process the issue is running out.

   * **Time until expiration**: Time limit for processing the issue. At the end of this time, {{ tracker-name }} sends out a notification saying that the time is up.

* **Timer settings**

   The events on which the timer will start, pause, or stop:

   * **Start**: The timer starts if any of the listed conditions is met. If the timer was on pause, the time count will resume.

   * **Pause**: The timer pauses if any of the listed conditions is met. The timer will start when a condition from the **Start** list is met.

      {% note info %}

      If the pause condition is set to <q>{{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }}</q>, the timer will restart as soon as the issue is switched to any other status.

      {% endnote %}

   * **Stop**: The timer stops if any of the listed conditions is met.

* **Notifications**

   Who gets notified of overdue issues and how {{ tracker-name }} sends notifications.

## Changing an SLA rule {#edit-rule}

To edit the SLA rule:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **SLA** tab.

1. Select the rule.

1. Click **Edit**.

1. Make your changes and click **Save**.
