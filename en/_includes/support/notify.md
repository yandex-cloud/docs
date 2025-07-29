# Notifications from {{ yandex-cloud }}

{{ yandex-cloud }} technical support notifies you of events that affect all {{ yandex-cloud }} users or your account specifically. To additionally receive notifications about your resources, subscribe to **{{ ui-key.yacloud.iam.folder.switch_service-notifications }}** in your [cloud](../../resource-manager/operations/cloud/notify.md) or [folder](../../resource-manager/operations/folder/notify.md).

## Notification types {#notifications}

You can receive notifications for the [entire cloud](#cloud-notifications) or [individual folders](#folder-notifications).

### Cloud notifications {#cloud-notifications}

By default, notifications about upcoming maintenance and notifications from services in the cloud are sent to all cloud owners, i.e., users with the `{{ roles-cloud-owner }}` role. Organization owners (`{{ roles-organization-owner }}`) do not receive any notifications about their organization's clouds by default. They should subscribe to such notifications themselves. You can add cloud notification recipients in [Service notifications]({{ link-cloud-notifications }}).

{% note info %}

You can add users with a [Yandex account](../../iam/concepts/users/accounts.md#passport) as well as [federated users](../../iam/concepts/users/accounts.md#saml-federation). Federated users should specify their email address in their account settings.

{% endnote %}

Cloud notifications contain the following information:

* Cloud ID and name
* Folder ID and name
* Resource ID and name

Cloud notifications are only sent to cloud subscribers. Users subscribed to folder notifications do not receive notifications for the parent cloud.

### Folder notifications {#folder-notifications}

By default, notifications about folder resources are sent to users subscribed to parent cloud notifications and cloud owners (`{{ roles-cloud-owner }}`). Organization owners (`{{ roles-organization-owner }}`) do not receive any notifications about their organization's cloud folders by default. They should subscribe to such notifications themselves. You can add folder notification recipients in the [folder settings](../../resource-manager/operations/folder/notify.md).

Folder notifications include information about the following resources:

* Virtual machines (VM ID)
* Virtual disks (disk ID)
* MDB clusters (cluster ID)

Folder notifications are sent to both folder subscribers and parent cloud subscribers. Please note that it is not possible to identify the folder for some types of resources. Therefore, we recommend subscribing important recipients to cloud notifications.
  
### Scheduled maintenance {#technical}

Some {{ yandex-cloud }} maintenance operations may affect the performance or availability of your resources. Technical support sends notification of such activities 3 calendar days in advance by email, indicating:

* Date and time of maintenance.
* Category of maintenance.
* {{ yandex-cloud }} services affected.
* Description of relevant changes to the services.
* Tips on how to reduce the impact of maintenance on your resources (if possible).

### Infrastructure failure {#infra}

If there is a {{ yandex-cloud }} failure that can potentially affect the security or availability of your data, our support team will notify you by email as soon as the scope and impact of the problem are identified. Failure notifications will be sent to the subscribers of the folder hosting the affected resource.

Our support team does not send notifications about platform incidents. You can check the availability of services on the platform component status [page](https://status.cloud.yandex.ru/dashboard) or follow the announcements in our [Telegram channel](https://t.me/yandexcloudalerts).

### Information security incident {#security}

If there is an event in the {{ yandex-cloud }} infrastructure that has resulted in your data being compromised, technical support will notify you by email within 24 hours after the damage is detected. The email will be sent to the cloud owner, the Data Protection Officer (DPO) (if this role has been assigned for your cloud), and the users added in [Service notifications]({{ link-cloud-notifications }}).

## Notification methods {#notification-settings}

To configure notification methods:

1. In the bottom left corner of the [management console]({{ link-console-main }}) or [{{ support-center-name }}]({{ link-console-support }}), click ![image](../../_assets/console-icons/gear.svg) **Settings** and go to the **{{ ui-key.yacloud_components.settings.label_title_communications }}** tab.
1. Under **{{ ui-key.yacloud_components.settings.section_transports }}**, configure notification channels.

    You can receive notifications via email, text messages, or Telegram bot.
1. Under **{{ ui-key.yacloud_components.settings.section_settings }}**, select the types of notifications to send and channels for receiving them:
    * ![image](../../_assets/console-icons/at.svg): Email.
    * ![image](../../_assets/console-icons/smartphone.svg): Text message.
    * ![image](../../_assets/console-icons/logo-telegram.svg): Telegram bot message.
    * ![image](../../_assets/console-icons/handset.svg): Phone call to the specified number (only available for {{ monitoring-name }} escalations).
    * ![image](../../_assets/console-icons/antenna-signal.svg): Messages to specified URLs.

## Webhooks {#webhook}

You can configure auto-sending of messages to specified URLs upon certain events in your cloud services. Currently, webhooks for **{{ ui-key.yacloud_components.settings.label_tech-name }}** and **{{ ui-key.yacloud_components.settings.label_monitoring-name }}** event types are supported. You can use your on-premise messengers, such as Rocket.Chat, Mattermost, Jabber, and Slack, as message handlers. Webhooks allow you to tailor your notification system to your business processes and integrate your infrastructure in {{ yandex-cloud }} more flexibly, with monitoring and management systems already configured.

To configure webhooks:

1. In the bottom left corner of the [management console]({{ link-console-main }}) or [{{ support-center-name }}]({{ link-console-support }}), click ![image](../../_assets/console-icons/gear.svg) **Settings** and go to the **{{ ui-key.yacloud_components.settings.label_title_communications }}** tab.
1. Click **{{ ui-key.yacloud_components.settings.button_add-empty }}** in the **{{ ui-key.yacloud_components.settings.label_add-empty-webhookOutgoing }}** section under **{{ ui-key.yacloud_components.settings.section_transports }}**.
1. In the window that opens, specify the webhook name and URL, then click **{{ ui-key.yacloud_components.settings.button_send-code }}**.
1. After the webhook receives the code in `your confirmation code <code>` format, enter it in the [management console]({{ link-console-main }}) or [{{ support-center-name }}]({{ link-console-support }}) confirmation window. 
After confirmation, the URL and specified webhook name will be displayed in the **{{ ui-key.yacloud_components.settings.section_transports }}** section.