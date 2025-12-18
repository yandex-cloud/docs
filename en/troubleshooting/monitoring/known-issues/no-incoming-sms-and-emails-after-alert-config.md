# You set up a notification channel in {{ monitoring-name }}, but you do not receive any event notifications


## Issue description {#issue-description}

You have configured alerts in {{ monitoring-name }} using the **{{ ui-key.yacloud_monitoring.alert.method_sms }}** or **{{ ui-key.yacloud_monitoring.alert.method_email }}** notification method; however, when an alert triggers, you do not get notified on the phone number or at the email specified in the channel settings.

## Solution {#issue-resolution}

This could happen for multiple reasons:

1. Notification contacts are missing.

    Go to [**Settings**]({{ link-console-settings }}) in the [management console]({{ link-console-main }}) and double-check your account's email address and phone number under **{{ ui-key.yacloud.component.navigation-menu.label_notifications }}**. In the **{{ ui-key.yacloud_components.settings.section_phone }}** and **{{ ui-key.yacloud_components.settings.section_email }}** sections, ensure **{{ ui-key.yacloud_components.settings.label_alerting-name }}** is enabled:
    ![add-a-phone-number-in-settings](../../../_assets/troubleshooting/monitoring/add-a-phone-number-in-settings.png)

    For more information, see [**Alerts/notifications**](../../../monitoring/qa/alerts.md#alert-receive-failed) in the {{ monitoring-name }} section.

1. You specified an incorrect or invalid email address in your Yandex ID profile or federated account.

1. The limit of 50 text messages per day sent to a single phone number has been exceeded, this is why the alert has not been sent to such a number.

    To learn about limits in Yandex Monitoring, see [**Quotas and limits**](../../../monitoring/concepts/limits.md#monitoring-alerting-limits) in the respective section.

1. Messages were filtered as spam or failed to deliver.

    Check your **Spam** messages, as well as the blacklisted numbers. To receive notifications, disable your antispam filter if you are using it. You may also want to delete old messages and restart your device. If the issue persists, request inbound SMS itemization from your mobile network provider.

1. Insufficient permissions on the account.

    To receive monitoring notifications, your user account must have at least viewer-level access to metrics in {{ monitoring-name }}. Specifically, the account needs the `{{ roles-monitoring-viewer }}` role assigned to the folder where the notification channel is configured. 
    
    For a full list of roles, see [**Access management in {{ monitoring-name }}**](../../../monitoring/security/index.md#monitoring-viewer).