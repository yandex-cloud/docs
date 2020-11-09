# User certificate

{{ certificate-manager-name }} lets you import certificates provided by third-party authorities and self-signed certificates. To import:

* A self-signed certificate: Specify the certificate and its private key.
* A certificate issued by a third-party certificate authority: Specify the certificate, its private key, and the intermediate certificate chain.

Supported cryptographic algorithms for creating private keys:

* RSA-2048
* RSA-4096

## Certificate requirements {#requirements}

User certificate requirements:

* The certificate must meet X.509 ver.3.

* The certificate must contain the public key, website domain name, and publisher information.

* You only import valid certificates.

    You can't import a certificate before it becomes valid or after its expiration date.

* Make sure to decrypt the private key of the certificate.

    You can't import a private key that is password-protected.

* Import the certificate, intermediate certificate chain, and private key in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded format.

## Renew a certificate {#renew}

{{ certificate-manager-name }} doesn't manage user certificates. To make your certificate continuously available to your resources, be sure to renew it on time.

To renew a certificate:

1. Get a new TLS certificate from a third-party certificate authority.

1. [Renew the certificate](../operations/import/cert-update.md).

    All the resources that use the certificate will get its new version.

#### See also {#see-also}

* [Integration with {{ yandex-cloud }} services](services.md)

