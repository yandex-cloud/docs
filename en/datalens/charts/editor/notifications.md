---
title: Notifications
description: In this article, you will learn about Editor notifications, their limitations, and how to add a notification to a chart.
---

# Notifications


{% include [business-note](../../../_includes/datalens/datalens-functionality-available-business-note.md) %}


Use the Editor's notification mechanism communicate information to the user viewing your chart.

* [Adding a notification to a chart](#add-notification-to-chart)
* [Restrictions](#restrictions)

![notifications](../../../_assets/datalens/editor/notifications.png)

## Adding notification to a chart {#add-notification-to-chart}

To create a notification, use the [Editor.setChartsInsights(args)](./methods.md#set-insights) method on the [Prepare](./tabs.md#prepare) tab.

The notification icon is shown in the top-right corner of the chart next to ![image](../../../_assets/console-icons/ellipsis.svg). Click this icon to see all the notifications that are not hidden. To hide the notification, click **OK**. You will not see the notification for the next two weeks, and then it will reappear. This will not affect its visibility for other users.

The notification icon depends on the notification type: `critical`, `warning`, or `info`. If more than one notification is added to the chart, the icon of the highest priority notification will be shown in collapsed view. For example, if `critical`, `warning`, and `info` level notifications are configured, the `critical` icon will be shown; for `warning` and `info`, the `warning` icon will be shown.

## Limitations {#restrictions}

* You can only add notifications in Editor. The Wizard and QL charts do not support notifications.
* A notification is linked to a specific chart. If you need the same notification for different charts, add it to the [Prepare](./tabs.md#prepare) tab in each chart's code.
* A notification cannot be added for [selectors](./widgets/controls.md).
* You cannot select a specific user to show notifications to: all the users will see it.
* You can only hide a notification for two weeks.
* You can hide a notification only from yourself. This will not affect its visibility for other users.
* You cannot set up a period to repeat a notification.
* You can show a notification for a certain number of times for a specific user.
* The notification sign only shows after the chart is rendered or an error arises. You cannot set up a notification to show up only after an error is received.

#### Example {#notification-example}

[Example of a chart with notifications](https://datalens.yandex/nvkfwnekf9xy9#Editor.%20setChartsInsights(args))
