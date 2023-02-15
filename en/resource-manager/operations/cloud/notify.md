# Getting notifications from services in a cloud

By default, cloud owners (all users with the `resource-manager.clouds.owner` role) get notifications in the cloud.

If you want users to get notifications from services, add them to the list of subscribers to notifications:

{% list tabs %}

- Management console

   1. Open the [Service notifications]({{ link-cloud-notifications }}) page for the selected cloud.{% if product == "yandex-cloud" %} If necessary, [switch to another cloud](switch-cloud.md).{% endif %}
   1. Click **Add**.
   1. Select the user you want to subscribe to notifications and click **Add**.

      {% note info %}

      You can add users with a [{% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account](../../../iam/concepts/index.md#passport) as well as [federated users](../../../iam/concepts/index.md#saml-federation). Federated users should specify their email address in their account settings.

      {% endnote %}

{% endlist %}
