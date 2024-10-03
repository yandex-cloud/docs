---
title: How to set up rules
description: Follow this guide to set up rules.
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

1. Go to the **SLA rules** tab.

1. Click **Create rule**.

1. The default rule name is `New SLA rule`. To edit the name, click it and enter a new one.

1. Select a [work schedule](schedule.md) from the list. The schedule sets the time when the rule is active. The timer will not count outside your working hours.

1. Configure **Issue groups that meet the rule, and the time to respond**, if required. Issue are grouped using filters. You can set an individual deadline and warning time for each issue group. The **All issues in the queue** filter is enabled by default.

   * The default issue group name is `New issue group`. To edit the name, click it and enter a new one.

   * To add a filter, click **+** under the issue group name and select a field for filtering from the list. You will see this field added to the issue group row. Click a field for filtering and select an appropriate value. If you use multiple fields for filtering, click **+** once again and repeat the above steps.

   * Specify **Time until warning** (optional) in `00h 00m` format. When this time expires, {{ tracker-name }} sends a warning that the time to process the issue is running out.

   * Specify **Time until expiration** in `00h 00m`. It is the time limit for processing the issue. After this time runs out, {{ tracker-name }} sends out a notification saying that the time is up.

   * You can set up multiple issue groups per SLA rule. To create an issue group, click **+ Add issue group**.

   * To delete an issue group, click ![](../../_assets/console-icons/trash-bin.svg) at the end of its row.

1. Under **Time limit notifications**, specify how to send warnings and notifications about overdue issues and to whom.

1. Under **SLA timer settings**, set the conditions on which the timer will start, pause, or stop:

   * **Start**: The timer starts if any of the listed conditions is met. If the timer was on pause, the time count will resume.

   * **Pause**: The timer pauses if any of the listed conditions is met. The timer will start when a condition from the **Start** list is met.

      {% note alert %}

      If the pause condition is set to **{{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }}**, the timer will restart as soon as the issue switches to any other status.

      {% endnote %}

   * **Stop**: The timer stops if any of the listed conditions is met.

   Possible conditions:
   Condition | Timer mode | Description
   ----- | ----- | -----
   {{ ui-key.startrek-backend.messages.sla.assignee.deleted.timer.trigger.condition.type }} | **Start**, **Stop** | The condition is met when the issue assignee is removed.
   {{ ui-key.startrek-backend.messages.sla.assignee.set.timer.trigger.condition.type }} | **Start**, **Stop** | The condition is met when a new assignee is set for the issue.
   {{ ui-key.startrek-backend.messages.sla.client.commented.timer.trigger.condition.type }} | **Start**, **Stop** | The condition is met when the issue is commented on by a user who is not a member of the [queue team](queue-team.md).
   {{ ui-key.startrek-backend.messages.sla.issue.created.timer.trigger.condition.type }} | **Start** | The timer starts once the issue is created.
   {{ ui-key.startrek-backend.messages.sla.status.changed.timer.trigger.condition.type }} | **Start**, **Stop** | The condition is met when the issue is switched to one of the specified statuses.
   {{ ui-key.startrek-backend.messages.sla.resolution.deleted.timer.trigger.condition.type }} | **Start** | The condition is met when a previously set resolution is removed from the issue.
   {{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }} | **Pause** | The timer will be paused while the issue is in one of the specified statuses. After the status changes, the timer will start automatically.
   {{ ui-key.startrek-backend.messages.sla.resolution.set.timer.trigger.condition.type }}
    | **Stop** | The condition is met when one of the specified resolutions in the issue is set.
   {{ ui-key.startrek-backend.messages.sla.team.commented.timer.trigger.condition.type }} | **Stop** | The condition is met when the issue is commented on by a user who is a member of the [queue team](queue-team.md).
   {{ ui-key.startrek-backend.messages.sla.issue.has.assignee.condition.type }} | **Pause** | The timer will be paused while the issue has an assignee set. Once the assignee is removed, the timer will restart automatically.
   {{ ui-key.startrek-backend.messages.sla.issue.has.no.assignee.condition.type }} | **Pause** | The timer will be paused while the issue has no assignee set. Once the assignee is set, the timer will start automatically.

1. You can configure the timer to reset if the start conditions are met. To do this, enable **Restartable timer** under **SLA timer settings**. In this case, instead of resuming the time count, it will restart after the pause.

1. Click **Create rule**.

### Example {#example}

Let's create a rule to control the response time to new issues. The timer of the rule will start as soon as the issue is assigned and paused as soon as the assignee starts working on the issue. If the assignee does not respond to the issue within 15 minutes, you will get notified by email.

To create a rule:

1. Under **Issue groups that meet the rule, and the time to respond**:

   * Since the rule must apply to all queue issues, do not add new issue groups and do not configure filters in the default issue group.

   * Leave the **Time until warning** field blank.

   * In the **Time until expiration** field, enter the maximum response time, for example, `15m`.

1. Under **Time limit notifications**, configure notifications about overdue issues:

   * Under **Warnings**, leave it set to **No notifications**.

   * Under **Missing a deadline**, select **Send email** and enter your username in {{ tracker-name }}.

1. Under **SLA timer settings**, set up a timer:

   * **Start**: **Assignee set**.

   * Leave the **Pause** section empty.

   * **Stop**: Select the **Issue status changed to** condition, click **+** under it and select **In progress**.

## View SLA rules {#section_nbs_r2g_vdb}

To view a list of SLA rules in the queue:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **SLA rules** tab.

To view the parameters of a rule, click ![](../../_assets/console-icons/chevron-down.svg) in the relevant section:

* **Work schedule**

   The schedule sets the time when the rule is active. The timer will not count outside your working hours.

* **Issue groups that meet the rule, and the time to respond**

   The rule can apply not only to all the issues in the queue but also to individual issue groups made up using filters. You can set up individual timeframes for each group:

   * **Time until warning** (optional): When this time expires, {{ tracker-name }} sends a warning that the time to process the issue is running out.

   * **Time until expiration**: Time limit for processing the issue. After this time runs out, {{ tracker-name }} sends out a notification saying that the time is up.

* **Time limit notifications**

   Who gets {{ tracker-name }} warnings and notifications of overdue issues and how.

* **SLA timer settings**

   The events on which the timer will start, pause, or stop:

   * **Start**: The timer starts if any of the listed conditions is met. If the timer was on pause, the time count will resume.

   * **Pause**: The timer pauses if any of the listed conditions is met. The timer will start when a condition from the **Start** list is met.

      {% note info %}

      If the pause condition is set to **{{ ui-key.startrek-backend.messages.sla.issue.on.status.timer.trigger.condition.type }}**, the timer will restart as soon as the issue switches to any other status.

      {% endnote %}

   * **Stop**: The timer stops if any of the listed conditions is met.

## Changing an SLA rule {#edit-rule}

To edit the SLA rule:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **SLA rules** tab.

1. Select the rule and click ![](../../_assets/console-icons/chevron-down.svg) in the relevant section.

1. Make your changes and click **Save**.
