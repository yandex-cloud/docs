# Registering time spent

In {{ tracker-name }}, you can keep track of the time you spent resolving the issue.

To make sure that the issue statistics is correct, do not enter data on behalf of another employee. It's important that each employee register their time spent themselves.

The time spent is counted in working weeks (5 working days), working days (8 hours), hours, minutes, and seconds.

## Time tracking {#spent-time}

The **Time spent** section shows the time planned and spend on the issue.

Before getting started with an issue, we recommend that you specify the time you're planning to spend on it. When the work is complete, you can compare your preliminary evaluation with the actually spent time.

* **Original Estimate**: The time planned to spend on the issue execution.

* **Estimate**: You can specify the time left to be spent on resolving the issue. Fill it out in the beginning or in the process of working on the issue.

   * If you don't specify time in the **Original Estimate** field, whenever you [register time](#add-time-spent), the value in the **Estimate** field will decrease by the registered value.

   * If you specify time in the **Original Estimate** field, the value in the **Estimate** field will start decreasing by registered values after you spend more time on the issue than the original estimate.

* **Time Spent**: The total time spent to resolve the issue. If you added [several records on the time spent](#add-time-spent), this field will show the total value.

## Registering time spent {#add-time-spent}

To register spent time:

1. Open the issue page.

1. In the upper-right corner, select **Actions** → **Add time spent**.

1. Select the date of the record creation.

1. Fill in the **Time spent** field.

   E.g.:
   * 1 week and 3 days: `1w 3d`, `1w 3d`.
   * 3 hours, 20 minutes, and 30 seconds: `3h 20m 30s`, `3h 20m 30s`.

1. If necessary, leave a comment. The comment won't be visible in the issue, but it will be saved in the [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz).

1. Click **Save**.

{% note info %}

You can add multiple entries. The time entered is summed up.

You can change the saved value only by sending a [request to the API](../concepts/issues/patch-worklog.md).

{% endnote %}

Any user can register their spent time, not only the issue's assignee. The [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz) will show efforts of all users who added their spent time to the issue.

## View time spent {#show-time-spent}

You can view the time spent on an issue under **Time spent** in the right panel on the issue page or in the [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz).

If the issue doesn't show the **Time spent** section, add it:

1. Click **![](../../_assets/tracker/svg/add-filter.svg) Edit parameter list** on the right panel.

1. Under **Time spent**, enable the **Time spent** and **Estimate** options.
