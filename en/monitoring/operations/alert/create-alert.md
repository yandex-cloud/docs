# Creating alerts

1. On the {{ monitoring-short-name }} service homepage, click **Create alert**.
1. Specify the main parameters of the alert:

   * **Name**: Enter the name of the alert.
   * **Description**: Describe the purpose of the alert.

1. Set the conditions to trigger the alert:

   1. Select the metric to base the alert on.
   1. Configure the alert parameters:

      * **Test query**
      * **Aggregation function**
      * **Alert trigger**
      * **Alert trigger thresholds**
      * **Evaluation window**
      * **Evaluation delay**

      For more information, see [{#T}](../../concepts/alerting/alert.md#condition).
   1. Specify alert [annotations](../../concepts/alerting/annotation.md).
   1. Set the [no data policies](../../concepts/alerting/alert.md#no-data-policy) or leave the default values.

1. Specify the notification channel. If you do not have a notification channel, [create one](create-channel.md).
1. Click **Create alert**. Your alert will appear in the list.
