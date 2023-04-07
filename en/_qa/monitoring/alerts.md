# Alerts/notifications

#### How can I reduce the number of false alerts? {#reduce-false-alerts}

You can increase the [evaluation window](../../monitoring/concepts/alerting.md#evaluation-window) or change the [aggregation function](../../monitoring/concepts/alerting.md#aggregation) in the [alert](../../monitoring/concepts/alerting.md#alert) parameters.

#### What value should I specify in a threshold? {#threshold-values}

The threshold value is set in the units of the selected metric.

For example, the value of a database cluster's free disk space threshold is specified in bytes. It is convenient to set a threshold by moving the slider on the chart with real data. Make sure the threshold value for a **Warning** does not exceed that for an **Alarm**.


#### How do I set an alert recipient? {#alert-recipient}

In the [notification channel](../../monitoring/concepts/alerting.md#channel-parameters), the following methods are supported:
* email.
* SMS.
* push notifications in the [mobile app](../../overview/mobile-app/index.md) {{ yandex-cloud }}.

Specify a {{ yandex-cloud }} account as the recipient of email notifications. This can be the owner's account or an [additional account](https://yandex.ru/support/id/authorization/lite.html) created specifically for this purpose.


If the SMS method is selected, the phone number must be linked to the account.



#### A user doesn't receive alerts. Why? {#alert-receive-failed}

Check the mailbox and phone number settings in the user's account [notification channel](../../monitoring/concepts/alerting.md#channel-parameters).

Check the management console [settings]({{ link-console-main }}/settings). Make sure the `Monitoring` option is enabled in the **Phone number settings** and **Email settings** sections.
