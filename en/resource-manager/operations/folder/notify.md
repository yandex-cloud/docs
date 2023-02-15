# Getting notifications from services in a folder

Users specified under **Service notifications** in the folder settings get notifications from services for specific cloud folders. The folder owners don't receive any notifications by default. They should subscribe to notifications themselves.

To add a user to the list of notification recipients:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-cloud }}), select the folder to configure. If necessary, [switch to another cloud](../cloud/switch-cloud.md).
   1. Go to the **Service notifications** tab.
   1. Click **Add**.
   1. Select the user you want to subscribe to notifications and click **Add**.

      {% note info %}

      You can add users with a [{% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account](../../../iam/concepts/index.md#passport) as well as [federated users](../../../iam/concepts/index.md#saml-federation). Federated users should specify their email address in their account settings.

      {% endnote %}

{% endlist %}

In the folder **Service notifications** section, you can see the users subscribed to notifications from the default folder, since they are linked to the folder parent resources.
