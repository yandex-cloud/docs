# Getting notifications from services in a folder

Users specified under **Service notifications** in the folder settings get notifications from services for specific cloud folders.

To add a user to the list of notification recipients:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![image](../../../_assets/console-icons/chevron-down.svg) in the top panel and select the folder. You can [switch to another cloud](../cloud/switch-cloud.md), if required.
  1. Navigate to the **{{ ui-key.yacloud.iam.folder.switch_service-notifications }}** tab.
  1. Click **{{ ui-key.yacloud.iam.cloud.incident-notifications.button_open-dialog }}**.
  1. In the **{{ ui-key.yacloud_components.notify-subs.label_subscribers-dialog-header }}** window that opens, select:

     1. Users you want to subscribe to notifications.

        {% note info %}

        You can add [Yandex account](../../../iam/concepts/users/accounts.md#passport) users, [federated](../../../iam/concepts/users/accounts.md#saml-federation) and [local](../../../iam/concepts/users/accounts.md#local) users. Federated and local users must specify their email address in their account profile.

        {% endnote %}

     1. Services to send notifications to the users.
     1. Methods for delivering notifications to the selected users.

        {% note warning %}

        To specify the email address, phone number, and Telegram channel for receiving messages, use the [notification settings]({{ link-cloud-communications }}).

        {% endnote %}

  1. Click **{{ ui-key.yacloud.common.add }}**.

  In the folder **{{ ui-key.yacloud.iam.folder.switch_service-notifications }}** section, you can see the users subscribed to the folder notifications by default, because they are subscribed to the parent cloud's notifications. To do this, enable **{{ ui-key.yacloud_components.notify-subs.label_inherited-subscribers }}**.

- API {#api}

  Currently, you cannot add users to the list of notification recipients using the API.

{% endlist %}
