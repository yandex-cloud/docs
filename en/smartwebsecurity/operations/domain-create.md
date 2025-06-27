---
title: How to add a domain to {{ sws-full-name }}
description: Follow this guide to add your domain for protection in {{ sws-full-name }}.
---

# Adding a domain

To add a domain you will need:

* Address of the domain on which the web application is running. You need access to the domain management interface to update the A record.
* (For HTTPS) Valid private key and TLS certificate for this domain in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded format. Certificates with RSA-2048 and RSA-4096 keys are supported.
* (Optional) Valid private key and TLS certificate to secure the connection between the proxy server and the server hosting your web application.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** and select the proxy server you want to add a domain for.
  1. In the left-hand menu, go to the ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** tab and click **{{ ui-key.yacloud.smart-web-security.ProxyServer.Domains.createDomain_49MGX }}**.
  1. Enter the address of the domain your web application is in.
   
     You can add a [wildcard domain](https://en.wikipedia.org/wiki/Wildcard_DNS_record), e.g., `*.example.com`. In which case requests to all subdomains of the specified domain will be processed.

  1. Optionally, enter a domain description.
  1. Click **{{ ui-key.yacloud.common.continue }}**.
  
  1. Specify the protocol for your web application to communicate with its users as well as additional parameters:
  
      * **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.httpsAndHttp_bpVzd }}**: Encrypted HTTPS connection and HTTP support for rare use cases. For example, for a transition period or to support legacy equipment.

         * Optionally, enable **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.redirectHttpToHttps_kuxH2 }}** to send HTTP requests over HTTPS.
         * Optionally, expand the **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.connectionSettings_7Q85M }}** section and change the numbers of used ports and the HTTPS version.

             By default, the HTTP/2 version, HTTP port `80`, and HTTPS port `443` are used.
      * **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.https_qWPJb }}**: Encrypted HTTPS connection.

         * Optionally, expand the **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.connectionSettings_7Q85M }}** section and change number of the used port and the HTTPS version.

             By default, the HTTP/2 version and HTTPS port `443` are used.
      * **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.http_4Dbmc }}**: Unencrypted connection. We recommend using it for test purposes only. You do not need a certificate for this option, but traffic between the user and your application will be transmitted in plain text.

         * Optionally, expand the **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.connectionSettings_7Q85M }}** section and change the number of the used port.

             HTTP port `80` is used by default.
  1. If using HTTPS, select a certificate from [{{ certificate-manager-name }}](../../certificate-manager/index.yaml) issued for the specified domain or click **{{ ui-key.yacloud.common.create }}** and select:

       * **{{ ui-key.yacloud.certificate-manager.CertificateField.userCertificate_bChXn }}**: If your web application already has a TLS certificate.

          1. Enter a name and description for the certificate.
          1. Optionally, enable deletion protection to prevent the certificate from being deleted.
          1. Copy or upload the certificate, intermediate certificate chain, and your private key in PEM format.
          1. Click **{{ ui-key.yacloud.certificate-manager.CertificateImportDialog.createCertificate_x7Ww3 }}**.

       * **{{ ui-key.yacloud.certificate-manager.CertificateField.letsEncryptCertificate_5ack4 }}**: If your web application does not have a TLS certificate.

          1. Enter a name and description for the certificate.
          1. Optionally, enable deletion protection to prevent the certificate from being deleted.
          1. Click **{{ ui-key.yacloud.certificate-manager.RequstCertificateDialog.createCertificate_b5eZg }}**. The interface will prompt you to create a [CNAME resource record](../../dns/concepts/resource-record.md#cname) in the [public DNS zone](../../dns/concepts/dns-zone.md#public-zones) of your domain. You need this record to [verify your domain rights](../../certificate-manager/concepts/challenges.md#dns).

              {% note info %}

              You can [create](../../dns/operations/resource-record-create.md) the record manually or, if your domain is delegated to {{ dns-full-name }}, use [this guide](../../certificate-manager/concepts/challenges.md#cname) to automatically create a resource record.

              {% endnote %}
          
             Wait until your rights for the domain are confirmed. It usually takes a few minutes to complete the check.
          1. To view the check status, click **{{ ui-key.yacloud.certificate-manager.overview.button_validation_show-logs }}**.

             After the check status changes to `Valid`, the certificate will be issued and its status will change to `Issued`. Until the certificate is issued, you will not be able to proceed with adding the domain.
  1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. Under **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.targetResources_hqBQm }}**, set up the targets:

      1. Enter the server IP address and port your web application runs on.
      1. Optionally, enter a comment for the server.
      1. Optionally, click **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.addResource_qyJWd }}** to add connections to any additional targets.
      1. Optionally, expand the **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.connectTargetResources_1mGNK }}** section to configure additional connection settings:

          * In the **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.protocol_q33c8 }}** field, select the connection protocol, `HTTPS` or `HTTP`.
          * Optionally, if you selected `HTTPS` and have multiple domain names and certificates, in the **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.sni_mHMUX }}** field, add a [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication) handler to route traffic based on the domain name.
          * If you selected `HTTPS`, upload the TLS certificate file.
          * Select the protocol version, `HTTP/2` or `HTTP/1.1`.
  1. Click **{{ ui-key.yacloud.smart-web-security.CreateDomain.createDomain_b2Ykj }}**.

{% endlist %}

After adding a domain [create a security profile](profile-create.md) and [connect](host-connect.md) it to the domain.

### See also {#see-also}

* [{#T}](proxy-create.md)
* [{#T}](profile-create.md)
* [{#T}](setup-infrastructure.md)
* [{#T}](validate-availability.md)
* [{#T}](host-connect.md)
