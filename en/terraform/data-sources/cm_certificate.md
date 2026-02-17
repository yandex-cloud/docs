---
subcategory: Certificate Manager
---

# yandex_cm_certificate (DataSource)

Get information about a Yandex Certificate Manager Certificate. For more information, see [the official documentation](https://yandex.cloud/docs/certificate-manager/concepts/).

{% note warning %}

One of `certificate_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing CM Certificate
//
data "yandex_cm_certificate" "example_by_id" {
  certificate_id = "certificate-id"
}

data "yandex_cm_certificate" "example_by_name" {
  folder_id = "folder-id"
  name      = "example"
}
```
```terraform
//
// Example of Certificate Validation. 
// Use "data.yandex_cm_certificate.example.id" to get validated certificate.
//
resource "yandex_cm_certificate" "example" {
  name    = "example"
  domains = ["example.com", "*.example.com"]

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = 1 # "example.com" and "*.example.com" has the same challenge
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

data "yandex_cm_certificate" "example" {
  depends_on      = [yandex_dns_recordset.example]
  certificate_id  = yandex_cm_certificate.example.id
  wait_validation = true
}
```

## Arguments & Attributes Reference

- `certificate_id` (String). Certificate Id.
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
- `wait_validation` (Bool). If `true`, the operation won't be completed while the certificate is in `VALIDATING`.


