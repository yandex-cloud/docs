# Create a user certificate

To create a user certificate:

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder to delete a certificate from.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Click **Add certificate**.
    1. In the menu that opens, select **User certificate**.
    1. In the window that opens, enter the name of the certificate in the **Name** field.
    1. (optional) In the **Description** field, enter a description for the certificate.
    1. In the **Certificate** field, click **Add certificate**.
        1. Select how to add your certificate: **File** or **Text**.
        1. Click **Add**.
    1. In the **Intermediate certificate chain** field, click **Add chain**.
        1. Select how to add your certificate: **File** or **Text**.
        1. Click **Add**.
    1. In the **Private key** field, click **Add private key**.
        1. Select how to add your certificate: **File** or **Text**.
        1. Click **Add**.
    1. Click **Create**.

    A new certificate with the `Issued` status appears in the certificate list.

{% endlist %}

