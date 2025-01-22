# Adding an alert for a certificate

You can add alerts about a certificate's expiration or failure.

## Adding an alert about upcoming certificate expiration {#expired}

To create an alert:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create an alert in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. On the home page, click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
   1. Specify the main parameters of the alert:
      * **{{ ui-key.yacloud.common.name }}**. Enter a name for the channel.
      * **{{ ui-key.yacloud.common.description }}**. Specify the notification method.
   1. Set the conditions to trigger the alert:
      1. Select the metric to base the alert on:
         * `service = Certificate Manager`
         * `name = certificate.days_until_expiration`
         * `certificate = *`. To monitor a specific certificate, specify its ID.
         * (Optional) If you choose multiple certificates, use the `series_min()` function that selects the minimum value.
      1. Set up the main and additional alert parameters:
         * **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**. The condition is less than or equal to. The number of days for **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** is `4` and for **{{ ui-key.yacloud_monitoring.alert.status_warn }}**, `14`.
         * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**.
         * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**.

         
         For more information, see [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


      1. Specify the notification channel. If you do not have a notification channel, [create one](../../monitoring/operations/alert/create-channel.md).
      1. Click **{{ ui-key.yacloud.common.create }}**. Your alert will appear in the list.

{% endlist %}

## Adding an alert about a faulty certificate {#inoperable}

To create an alert:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create an alert in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
   1. On the home page, click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
   1. Specify the main parameters of the alert:
      * **{{ ui-key.yacloud.common.name }}**. Enter a name for the channel.
      * **{{ ui-key.yacloud.common.description }}**. Specify the notification method.
   1. Set the conditions to trigger the alert:
      1. Select the metric to base the alert on:
         * `service = Certificate Manager`
         * `name = certificate.is_out_of_order`
         * `certificate = *`. To monitor a specific certificate, specify its ID.
         * (Optional) If you choose multiple certificates, use the `series_sum()` function that calculates the sum of values.
      1. Set up the main and additional alert parameters:
         * **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**. The condition is more than. The number of faulty certificates for **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** is `0`.
         * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**.
         * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**.

         
         For more information, see [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


      1. Specify the notification channel. If you do not have a notification channel, [create one](../../monitoring/operations/alert/create-channel.md).
      1. Click **{{ ui-key.yacloud.common.create }}**. Your alert will appear in the list.

{% endlist %}