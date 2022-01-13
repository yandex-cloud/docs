# Registering time spent

{{ tracker-name }} can keep a record of the time you spent on an issue.

To make sure issue statistics are correct, do not enter any data for another employee. It's important that each assignee register the time spent themselves.

## Time tracking {#section_y1t_gkh_vcb}

To register the time spent:

1. Open the issue page.

1. Select **Actions** → **Add time spent**.

1. Fill in the **Time spent** field. Time is tracked in business weeks (5 work days), business hours (8 hours), hours, minutes, and seconds. For example:

   * 1 week and 3 days: `1w 3d`, `1w 3d`.
   * 3 hours, 20 minutes, and 30 seconds: `3h 20m 30s`, `3h 20m 30s`.

1. If necessary, enter the start time and leave a comment. The comment won't be visible in the issue, but it will be saved in the [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz).

1. Click **Save**.

{% note info  %}

You can't change the value saved. You can add multiple entries. The time entered is summed up.

{% endnote %}

Any user can record the time spent, not just the issue assignee. The [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz) will show the time spent by all users who added time to the issue.

## Viewing time spent {#section_cqc_hkh_vcb}

You can view the time spent on an issue in the **Time spent** field.

Use the **Estimate** field to specify the time left to spend on resolving the issue. Fill it in when you begin working on the issue. Each time you record the time spent, the estimation will decrease by the amount you enter. Time is tracked in business weeks (5 work days), business hours (8 hours), hours, minutes, and seconds.

{% list tabs %}

- Web interface

  You can view the time spent on an issue under **Time spent** on the right panel or in the [Time Spent Report](../manager/statistics.md#section_uxt_3ft_xz).

  If the **Time spent** section is not displayed in the issue details, add it:

  1. Click ![](../../_assets/tracker/task-params-btn.png) **Select fields** on the issue details panel.

  1. Under **Time spent**, enable the **Time spent** and **Estimate** options.

- Mobile app

  To view the amount of time you spent on a issue, go to the **Parameters** tab on the issue page. The time spent is displayed under **Time spent**.

  To edit your issue estimate, to the right of the **Estimate** field, tap ![](../../_assets/tracker/mobile-edit-param.png). Enter a new value and tap **Save**.

  {% note info  %}

  If there is no **Time spent** section, go to the web interface and add the **Time spent** and **Estimate** fields on the right panel by tapping ![](../../_assets/tracker/task-params-btn.png) **Select fields**.

  {% endnote %}

{% endlist %}

