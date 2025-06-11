---
title: How to add a domain to {{ sws-full-name }}
description: Follow this guide to add your domain for protection in {{ sws-full-name }}.
---

# Adding a domain

To add a domain you will need:

* Address of the domain the web application is running on. You need access to the domain management interface to update the A record.
* (For HTTPS) Valid private key and TLS certificate for this domain in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded format. Certificates with RSA-2048 and RSA-4096 keys are supported.
* (Optional) Valid private key and TLS certificate to secure the connection between the proxy server and the server hosting your web application.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Open the **Domain protection** section.
  1. Select the proxy server you want to add a domain for.
  1. Click **Add domain**.
  1. Enter the address of the domain your web application is in.
   
     You can add a wildcard domain, e.g., `*.example.com`. In which case requests to all subdomains will be processed.

  1. Optionally, enter a domain description.
  1. Click **Continue**.
  
  1. Specify the protocol for your web application to communicate with its users as well as additional parameters:
  
      * **HTTPS and HTTP**: Encrypted HTTPS connection and HTTP support for rare use cases. For example, for a transition period or to support legacy equipment.

         Enable **Redirect HTTP to HTTPS** for HTTP requests to be sent over HTTPS.

      * **HTTPS**: Encrypted HTTPS connection.
      * **HTTP**: Unencrypted connection. We recommend using it for test purposes only. You do not need a certificate for this option, but traffic between the user and your application will be transmitted in plain text.
      * (Optional) By default, HTTP uses port `80`; HTTPS uses port `443` and version HTTPS/2. If your web application has different settings, open the **Connection settings** section and specify them.

  1. If using HTTPS, add a certificate from [{{ certificate-manager-name }}](../../certificate-manager/) or click **Create certificate** and select:

       * **User certificate**: If your web application already has a TLS certificate.
  
          1. Enter a name and description for the certificate.
          1. Optionally, enable deletion protection to prevent the certificate from being deleted.
          1. Copy or upload the private key, certificate, and intermediate certificate chain as a file in PEM format.
          1. Click **Create certificate**.

       * **Let’s Encrypt certificate**: If your web application does not have a TLS certificate.
         
          1. Enter a name and description for the certificate.
          1. Optionally, enable deletion protection to prevent the certificate from being deleted.
          1. Click **Create certificate**.
          1. The interface will provide instructions for confirming your domain rights. Follow them.
          
             Wait until the domain is confirmed. It usually takes a few minutes to complete the check. Read more about the [domain rights check](../../certificate-manager/concepts/challenges.md#dns).
          1. To view the check status, click **Show logs**.
 
             After the check status changes to `Valid`, the certificate will be issued and its status will change to `Issued`. Until the certificate is issued, you will not be able to continue adding the domain.
  
  1. Click **Next**.
  
  1. Specify the **Target resources** settings:
     1. Enter the server IP address and port your web application runs on.
     1. Optionally, enter a comment for the server.
     1. Optionally, specify parameters for connection to target resources:
        * To route traffic from the proxy server to your server via HTTPS, select this protocol and add a certificate.
        * If you use multiple domain names and certificates, specify [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication).
        * Select the protocol version: HTTP/2 or HTTP/1.1.
  1. Click **Add domain**.

{% endlist %}

After adding a domain [create a security profile](profile-create.md) and [connect](host-connect.md) it to the domain.

### See also {#see-also}

* [{#T}](proxy-create.md)
* [{#T}](profile-create.md)
* [{#T}](host-connect.md)
