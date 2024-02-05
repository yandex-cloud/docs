# Logging time spent

In {{ tracker-name }}, you can keep track of the time you spent resolving the issue.

To make sure that the issue statistics is correct, do not enter data on behalf of another employee. It is important for each employee to log their spent time on their own.

The time spent is counted in work weeks (five work days), work days (eight hours), hours, minutes, and seconds.

There are two ways to manage time tracking:

* [Basic method](#limited-spent-time): Use the **Add time spent** action in the list of actions.
* [Advanced method](#extended-spent-time): Use the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** section in the right-hand panel.

We recommend using the advanced method for tracking time, as it has more flexible configuration options and is easy to use.


## Basic time tracking {#limited-spent-time}

The **Time tracking** category in the issue fields shows the time according to plan and the actual time spent on the issue.

Before starting out on an issue, we recommend that you specify the time you plan to spend on it. When your work is done, you will be able to compare your preliminary estimate against the actual time you spent.

* **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}**: Time planned for resolving the issue.

* **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}**: You can specify how much time is still required to resolve the issue. Fill it out in the beginning or in the process of working on the issue.

   * If you do not specify the **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}**, whenever you [register time](#add-limited-time-spent), the value in the **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** field will decrease by the registered value.

   * If the **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}** field shows time, the value in the **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** field will not decrease immediately. It will only decrease after you spend more time than specified in the **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}** field.

* **Time spent**: Total time spent on resolving the issue. If you [logged time multiple times](#add-limited-time-spent), this field will show the total value.

### Registering time spent {#add-limited-time-spent}

To log time:

1. Open the issue page.

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_actions-panel_ActionsPanel.action-menu-title }}** → **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.add-worklog }}**.

1. Fill in the **{{ ui-key.startrek.ui_components_issue-actions_worklog_AddWorklogDialog.duration-label }}** field.

   Here is an example:
   * 1 week and 3 days: `1w 3d`.
   * 3 hours, 20 minutes, and 30 seconds: `3h 20m 30s`.

1. Fill in the **{{ ui-key.startrek.ui_components_issue-actions_worklog_AddWorklogDialog.date-label }}** field with the date and time in the current time zone.

   {% note info %}

   The date and time are saved in [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время) format.

   You can only get the saved value by sending a [request to the API](../concepts/issues/issue-worklog.md).

   {% endnote %}

1. Leave a comment, if needed. The comment will not be visible in the issue but will be saved in the [Time spent report](../manager/statistics.md#section_uxt_3ft_xz) and the [History of issue changes](#records-history).

1. Click **{{ ui-key.startrek.ui_components_issue-actions_worklog_AddWorklogDialog.apply-button }}**.

{% note info %}

You can add multiple entries. The time entered is summed up.

You can change the saved value only by sending a [request to the API](../concepts/issues/patch-worklog.md).

{% endnote %}

Any user can register their spent time, not only the issue's assignee. The [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz) will show efforts of all users who added their spent time to the issue.

### View time spent {#show-time-spent}

You can view the time spent on an issue under **Time tracking** in the right-hand panel on the issue page or in the [Time spent report](../manager/statistics.md#section_uxt_3ft_xz).

If the issue does not show the **Time tracking** section, add it:

1. Click ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_entity-page_sidebar_SidebarFieldsSelect.add-sidebar-field }}** in the right-hand panel.

1. In the **{{ ui-key.startrek-backend.fields.issue.fields.timetracking }}** group, enable **{{ ui-key.startrek-backend.fields.issue.spent-key-value }}** and **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}**.

## Advanced time tracking {#extended-spent-time}

With advanced time tracking, you can:

* [Add the spent time directly in the issue right-hand panel](#add-extended-time-spent).
* [Edit and delete logged time without using the API](#records-history).
* [Automatically calculate the time spent on the issue](../manager/queue-spent-time.md#calculate-time).
* [Keep track of the time left to resolve the issue](../manager/queue-spent-time.md#overall-time).
* [Use a convenient form that shows time](../manager/queue-spent-time.md#displayed-time).
* [Log time as numbers without any letters](../manager/queue-spent-time.md#number-without-letters).

To enable advanced time tracking for queue issues:

1. Open the [queue page](queue.md).
1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. Go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** tab.
1. Enable **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}**.
1. In **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-working-calendar }}**, choose one of the options.
1. Click **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.save }}**.

As a result, a new section called **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** will appear in the queue issues. All data of the **Time tracking** issue fields will be transferred to this section.

To switch back to basic time tracking, disable **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}** in the queue settings. Data from the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** section will be transferred to the fields of the **Time tracking** category.

### Registering time spent {#add-extended-time-spent}

To log time:

1. Make sure the **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-track-time-in-issues }}** option is enabled in the queue settings.
1. Open the issue page.
1. In the right-hand panel, click **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}**.
1. Fill in the **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.save }}** field.

   Here is an example:

   * 1 week and 3 days: `1w 3d`.
   * 3 hours, 20 minutes, and 30 seconds: `3h 20m 30s`.
   * Four [preferred time units](../manager/queue-spent-time.md#displayed-time): `4`.

1. In the **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-datetime-title }}** field, enter the date and time to display in the logged time record.
1. You can optionally add a comment on the record in the **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-comment-title }}** field.
1. Click **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.save }}**.

You can also log the time you spent using the [basic time tracking method](#add-limited-time-spent).

### Viewing and editing the record history {#records-history}

To open the logged time history for an issue, click ![](../../_assets/tracker/svg/history.svg) in the right-hand panel on the right side of the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}** field. This will open the **{{ ui-key.startrek.ui_components_FormField_TimeTrackingBlock.field-comment-title }}** window.

{% note alert %}

You can edit the record history only if the [time tracking settings](../manager/queue-spent-time.md) have the **{{ ui-key.startrek.ui_components_timetracking-history-dialog_TimeTrackingHistoryDialog.title }}** option enabled.

{% endnote %}

The author of a record can update the record **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-can-assignee-update-time }}** and **{{ ui-key.startrek.ui_components_timetracking-history-dialog_TimeTrackingDialogBody.column-date }}** fields. To do this, click ![](../../_assets/tracker/svg/icon-edit2.svg) to the right of the appropriate field value and enter a new one. You cannot edit the **{{ ui-key.startrek.ui_components_timetracking-history-dialog_TimeTrackingDialogBody.column-spent }}** field.

If a record was edited, you will see the ![](../../_assets/tracker/svg/history.svg) icon to the right of the **{{ ui-key.startrek.ui_components_queue-admin-tab-timetracking_TimetackingForm.field-can-assignee-update-time }}** field value. If you hover over it, a pop-up window with the record change history will appear.

The author of a record can also delete it. To do that, click ![](../../_assets/tracker/svg/actions.svg) → **{{ ui-key.startrek.ui_components_timetracking-history-dialog_TimeTrackingDialogBody.column-comment }}** on the right side of the record.