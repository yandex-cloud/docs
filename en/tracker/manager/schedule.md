# Work schedule

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

Work schedules allow you to set up the timeframe for when the [SLA rule](sla.md) applies. Outside the working hours, the SLA timer will be idle. You can select a standard schedule for the rule or create a custom schedule.

{% note info %}

In the **{{ ui-key.startrek.blocks-desktop_calendar-editor--working-time-select.option--daily24x7 }}** system schedule, holidays are considered non-working days, and the SLA timer is idle on these days.

{% endnote %}


## Creating work schedules {#section_rlk_hkg_x2b}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Select **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-calendars }}**.

1. Tap **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendars.create-calendar }}**.

1. Click ![](../../_assets/tracker/icon-edit.png) and name the schedule. Click ![](../../_assets/tracker/approve-checkmark.png) to save the name.

1. Select the time zone.

1. Set a schedule.

1. Select **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendar-editor.holidays-title }}** that will be different from the default schedule. To do this, click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendar-editor.no-holidays-title }}** and set the following parameters:

   - Select the country to choose the occupational calendar of your region.

   - Add **SLA exceptions** if your work schedule differs from the official calendar.

1. Tap **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendar-editor.action-save }}**.

You can view the schedule you created in the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendars.custom-calendars }}** section. Other users won't be able to view or use your schedule.

## Editing work schedules {#section_vkm_flh_x2b}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Select **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-calendars }}**.

1. Under **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendars.custom-calendars }}**, click the name of the schedule you need.

1. Click ![](../../_assets/tracker/svg/icon-edit1.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendars.edit-button }}**.

1. Make your changes and click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendar-editor.action-save }}**.


