# Create a Let's Encrypt certificate

To create a new Let's Encrypt<sup>®</sup> certificate:

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder to delete a certificate from.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Click **Add certificate**.
    1. In the menu that opens, select **Let's Encrypt certificate**.
    1. In the window that opens, enter the name of the certificate in the **Name** field.
    1. (optional) In the **Description** field, enter a description for the certificate.
    1. In the **Domains** field, enter the list of domains to create a certificate for.
    1. Select the [type of domain rights check](../../concepts/challenges) `HTTP` or `DNS`.
    1. Click **Create**.

    The new certificate now appears in the certificate list with the `Validating` status. This status means that a Let's Encrypt certificate was requested and you need to pass the [domain rights check](cert-validate.md) to process it.

{% endlist %}

