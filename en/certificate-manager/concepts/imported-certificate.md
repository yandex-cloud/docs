---
title: Custom certificate in {{ certificate-manager-full-name }}
description: In this tutorial, you will learn what a custom certificate is.
---

# Custom certificate

{{ certificate-manager-name }} allows you to import certificates provided by third-party authorities and self-signed certificates. To import:
* A self-signed certificate: Specify the certificate and its private key.
* A certificate issued by a third-party certificate authority: Specify the certificate, its private key, and the intermediate certificate chain.

Supported cryptographic algorithms for creating private keys:
* RSA-2048
* RSA-4096

{% note info %}

GOST certificates are not supported.

{% endnote %}

## Certificate requirements {#requirements}

Custom certificate requirements:
* The certificate must meet the X.509 ver.3 standard.
* The certificate must contain the public key, website domain name, and publisher information.
* You only import valid certificates. 

    You cannot import a certificate before it becomes valid or after its expiration date.
* Make sure to decrypt the private key of the certificate. 

    You cannot import a private key that is password-protected.
* Import the certificate, intermediate certificate chain, and private key in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded format.

## Renewing a certificate {#renew}

{{ certificate-manager-name }} does not manage custom certificates. To make your certificate continuously available to your resources, be sure to renew it on time.

To renew a certificate: 
1. Get a new TLS certificate from a third-party certificate authority.
1. [Renew a certificate](../operations/import/cert-update.md).

    All the resources that use the certificate will get its new version.

## Use cases {#examples}

* [{#T}](../tutorials/nginx-ingress-certificate-manager.md)
* [{#T}](../tutorials/gatsby-static-website.md)
* [{#T}](../tutorials/virtual-hosting.md)
* [{#T}](../tutorials/tls-termination/index.md)

#### See also {#see-also}

* [Integration with {{ yandex-cloud }} services](services.md)