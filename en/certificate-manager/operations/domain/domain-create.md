# Create domain

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}

To create a domain:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your domain in.
   1. In the list of services, select **{{ certificate-manager-name }}**.
   1. Go to the **Domains** tab.
   1. Click **Add domain**.
   1. In the window that opens, enter the domain name in the **Domain** field.
   1. (Optional) In the **Description** field, enter a description for the domain.
   1. In the **Certificate** field, select a certificate from the list of verified Let's Encrypt certificates with the appropriate domain name.
   1. Click **Create**.

   A new domain appears in the list of domains.

{% endlist %}
