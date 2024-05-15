# Getting notifications from services in a cloud

By default, cloud owners (all users with the `{{ roles-cloud-owner }}` role) get notifications in the cloud.

If you want users to get notifications from services, add them to the list of users subscribed to notifications:

{% list tabs group=instructions %}

- Management console {#console}

   1. Open the [Service notifications]({{ link-cloud-notifications }}) page for the selected cloud. If necessary, [switch to another cloud](switch-cloud.md).
   1. Click **{{ ui-key.yacloud.iam.cloud.incident-notifications.button_open-dialog }}**.
   1. In the **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_subscribers-dialog-header }}** window that opens, select:

      1. Users you want to subscribe to notifications.

         {% note info %}

         You can add users with a [Yandex account](../../../iam/concepts/users/accounts.md#passport) as well as [federated users](../../../iam/concepts/users/accounts.md#saml-federation). Federated users should specify their email address in their account settings.

         {% endnote %}

      1. Services to send notifications to the users.
      1. Methods for delivering notifications to the selected users.

         {% note warning %}

         Email address, phone number, and Telegram channel to receive the messages can be specified in the [notification settings]({{ link-cloud-communications }}).

         {% endnote %}

   1. Click **{{ ui-key.yacloud.common.add }}**.

- API {#api}

   Currently, you cannot add users to the list of notification subscribers using the API.

{% endlist %}
