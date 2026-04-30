# Renewing a certificate

{{ certificate-manager-name }} initiates a certificate renewal 30 days prior to its expiration. The certificate status will change to `Renewing`.

{% note info %}

In some cases, a certificate renewal requires no user input. For more information, see [Checking rights automatically](../../concepts/challenges.md#auto). 

{% endnote %}

To renew a Let's Encrypt certificate:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder you added the certificate to.
    1. [Navigate](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Select the certificate in the `Renewing` status that you need to renew.
    1. Under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, you will see the details required to pass the domain rights check. For more information, see [{#T}](../../concepts/challenges.md).
    1. As soon as you pass the domain rights check, its status under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** will change to `Valid`.
    1. After the check status for all the domains changes to `Valid`, a certificate will be issued and its status will change to `Issued`.

- API {#api}

    To renew a certificate, use the [update](../../api-ref/Certificate/update.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Update](../../api-ref/grpc/Certificate/update.md) gRPC API call.

{% endlist %}

{% note info %}

{% include [checking-domain-rights-cname](../../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}