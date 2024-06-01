---
title: "How to set up work schedules"
description: "Follow this guide to set up work schedules."
---

# Work schedule

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

Work schedules allow you to set up the timeframe for when the [SLA rule](sla.md) applies. Outside the working hours, the SLA timer will be idle. You can select a standard schedule for the rule or create a custom schedule.

{% note info %}

In the **Round the clock** system schedule, holidays are considered non-working days, and the SLA timer is idle on these days.

{% endnote %}


## Creating work schedules {#section_rlk_hkg_x2b}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Select **SLA rules**.

1. In any SLA rule or form for creating a new SLA rule, click **Work schedule** ![](../../_assets/console-icons/arrow-up-right-from-square.svg). This will redirect you to the old {{ tracker-name }} interface. Click **Create schedule**.

1. Click the ![](../../_assets/tracker/icon-edit.png) icon and name the schedule. Click ![](../../_assets/tracker/approve-checkmark.png) to save the name.

1. Select the time zone.

1. Set a schedule.

1. Select **Holidays and transferred holiday days** that will be different from the main work schedule. To do this, click **Manage exceptions** and set the following parameters:

   - Select the country to choose the occupational calendar of your region.

   - Add **SLA exceptions** if your work schedule differs from the official calendar.

1. Click **Save**.

You can view the schedule you created in the **My schedules** section. Other users will not be able to view or use your schedule.

## Editing work schedules {#section_vkm_flh_x2b}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. In the top-right corner, click ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Select **SLA rules**.

1. In any SLA rule or form for creating a new SLA rule, click **Work schedule** ![](../../_assets/console-icons/arrow-up-right-from-square.svg). This will redirect you to the old {{ tracker-name }} interface.

1. Under **My schedules**, click the name of the schedule you need.

1. Click ![](../../_assets/tracker/svg/icon-edit1.svg) **Edit**.

1. Make your changes and click **Save**.


