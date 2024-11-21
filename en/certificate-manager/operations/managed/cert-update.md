# Renew a certificate

{{ certificate-manager-name }} initiates the certificate renewal procedure 30 days before it expires. The certificate status will change to `Renewing`.

{% note info %}

In some cases, certificates can be renewed without any user action. For more information, see [Checking rights automatically](../../concepts/challenges.md#auto).

{% endnote %}

To update a Let's Encrypt certificate:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder the certificate was added to.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. In the list, select the certificate with the `Renewing` status you need to update.
    1. In the window that opens, you will find the info you will need to pass the rights check under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**. For more information, see [{#T}](../../concepts/challenges.md).
    1. As soon as the domain rights check is passed, the check status under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** will change to `Valid`.
    1. After the check status for all the domains changes to `Valid`, the certificate will be issued and its status will change to `Issued`.

- API {#api}

    To renew a certificate, use the [update](../../api-ref/Certificate/update.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Update](../../api-ref/grpc/Certificate/update.md) gRPC API call.

{% endlist %}

{% note info %}

{% include [checking-domain-rights-cname](../../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}