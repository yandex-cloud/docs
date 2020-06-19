# Check rights for domains

To check rights for domains:

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), select the folder to delete a certificate from.
    1. In the list of services, select **{{ certificate-manager-name }}**.
    1. Select the certificate to check from the list and click it.
    1. In the window that opens, the details you need to pass the domain rights check can be found under **Check rights for domains**. For more information, see [{#T}](../../concepts/challenges.md).
    1. When the domain rights check is passed, the domain check status under **Check rights for domain** changes to `Valid`.
    1. After the rights check status for all your domains changes to `Valid`, the certificate is issued and its status becomes `Issued`.

{% endlist %}

