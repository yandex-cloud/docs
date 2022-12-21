# Creating alerts

To create an alert:

1. Open a **Line chart**. If you don't have a chart like that, [create one](../../visualization-ref/line-chart.md#create-diagram).

   {% note warning %}

   Make sure that there is the `Date` or `Date and time` data along the X-axis.

   {% endnote %}

1. At the top right, click ![image](../../../_assets/datalens/horizontal-ellipsis.svg).
1. Select **Alerts** from the drop-down list.
1. Specify the transfer alert:

   * In the **Basics** section:

      * **Name**. Enter the alert name:
      * **Description**. Sets the description of the alert.
      * **OAuth token**. Specify the OAuth token of the user on whose behalf the data will be requested or click **Get token**.

   * Under **Metrics**:

      * **Y-axis**. Select the axis along which the chart values are plotted.
      * **Series**. Select a measure whose value you want to track.
      * **Alert trigger**. Select the threshold value and the condition to trigger the alert. You can only use absolute values.
      * **Timezone**. Specify the timezone for the time series. You need a timezone so that the service can properly interpret the chart and skip sending expired alerts.

1. Under **Notification channels**, add the recipients of the notification. You can assign Yandex employees or newsletters as recipients.

When an alert triggers, you get an email in your corporate mailbox.
