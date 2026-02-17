---
subcategory: Identity Hub
---

# yandex_organizationmanager_idp_userpool_domain (Resource)

A domain associated with a userpool.

## Example usage

```terraform
//
// Create a new OrganizationManager Idp Userpool Domain.
//
resource "yandex_organizationmanager_idp_userpool_domain" "example_domain" {
  userpool_id = "your_userpool_id"
  domain      = "example.com"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Timestamp when the domain was created.
- `domain` (**Required**)(String). Domain name.
- `id` (String). ID in format userpool_id:domain
- `userpool_id` (**Required**)(String). ID of the userpool to get a domain for.


