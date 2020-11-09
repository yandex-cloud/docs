# Link a certificate to a domain

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}

To confirm your rights to a domain, link to it a [Let's Encrypt certificate](../../concepts/managed-certificate.md).

A certificate linked to the domain is used to provide a TLS connection in [integrated cloud services](../../concepts/domains/services.md).

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder where the domain was created.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Go to the **Domains** tab.
    1. In the list, select the domain to link a new certificate to.
    1. In the window that opens, click **Bind certificate**.
    1. In the window that opens, select a certificate from the list of verified Let's Encrypt<sup>®</sup> certificates with the appropriate domain name.
    1. Click **Save**.

{% endlist %}

