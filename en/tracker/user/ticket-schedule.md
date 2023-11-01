# Scheduled issue creation

You can use {{ tracker-name }} to set up scheduled issue creation using a template. For example, every week you can create an issue for data backup.

Such issues are only created in queues where auto updates are configured. The reporter for these issues is the Tracker robot.

{% note tip %}

Make sure that the robot has rights for creating issues in the selected queue.

{% endnote %}

To schedule creation of issues:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. In the left-hand panel, select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoactions.title }}**.

   {% note info %}

   Scheduled issue creation is currently not supported in the new interface. The following steps are performed in the old interface.

   {% endnote %}

1. On the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoactions.title }}** page, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoactions.button-create }}**.

1. Select the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.type-toggle--create }}** type.

1. Set up a period for creating issues:

   1. Select the unit for the issue creation period: hours, days, or weeks.

   1. Specify the period of creating issues in the selected units. To do this, enter a number between 1 and 1000 in the **{{ ui-key.startrek.components_QueueAdminAutoactions_Cron.every }}({{ ui-key.startrek.components_QueueAdminAutoactions_Cron.every-week }})** field.

      For example, if you specify <q>Every 4 days</q>, a new issue is created every 4 days.

      ![](../../_assets/tracker/schedule-setup.png)

      If your schedule is based on days, you can also choose **{{ ui-key.startrek.components_QueueAdminAutoactions_Cron.every-work-day }}** and [work schedule](../manager/schedule.md).

      If you set your issue creation period in weeks, select the days of the week when your issues will be created.

   1. Enter the start and end date/time when your automatic issue creation will be valid. If you omit the start and end dates, automatic issue creation will run permanently.

1. Under **{{ ui-key.startrek.components_QueueAdminAutoactions_CreateTicketForm.actions }}**, click **{{ ui-key.startrek.components_QueueAdminAutoactions_CreateTicketForm.actions-create }}**.

1. Fill in the fields of the automatic issue creation template in the **{{ ui-key.startrek.blocks-desktop_trigger-action.title_createissue }}** window and click **{{ ui-key.startrek.ui_components_FieldEdit.form-submit }}**.

1. If you wish to include multiple issues in one auto action, click **{{ ui-key.startrek.components_QueueAdminAutoactions_CreateTicketForm.actions-create }}** again and fill in the fields for a new issue.

1. To save an auto action, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.



