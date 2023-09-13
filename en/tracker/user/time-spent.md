# Registering time spent

In {{ tracker-name }}, you can keep track of the time you spent resolving the issue.

To make sure that the issue statistics is correct, do not enter data on behalf of another employee. It's important that each employee register their time spent themselves.

The time spent is counted in working weeks (5 working days), working days (8 hours), hours, minutes, and seconds.

## Time tracking {#spent-time}

The **{{ ui-key.startrek.blocks-desktop_b-screen.worklog }}** section shows the time planned for and spent on the issue.

Before getting started with an issue, we recommend that you specify the time you're planning to spend on it. When the work is complete, you can compare your preliminary evaluation with the actually spent time.

* **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}**: Time planned for resolving the issue.

* **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}**: You can specify how much time is still required to resolve the issue. Fill it out in the beginning or in the process of working on the issue.

   * If you do not specify the **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}**, whenever you [register time](#add-time-spent), the value in the **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** field will decrease by the registered value.

   * If you specify the **{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }}**, the value in the **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}** field will start decreasing by registered values when the time specified in the original estimate runs out.

* **{{ ui-key.startrek.blocks-desktop_i-ticket-subscription.worklogs }}**: Total time spent on resolving the issue. If you added [several records on the time spent](#add-time-spent), this field will show the total value.

## Registering time spent {#add-time-spent}

To register spent time:

1. Open the issue page.

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_actions-panel_ActionsPanel.action-menu-title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.add-worklog }}**.

1. Select the date of the record creation.

1. Fill in the **{{ ui-key.startrek.ui_components_AddWorklogDialog.duration-label }}** field.

   E.g.:
   * 1 week and 3 days: `1w 3d`, `1w 3d`.
   * 3 hours, 20 minutes, and 30 seconds: `3h 20m 30s`, `3h 20m 30s`.

1. Leave a comment, if needed. The comment will not be visible in the issue but it will be saved in the [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz).

1. Click **{{ ui-key.startrek.ui_components_AddWorklogDialog.apply-button }}**.

{% note info %}

You can add multiple entries. The time entered is summed up.

You can change the saved value only by sending a [request to the API](../concepts/issues/patch-worklog.md).

{% endnote %}

Any user can register their spent time, not only the issue's assignee. The [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz) will show efforts of all users who added their spent time to the issue.

## View time spent {#show-time-spent}

You can see how much time was spent on an issue in the right-hand panel on the issue page, under **{{ ui-key.startrek.blocks-desktop_b-screen.worklog }}**, or in the [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz).

If the issue does not have the **{{ ui-key.startrek.blocks-desktop_b-screen.worklog }}** section, add it as follows:

1. Click ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_IssueSidebar.add-sidebar-field }}** in the right-hand panel.

1. In the **{{ ui-key.startrek-backend.fields.issue.fields.timetracking }}** group, enable **{{ ui-key.startrek-backend.fields.issue.spent-key-value }}** and **{{ ui-key.startrek-backend.fields.issue.estimation-key-value }}**.
