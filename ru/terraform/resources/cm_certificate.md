---
subcategory: Certificate Manager
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/cm_certificate.md
---

# yandex_cm_certificate (Resource)

Creates or requests a TLS certificate in the specified folder. For more information, see [the official documentation](https://yandex.cloud/docs/certificate-manager/concepts/).

{% note warning %}

At the moment, a resource may not work correctly if it declares the use of a DNS challenge, but the certificate is confirmed using an HTTP challenge. And vice versa.

{% endnote %}


In this case, the service does not provide the parameters of the required type of challenges.

{% note warning %}

Only one type `managed` or `self_managed` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Create a new Certificate for specific Domain name.
//
resource "yandex_cm_certificate" "example" {
  name    = "example"
  domains = ["example.com"]

  managed {
    challenge_type = "DNS_CNAME"
  }
}
```
```terraform
//
// Create a new Certificates for the set of domains
// with specific DNS challenge for each domain.
//
resource "yandex_cm_certificate" "example" {
  name    = "example"
  domains = ["one.example.com", "two.example.com"]

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = 2 # for each domain
  }
}

resource "yandex_dns_recordset" "example" {
  count   = yandex_cm_certificate.example.managed[0].challenge_count
  zone_id = "example-zone-id"
  name    = yandex_cm_certificate.example.challenges[count.index].dns_name
  type    = yandex_cm_certificate.example.challenges[count.index].dns_type
  data    = [yandex_cm_certificate.example.challenges[count.index].dns_value]
  ttl     = 60
}
```
```terraform
//
// Create a new Certificates for the set of domains
// with the same DNS challenge for both domains.
//
resource "yandex_cm_certificate" "example" {
  name    = "example"
  domains = ["example.com", "*.example.com"]

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = 1 # "example.com" and "*.example.com" has the same DNS_CNAME challenge
  }
}

resource "yandex_dns_recordset" "example" {
  count   = yandex_cm_certificate.example.managed[0].challenge_count
  zone_id = "example-zone-id"
  name    = yandex_cm_certificate.example.challenges[count.index].dns_name
  type    = yandex_cm_certificate.example.challenges[count.index].dns_type
  data    = [yandex_cm_certificate.example.challenges[count.index].dns_value]
  ttl     = 60
}
```
```terraform
//
// Create a new self-managed Certificate.
//
resource "yandex_cm_certificate" "example" {
  name = "example"

  self_managed {
    certificate = "-----BEGIN CERTIFICATE----- ... -----END CERTIFICATE----- \n -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----"
    private_key = "-----BEGIN RSA PRIVATE KEY----- ... -----END RSA PRIVATE KEY-----"
  }
}
```

## Arguments & Attributes Reference

- `challenges` (*Read-Only*) (List Of Object). Array of challenges.
  - `created_at` . 
  - `dns_name` . 
  - `dns_type` . 
  - `dns_value` . 
  - `domain` . 
  - `http_content` . 
  - `http_url` . 
  - `message` . 
  - `type` . 
  - `updated_at` . 
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `domains` (List Of String). Domains for this certificate. Should be specified for managed certificates.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `issued_at` (*Read-Only*) (String). Certificate issue timestamp.
- `issuer` (*Read-Only*) (String). Certificate Issuer.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `not_after` (*Read-Only*) (String). Certificate end valid period.
- `not_before` (*Read-Only*) (String). Certificate start valid period.
- `serial` (*Read-Only*) (String). Certificate Serial Number.
- `status` (*Read-Only*) (String). Certificate status: `VALIDATING`, `INVALID`, `ISSUED`, `REVOKED`, `RENEWING` or `RENEWAL_FAILED`.
- `subject` (*Read-Only*) (String). Certificate Subject.
- `type` (*Read-Only*) (String). Certificate type: `MANAGED` or `IMPORTED`.
- `updated_at` (*Read-Only*) (String). Certificate update timestamp.
- `managed` [Block]. Managed specification.

{% note warning %}

Resource creation awaits getting challenges from issue provider.

{% endnote %}


  - `challenge_count` (Number). Expected number of challenge count needed to validate certificate. Resource creation will fail if the specified value does not match the actual number of challenges received from issue provider. This argument is helpful for safe automatic resource creation for passing challenges for multi-domain certificates.
  - `challenge_type` (**Required**)(String). Domain owner-check method. Possible values:
* `DNS_CNAME` - you will need to create a CNAME dns record with the specified value. Recommended for fully automated certificate renewal.
* `DNS_TXT` - you will need to create a TXT dns record with specified value.
* `HTTP` - you will need to place specified value into specified url.
- `self_managed` [Block]. Self-managed specification.

{% note warning %}

Only one type `private_key` or `private_key_lockbox_secret` should be specified.

{% endnote %}


  - `certificate` (**Required**)(String). Certificate with chain.
  - `private_key` (String). Private key of certificate.
  - `private_key_lockbox_secret` [Block]. Lockbox secret specification for getting private key.
    - `id` (**Required**)(String). Lockbox secret Id.
    - `key` (**Required**)(String). Key of the Lockbox secret, the value of which contains the private key of the certificate.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cm_certificate.<resource Name> <resource Id>
terraform import yandex_cm_certificate.my_cm_cert fpqn8********** cg27q
```
