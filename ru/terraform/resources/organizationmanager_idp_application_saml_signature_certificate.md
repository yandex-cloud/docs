---
subcategory: Identity Hub
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
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


