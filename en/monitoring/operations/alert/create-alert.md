# Creating alerts

To create an [alert](../../concepts/alerting.md):

1. On the {{ monitoring-short-name }} service homepage, click **Create alert**.
1. Specify the main parameters of the alert:

   - **Name**. Enter the name of the alert.
   - **Description**. Specify the notification method.

1. Set the conditions to trigger the alert:

   1. Select the metric to base the alert on.
   1. Set up the main and additional alert parameters:

      - **Alert trigger**.
      - **Aggregation function**.
      - **Evaluation window**.

      For more information, see [{#T}](../../concepts/alerting.md#alert-parameters).

1. Specify the notification channel. If you don't have a notification channel, [create one](create-channel.md).
1. Click **Create alert**. The alert appears in the list.
