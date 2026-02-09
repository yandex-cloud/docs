---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/organizationmanager_saml_federation_user_account.md
---

# yandex_organizationmanager_saml_federation_user_account (Resource)

Allows management of a single SAML Federation user account within an existing Yandex Cloud Organization.. For more information, see [the official documentation](https://yandex.cloud/docs/organization/operations/federations/integration-common).

{% note warning %}

If terraform user has sufficient access and user specified in data source does not exist, it will be created. This behaviour will be **deprecated** in future releases. Use resource `yandex_organizationmanager_saml_federation_user_account` to manage account lifecycle.

{% endnote %}


## Example usage

```terraform
//
// Create a new OrganizationManager SAML Federation User Account.
//
resource "yandex_organizationmanager_saml_federation_user_account" "account" {
  federation_id = "some_federation_id"
  name_id       = "example@example.org"
}
```

## Arguments & Attributes Reference

- `federation_id` (**Required**)(String). ID of a SAML Federation.
- `id` (String). 
- `name_id` (**Required**)(String). Name ID of the SAML federated user.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_organizationmanager_saml_federation_user_account.<resource Name> <resource Id>
terraform import yandex_organizationmanager_saml_federation_user_account.account ...
```
