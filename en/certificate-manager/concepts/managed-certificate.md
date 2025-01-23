# Certificate from Let's Encrypt

You can use {{ certificate-manager-name }} to create Let's Encrypt certificates. Request a certificate and pass the domain rights check. After that, {{ certificate-manager-name }} will manage your certificate by working with Let's Encrypt on your behalf.

Let's Encrypt provides Domain Validation TLS certificates with a 90-day validity period. If you need Organization Validation or Extended Validation certificates, use a third-party certificate authority to get the certificate, and then upload it to {{ certificate-manager-name }}. For more information, see [User certificate](imported-certificate.md). 

You can use a certificate created with {{ certificate-manager-name }} in the [specified](services.md) {{ yandex-cloud }} services only.

## Getting a certificate {#request}

1. Specify the list of domains you need to issue a certificate for.
1. Select the type of domain rights check: `HTTP` or `DNS`.

    Certificate status after the request is created: `Validating`. 
1. To get a certificate, pass the domain rights check for the domains you specified in the previous step.

    Depending on the selected type of check, put the file on the web server or add a `TXT` or `CNAME` resource record with the appropriate value in the DNS service. To learn more about the types of checks and ways to pass them, see [{#T}](challenges.md).

    {% include [checking-domain-rights-cname](../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

1. As soon as the domain rights check is passed, the certificate will be issued and get the `Issued` status. You can use the certificate in services that are integrated with {{ certificate-manager-name }}.

{% note warning %}

If you fail to pass the domain rights check within a week, the certificate will not be issued and its status will change to `Invalid`.

{% endnote %}

## Certificate issue statuses {#issue-statuses}

You can view the stages of issuing a certificate, their detailed description, and the result of each one in the management console. This information can be found in each certificate's logs.

The stages of issuing a Let's Encrypt certificate are as follows:

1. Requesting a certificate.

    At this stage, an asymmetric key pair is generated, a Let's Encrypt account is created, and a request for a certificate is submitted.

1. Challenge generation.

    At this stage, the domain rights check challenges are generated based on the [ACME](https://tools.ietf.org/html/rfc8555) standard.

1. Passing the domain rights check challenges.
   
    At this stage, your control of the domains you request the certificate for is verified. To get through the stage, complete these actions for the type of check you selected:

    * `HTTP`: Put a file on the web server.
    * `DNS`: Add a record in the DNS service.
     
     The system will check at 30 minute intervals whether the challenge conditions are met. Until then, the stage will remain in the `Error` status. If you fail to pass the challenges within one week, your certificate request will be declined.

1. Completing the issue of the certificate. At this stage, the following actions are automatically performed:

    1. Creating a Certificate Signing Request (CSR).
    1. Getting the challenges checked on the Let's Encrypt side.
    1. Requesting Let's Encrypt to sign the certificate.
    1. Getting Let's Encrypt's response on the issue of the certificate.
    1. Completing the issue and saving the certificate to {{ certificate-manager-name }}.

You can proceed to each next stage after the previous one ends with `Success`.

## Renewing a certificate {#renew}

{% note warning %}

To renew a certificate, follow the steps below. Keep track of the lifecycle of your certificates to renew them on time.

{% endnote %}

1. {{ certificate-manager-name }} initiates the certificate renewal procedure 30 days before it expires.
    
    After the renewal procedure starts, the certificate gets the `Renewing` status.
1. Pass the domain rights check.

    Depending on the type of check you selected, update the file on the web server or update the `TXT` record in the DNS service to the new value. For more information, see [Check rights for domain](challenges.md).
    
    {% note info %}
    
    If the certificate is used in a [static website in {{ objstorage-name }}](../../tutorials/web/static/index.md) and does contains no [masked domains](https://en.wikipedia.org/wiki/Wildcard_certificate), the rights check can be passed automatically. For more information, see [Checking rights automatically](challenges.md#auto). 
    
    {% endnote %}
    
1. As soon as the domain rights check is passed, the certificate will be renewed and get the `Issued` status. All the resources that use the certificate will get its new version. 

The certificate will not be renewed if the domain rights check ends with an error, even for a single domain. In which case the certificate's status will change to `Renewal_failed`, and it will remain valid until it's expiration date.
Some time after the failed renewal, a new attempt will be made to update the certificate. 
 
To avoid issues with access to resources that depend on the certificate with the `Renewal_failed` status:
1. Before the certificate expires, get and [add a new Let's Encrypt certificate](../operations/managed/cert-create.md).
1. [Pass the domain rights check](../operations/managed/cert-validate.md).
1. Use the new certificate in your resources.

#### See also {#see-also}

- [Checking domain rights](challenges.md)
- [Services integrated with {{ certificate-manager-name }}](services.md)
