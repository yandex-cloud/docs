---
subcategory: Identity Hub
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/organizationmanager_idp_userpool.md
---

# yandex_organizationmanager_idp_userpool (Resource)

A userpool is a container for users in the Identity Provider system.

## Example usage

```terraform
//
// Create a new OrganizationManager Idp Userpool.
//
resource "yandex_organizationmanager_idp_userpool" "example_userpool" {
  name              = "example-userpool"
  organization_id   = "your_organization_id"
  default_subdomain = "example-subdomain"
  description       = "Description example"

  labels = {
    example-label = "example-label-value"
  }

  user_settings = {
    allow_edit_self_login = true
  }

  password_quality_policy = {
    allow_similar   = true
    max_length      = 128
    match_length    = 4
    fixed = {
      lowers_required = true
      uppers_required = true
      digits_required = true
      min_length      = 8
    }
  }
}
```

## Arguments & Attributes Reference

- `bruteforce_protection_policy` [Block]. Bruteforce protection policy for this userpool.
  - `attempts` (Number). Number of failed attempts allowed within the window before blocking.
  - `block` (String). Duration of the block after too many failed attempts.
  - `window` (String). Time window for counting failed authentication attempts.
- `created_at` (*Read-Only*) (String). Timestamp when the userpool was created.
- `default_subdomain` (**Required**)(String). Default subdomain for the userpool.
- `description` (String). Description of the userpool.
- `domains` (*Read-Only*) (List Of String). List of domains associated with this userpool.
- `id` (String). ID of the userpool to return.
 To get the userpool ID, make a [UserpoolService.List] request.
- `labels` (Map Of String). Resource labels as key:value pairs.
- `name` (**Required**)(String). Name of the userpool.
- `organization_id` (**Required**)(String). ID of the organization this userpool belongs to.
- `password_lifetime_policy` [Block]. Password lifetime policy for this userpool.
  - `max_days_count` (Number). Maximum number of days a password remains valid.
 Zero means passwords never expire.
  - `min_days_count` (Number). Minimum number of days before a password can be changed.
- `password_quality_policy` [Block]. Password quality policy for this userpool.
  - `allow_similar` (Bool). Whether passwords similar to previous ones are allowed.
  - `fixed` [Block]. Fixed complexity requirements. Exactly one of complexity requirements must be specified.
    - `digits_required` (Bool). Whether digits are required in the password.
    - `lowers_required` (Bool). Whether lowercase letters are required in the password.
    - `min_length` (Number). Minimum length required for all passwords.
    - `specials_required` (Bool). Whether special characters are required in the password.
    - `uppers_required` (Bool). Whether uppercase letters are required in the password.
  - `match_length` (Number). Minimum length of substrings to check for similarity to vulnerable sequences.
  - `max_length` (Number). Maximum password length. Zero means no maximum length is enforced.
  - `smart` [Block]. Smart complexity requirements. Exactly one of complexity requirements must be specified.
    - `four_classes` (Number). For passwords with all four classes of characters
    - `one_class` (Number). For passwords with one class of characters
    - `three_classes` (Number). For passwords with three classes of characters
    - `two_classes` (Number). For passwords with two classes of characters
- `status` (*Read-Only*) (String). Current status of the userpool.
- `updated_at` (*Read-Only*) (String). Timestamp when the userpool was last updated.
- `user_settings` [Block]. User settings for this userpool.
  - `allow_edit_self_contacts` (Bool). Whether users can edit their own contact information.
  - `allow_edit_self_info` (Bool). Whether users can edit their own profile information.
  - `allow_edit_self_login` (Bool). Whether users can edit their own login information.
  - `allow_edit_self_password` (Bool). Whether users can change their own passwords.
- `userpool_id` (String). ID of the userpool to return.
 To get the userpool ID, make a [UserpoolService.List] request.


