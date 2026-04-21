# Certificate Manager

Certificate Manager is a component to manage certificates used in cross-service interaction. There are two global issuers (`kind: ClusterIssuer`) available for certificate management: Default CA Issuer (`stackland-default`) and Let's Encrypt HTTP01 (`stackland-letsencrypt`). Both issuers are based on the open-source [cert-manager](https://cert-manager.io/) project.

## Default CA Issuer

This issuer is enabled by default and cannot be additionally configured. If you specified an intermediate CA during Stackland installation (see [Getting started](../../quickstart.md#prepare-image)), it will certify the generated certificates. Otherwise, self-signed certificates are generated.

## Let's Encrypt HTTP01

The certificate from the [Let's Encrypt](https://letsencrypt.org/) certificate authority (CA) is recognized as trusted by all modern browsers; therefore, this option is suitable for services that are expected to receive connections from outside the organization.

Let's Encrypt supports various methods for verifying domain ownership. Certificate Manager supports the most common one: HTTP01. All required communication with the certificate authority is handled automatically, eliminating the need for the Stackland cluster administrator to intervene.

The Let's Encrypt HTTP01 issuer is disabled by default and requires additional configuration. To do this, you need to edit the global `CertificateManagerConfig` resource and make changes to the `clusterIssuers` section, which should look as follows:

```yaml
clusterIssuers:
  letsencryptHttp01:
    enabled: true                              # Enabling Let's Encrypt HTTP01 support
    email: your-email@example.com              # Valid email address to which you expect the Let's Encrypt notifications to be delivered.
```

During the configuration process, a private key for working with Let's Encrypt will be automatically saved in the `stackland-certificate-manager` namespace in the `letsencrypt-private-key` secret. If you lose this key, it will be impossible to revoke the certificate issued by Certificate Manager for the domain.

## Issuing a certificate

To issue a certificate, create the `Certificate` resource specifying the issuer type: `stackland-default` for the Default CA Issuer or `stackland-letsencrypt` for Let's Encrypt HTTP01. You also need to specify the domain the certificate is issued for.

{% include notitle [YAML-file](../../_includes/yamls/operations/certificate-manager/certificate.md) %}

If you are using Let's Encrypt HTTP01, the domain must be external, i.e., allowed outside the organization network.

You can also automatically issue a certificate for a service (`Ingress`) by using annotations:

{% include notitle [YAML-file](../../_includes/yamls/operations/certificate-manager/ingress.md) %}
