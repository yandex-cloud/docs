# Creating a domain

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}

To create a domain:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your domain in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. In the left-hand panel, select ![image](../../../_assets/certificate-manager/domains.svg) **{{ ui-key.yacloud.certificate-manager.label_domains }}**.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. In the window that opens, enter the domain name in the **{{ ui-key.yacloud.certificate-manager.domain.form.field_domain }}** field.
   1. (Optional) In the **{{ ui-key.yacloud.common.description }}** field, enter a description for the domain.
   1. In the **{{ ui-key.yacloud.certificate-manager.domain.form.field_certificate }}** field, select a certificate from the list of verified Let's Encrypt certificates with the appropriate domain name.
   1. Click **{{ ui-key.yacloud.common.create }}**.

   A new domain will appear in the list of domains.

{% endlist %}
