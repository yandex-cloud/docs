---
subcategory: Identity Hub
---

# yandex_organizationmanager_idp_application_saml_signature_certificate (DataSource)

A signature certificate for SAML applications.

## Example usage

```terraform
//
// Get information about existing OrganizationManager Idp Application SAML Signature Certificate.
//
data "yandex_organizationmanager_idp_application_saml_signature_certificate" "certificate" {
  signature_certificate_id = "some_signature_certificate_id"
}

output "my_certificate.name" {
  value = data.yandex_organizationmanager_idp_application_saml_signature_certificate.certificate.name
}

output "my_certificate.fingerprint" {
  value = data.yandex_organizationmanager_idp_application_saml_signature_certificate.certificate.fingerprint
}

output "my_certificate.status" {
  value = data.yandex_organizationmanager_idp_application_saml_signature_certificate.certificate.status
}
```

## Arguments & Attributes Reference

- `application_id` (**Required**)(String). ID of the SAML application that the signature certificate belongs to.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `data` (*Read-Only*) (String). Certificate data in PEM format.
- `description` (String). Description of the signature certificate.
- `fingerprint` (*Read-Only*) (String). SHA256-fingerprint of the signature certificate.
- `id` (String). ID of the signature certificate to return.
- `name` (String). Name of the signature certificate.
- `not_after` (*Read-Only*) (String). Time after which the signature certificate is not valid.
- `not_before` (*Read-Only*) (String). Time before which the signature certificate is not valid.
- `signature_certificate_id` (String). ID of the signature certificate to return.
- `status` (*Read-Only*) (String). Current status of the signature certificate.


