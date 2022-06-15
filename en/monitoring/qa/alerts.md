# Alerts/notifications

#### How can I reduce the number of false alerts? {#reduce-false-alerts}

You can increase the [evaluation window](../concepts/alerting.md#evaluation-window) or change the [aggregation function](../concepts/alerting.md#aggregation) in the [alert](../concepts/alerting.md#alert) parameters.

#### What value should I specify in a threshold? {#threshold-values}

The threshold value is set in the units of the selected metric.

For example, the value of a database cluster's free disk space threshold is specified in bytes. It is convenient to set a threshold by moving the slider on the chart with real data. Make sure the threshold value for a **Warning** does not exceed that for an **Alarm**.


#### How do I set an alert recipient? {#alert-recipient}

In the [notification channel](../concepts/alerting.md#channel-parameters), {% if product == "cloud-il" %}notifications can only be sent by email.{% endif %}{% if product == "yandex-cloud" %}the following methods are supported:
* Email.
* SMS.
* Push notifications in the {{ yandex-cloud }} [mobile app](../../overview/mobile-app/index.md).{% endif %}

Specify a {{ yandex-cloud }} account as the recipient of email notifications.{% if product == "yandex-cloud" %} This can be the owner's account or an [additional account](https://yandex.ru/support/id/authorization/lite.html) created specifically for this purpose.{% endif %}

{% if product == "yandex-cloud" %}

If the SMS method is selected, the phone number must be linked to the account.


{% endif %}

#### A user doesn't receive alerts. Why? {#alert-receive-failed}

Check the mailbox and phone number settings in the user's account in the [notification channel](../concepts/alerting.md#channel-parameters).

Check the management console [settings]({{ link-console-main }}/settings). Make sure the `Monitoring` option is enabled in the **Phone number settings** and **Email settings sections**.
