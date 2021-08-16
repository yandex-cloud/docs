# Adding alerts for certificates

You can add alerts about a certificate's expiration or failure.

## Adding an alert about the upcoming certificate expiration {#expired}

{% list tabs %}

- Management console

    To create an alert:

    1. In the [management console]({{ link-console-main }}), select the folder to create an alert in.

    1. In the list of services, select **{{ monitoring-full-name }}**.

    1. On the service homepage, click **Create alert**.

    1. Specify the main parameters of the alert:
        - **Name**. Enter a name for the channel.
        - **Description**. Specify the notification method.

    1. Set the conditions to trigger the alert:

        1. Select the metric to base the alert on.
            - `service = Certificate Manager`
            - `name = certificate.days_until_expiration`
            - `certificate = *`. To monitor a specific certificate, specify its ID.
            - (optional) If you choose multiple certificates, use the `series_min()` function that selects the minimum value.

        1. Set up the main and additional alert parameters:
            - **Alert trigger**. The condition is less than or equal to. The number of days for **Alarm** is `4` and for **Warning** is `14`.
            - **Aggregation function**.
            - **Evaluation window**.

            For more information, see [{#T}](../../monitoring/concepts/alerting.md#alert-parameters).

        1. Specify the notification channel. If you don't have a notification channel, [create one](../../monitoring/operations/alert/create-channel.md).

        1. Click **Create alert**. The alert appears in the list.

{% endlist %}

## Adding an alert about a faulty certificate {#inoperable}

{% list tabs %}

- Management console

    To create an alert:

    1. In the [management console]({{ link-console-main }}), select the folder to create an alert in.

    1. In the list of services, select **{{ monitoring-full-name }}**.

    1. On the service homepage, click **Create alert**.

    1. Specify the main parameters of the alert:
        - **Name**. Enter a name for the channel.
        - **Description**. Specify the notification method.

    1. Set the conditions to trigger the alert:

        1. Select the metric to base the alert on.
            - `service = Certificate Manager`
            - `name = certificate.is_out_of_order`
            - `certificate = *`. To monitor a specific certificate, specify its ID.
            - (optional) If you choose multiple certificates, use the `series_sum()` function that calculates the sum of values.

        1. Set up the main and additional alert parameters:
            - **Alert trigger**. The condition is larger than. The number of faulty certificates for **Alarm** is `0`.
            - **Aggregation function**.
            - **Evaluation window**.

            For more information, see [{#T}](../../monitoring/concepts/alerting.md#alert-parameters).

        1. Specify the notification channel. If you don't have a notification channel, [create one](../../monitoring/operations/alert/create-channel.md).

        1. Click **Create alert**. The alert appears in the list.

{% endlist %}

