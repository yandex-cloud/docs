# Cloud incident notifications

By default, all cloud owners (users with the `resource-manager.clouds.owner` role) are notified of incidents in the cloud.

If you want users to get incident notifications, add them to the list of notification recipients:

{% list tabs %}

- Management console

   1. Go to the [Incident notifications]({{ link-cloud-notifications }}) page for the selected cloud. {% if product == "yandex-cloud" %}If necessary, [switch to another cloud](switch-cloud.md).{% endif %}
   1. Click **Add**.
   1. Select the user you want to notify of incidents and click **Add**.

      {% note info %}

      You can add users with a {% if product == "yandex-cloud" %}[Yandex account](../../../iam/concepts/index.md#passport){% endif %}{% if product == "cloud-il" %}[Google account](../../../iam/concepts/index.md#passport){% endif %} as well as [federated users](../../../iam/concepts/index.md#saml-federation). Federated users should specify their email address in their account settings.

      {% endnote %}

{% endlist %}
