---
subcategory: Identity and Access Management
---

# yandex_organizationmanager_saml_federation_user_account (DataSource)

Get information about a user of Yandex SAML Federation. For more information, see [the official documentation](https://yandex.cloud/docs/organization/operations/federations/integration-common).

{% note warning %}

If terraform user had sufficient access and user specified in data source did not exist, it would be created. This behavior will was **fixed**. Use resource `yandex_organizationmanager_saml_federation_user_account` to manage account lifecycle.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing OrganizationManager SAML Federation User Account.
//
data "yandex_organizationmanager_saml_federation_user_account" "account" {
  federation_id = "some_federation_id"
  name_id       = "example@example.org"
}

output "my_federation.id" {
  value = data.yandex_organizationmanager_saml_federation_user_account.account.id
}
```

## Arguments & Attributes Reference

- `federation_id` (**Required**)(String). ID of a SAML Federation.
- `id` (String). 
- `name_id` (**Required**)(String). Name ID of the SAML federated user.


