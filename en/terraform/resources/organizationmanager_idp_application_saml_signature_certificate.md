---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/organizationmanager_idp_application_saml_signature_certificate.md
---

# yandex_organizationmanager_idp_application_saml_signature_certificate (Resource)

A signature certificate for SAML applications.

## Example usage

```terraform
//
// Create a new OrganizationManager Idp Application SAML Signature Certificate.
//
resource "yandex_organizationmanager_idp_application_saml_signature_certificate" "example_certificate" {
  application_id = "some_application_id"
  name           = "example-signature-certificate"
  description    = "Example signature certificate for SAML application"
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


