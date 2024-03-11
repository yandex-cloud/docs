# Setting up an issue reminder

{{ tracker-name }} can send issue reminders. You can send a reminder to yourself or to another user. Reminders are only visible to their author and recipient.

## Creating a reminder {#create-reminder}

To set up reminder:

1. Open the issue page.

   {% note info %}

   To open your issue list, in the left-hand menu, select ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar.issue-lists-menu-item }}** → **All my issues** or follow the [link]({{ link-tracker }}issues/my-issues). To start working on an issue, go to its page.

   {% endnote %}

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.add-notification }}**.

1. Specify the date and time of the reminder.

1. To send an issue reminder regardless of the issue status, select **Remind even if issue closed**.

1. Enter the comment. The user will receive it in the reminder message.

1. Specify the recipient of the reminder. For this, start typing the name or username of the user and select the proper option from the list.

   A reminder can only have one recipient. If you want to remind several users about the issue, create a reminder for each of them.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**. On the issue page, you will see the ![](../../_assets/tracker/svg/reminder.svg) icon with the reminder count.

{{ tracker-name }} will send an email to the user at the time specified, and a pop-up reminder will appear on the issue page.

## Editing and deleting reminders {#edit-reminder}

To edit or delete an issue reminder:

1. Open the issue page.

1. Click the ![](../../_assets/tracker/svg/reminder.svg)icon.

1. Click the ![](../../_assets/tracker/svg/icon-edit1.svg) icon to edit or ![](../../_assets/tracker/svg/icon-remove.svg) to delete a reminder.

## Create an event in the calendar {#calendar}

To add an entry about working on the issue or arrange a meeting with issue participants in [Yandex Calendar]({{ support-calendar }}):

1. Open the issue page.

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_actions-panel_ActionsPanel.action-menu-title }}** → **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.create-calendar-event }}** → **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.calendar-event-me }}**.

1. Enter information about the calendar event. If needed, add the meeting participants, then click **Create**.
