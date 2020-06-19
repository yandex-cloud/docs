# Renew a certificate

{{ certificate-manager-name }} doesn't manage user certificates. To make your certificate continuously available to your resources, be sure to renew it on time.

To get a new version of a user certificate:

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder to delete a certificate from.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Select the certificate you want to renew in the list.
    1. In the window that opens, click **Renew certificate**.
    1. In the window that opens, click **Add certificate**  in the **Certificate** field.
        1. Select how to add your certificate: **File** or **Text**.
        1. Click **Add**.
    1. In the **Intermediate certificate chain** field, click **Add chain**.
        1. Select how to add your certificate: **File** or **Text**.
        1. Click **Add**.
    1. In the **Private key** field, click **Add private key**.
        1. Select how to add your certificate: **File** or **Text**.
        1. Click **Add**.
    1. Click **Create**.

{% endlist %}

