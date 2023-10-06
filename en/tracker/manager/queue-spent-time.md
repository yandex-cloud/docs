# Setting up time tracking

To make [time tracking](../user/time-spent.md) more convenient, you can enable [advanced time tracking](../user/time-spent.md#extended-spent-time) and set it up.

To do this:

1. In the queue settings, go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** tab.
1. Enable **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}**.
1. In **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-working-calendar }}**, choose one of the options.
1. Click **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.save }}**.

As a result, a new section called **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** will appear in the queue issues. All data of the **{{ ui-key.startrek.blocks-desktop_b-screen.worklog }}** issue fields will be transferred to this section.

If you disable the **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}** option, data from the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** section will be moved back to the fields of the **{{ ui-key.startrek.blocks-desktop_b-screen.worklog }}** category.

## Granting the permission to edit time to the assignee {#assignee-edit}

By default, the [logged time history](../user/time-spent.md#records-history) can only be edited through an [API request](../concepts/issues/patch-worklog.md).

To allow the author of a record to edit or delete it right in the history window, enable **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-can-assignee-update-time }}**.

## Automatically calculating the time spent on an issue when closing it {#calculate-time}

You can set up automatic calculation of the time spent on issues. If, when closing an issue, it has no time logged, the [transition screen](workflow-action-edit.md) will contain the **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-spent-title }}** field with a filled value.

For this, enable the **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-show-time-field-on-close }}** option and [set up the transition screen](workflow-action-edit.md) to the final issue status.

{% cut "How the time is calculated" %}

If this option is enabled, the time spent on an issue is calculated as follows:

* The starting point is when the issue's initial status changes to ![](../../_assets/tracker/changelogs/status-2-in-progress.svg).
* The end point is when the issue status changes to ![](../../_assets/tracker/changelogs/status-4-solved.svg).
* Between these two points, only the work time set in the [work schedule](#work-schedule) is tracked.

For example, on Friday, June 1, at 9 a.m., the issue status changed from **Open** to **In progress**. On Monday, June 4, at 2 p.m., the issue status was changed to **Closed**. The issue queue has the following schedule set up: weekdays, 8 a.m. to 5:00 p.m.

{{ tracker-name }} will keep track of two time intervals: June 1, from 9 a.m. to 5 p.m., and June 4, from 8 p.m. to 2 p.m. June 2 and June 3 will be ignored, as Saturday and Sunday are weekend. As a result, the total amount of time spent on the issue will be 14 hours.

{% endcut %}

## Logging the time left and the total time spent on an issue {#overall-time}

You can add more fields to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** section:

* In the **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-remain-title }}** field, you can specify how much longer you plan to work on the issue. To add this field, enable **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-show-time-field-on-close }}**.
* In the **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-estimation-title }}** field, you can specify the total amount of time you plan to spend on the issue. To add this field, enable **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-use-remaining-time }}**.

If any of these fields is used, the issue page will show the issue progress bar in the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** field.

{% note info %}

The **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-remain-title }}** and **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-estimation-title }}** fields are related as follows:

**{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-spent-title }}** + **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-remain-title }}** = **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-estimation-title }}**

If both fields are used, when the value in one of them changes, the value in the other field will be set automatically.

{% endnote %}

## Setting up work schedules {#work-schedule}
You can set up work schedules for the issue assignees in the current queue. This data is used when [automatically calculating the time spent](#calculate-time). To set a work schedule, select the appropriate option in the **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-working-calendar }}** field.

If none of the schedule options suits you, you can [create a custom one](schedule.md).

## Choosing time format {#displayed-time}

By default, time is displayed as **1w 2d 3h 4m 5s**: business weeks, business days, hours, minutes, and seconds. To change this format, select one of the options in the `Displayed time` field.

## Logging time without letters {#number-without-letters}

In basic time tracking mode, you cannot just enter the time as a number and must always specify what exactly you are logging: weeks, days, minutes, or seconds.

In advanced time tracking mode, you can select the preferred time unit and enter it as a number without adding any letter. To enable this, select one of the options in the **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-use-summary-time }}** field.