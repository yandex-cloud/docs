# Notifications

To provide this information to the user that views your chart, use the notification mechanics in ChartEditor.

* [{#T}](#add-notification-to-chart)
* [{#T}](#restrictions)

## Adding notification to a chart {#add-notification-to-chart}

To create a notification, use the method `ChartEditor.setChartsInsights` in the [JavaScript](architecture.md#js) tab in the following format:

```js
ChartEditor.setChartsInsights([
    {
        title: 'Title',
        message: 'list for example\n- раз\n- два\n- три',
        level: 'critical',
        locator: '1'
    },
    {
        title: 'Lorem Ipsum',
        message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        level: 'info',
        locator: '2'
    }
])
```

The `setChartsInsights` method accepts an array of objects. All fields are required

* `title`: The notification title.
* `message` is a text of notification in [Markdown](https://datalens.yandex-team.ru/docs/editor/widgets/markdown/).
* `level`: The notification type. Possible options: `info` , `warning` , `critical`. The type of notification determines its priority and icon shown.  If more than one notification is added to the chart, the icon of only one notification is shown in the collapsed view.
* `locator` is a unique ID for each notification in a chart.

The notification icon is shown in the upper-right corner of the chart, next to the ![image](../../_assets/datalens/horizontal-ellipsis.svg) icon. Click this icon to see all the notifications that aren't hidden. To hide the notification, click **OK**. You won't see the notification for the next two weeks, and then it will reappear. This won't affect visibility of the notification for other users.

The notification icon depends on the notification type: `critical`, `warning`, and `info`.
If more than one notification is added to the chart, the icon of the notification having the highest priority is shown in the collapsed view. For example, if you have notifications at the `critical`, `warning`, or `info` level, you'll see the `critical` icon, if at the `warning` or `info` level, you'll see the `warning` icon.

## Limitations {#restrictions}

* You can only add notifications in ChartEditor. The Wizard and QL charts don't support notifications.
* A notification is linked to some chart. If you need to place the same notification in different charts, add it to the [JavaScript](architecture.md#js) tab in the code of such charts.
* You can't select a specific user to show notifications to: all the users will see it.
* You can only hide a notification for two weeks.
* A user can only hide a notification from themselves. This won't affect its visibility for other users.
* You can't set up a period to repeat a notification.
* You can show a notification for a certain number of times for a specific user.
* The notification sign only shows after the chart is rendered or an error arises. You can't set up a notification to show up only after an error is received.

#### Example {#notification-example}

[Example of a chart with a notification](https://datalens.yandex-team.ru/editor/94re1oq1wqdi1-primer-charta-s-uvedomleniem-2).
