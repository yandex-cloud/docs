# Cloud incident notifications

By default, all cloud owners (users with the ``resource-manager.clouds.owner`` role) are notified of incidents in the cloud.

If you want users to get incident notifications, add them to the list of notification recipients:

{% list tabs %}

- Management console

  1. Open the [Incident notifications]({{ link-cloud-notifications }}) page for the selected cloud. If necessary, [switch to another cloud](switch-cloud.md).

  1. Click **Add**.

  1. Select the user you want to notify of incidents.

     {% note info %}

     You can add users with a [Yandex account](../../../iam/concepts/index.md#passport) and [federated users](../../../iam/concepts/index.md#saml-federation). Federated users should specify their email address in their account settings.

     {% endnote %}

{% endlist %}

