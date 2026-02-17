---
subcategory: Identity Hub
---

# yandex_organizationmanager_saml_federation (DataSource)

Get information about a Yandex SAML Federation. For more information, see [the official documentation](https://yandex.cloud/docs/organization/add-federation).

{% note warning %}

One of `federation_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing OrganizationManager SAML Federation.
//
data "yandex_organizationmanager_saml_federation" "federation" {
  federation_id   = "some_federation_id"
  organization_id = "some_organization_id"
}

output "my_federation.name" {
  value = data.yandex_organizationmanager_saml_federation.federation.name
}
```

## Arguments & Attributes Reference

- `auto_create_account_on_login` (Bool). Add new users automatically on successful authentication. The user will get the `resource-manager.clouds.member` role automatically, but you need to grant other roles to them. If the value is `false`, users who aren't added to the cloud can't log in, even if they have authenticated on your server.
- `case_insensitive_name_ids` (Bool). Use case-insensitive name IDs.
- `cookie_max_age` (String). The lifetime of a Browser cookie in seconds. If the cookie is still valid, the management console authenticates the user immediately and redirects them to the home page. The default value is `8h`.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `federation_id` (String). ID of a SAML Federation.
- `id` (String). 
- `issuer` (**Required**)(String). The ID of the IdP server to be used for authentication. The IdP server also responds to IAM with this ID after the user authenticates.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `organization_id` (**Required**)(String). The organization to attach this SAML Federation to.
- `security_settings` [Block]. Federation security settings.
  - `encrypted_assertions` (Bool). Enable encrypted assertions.
  - `force_authn` (Bool). Force authentication on session expiration
- `sso_binding` (**Required**)(String). Single sign-on endpoint binding type. Most Identity Providers support the `POST` binding type. SAML Binding is a mapping of a SAML protocol message onto standard messaging formats and/or communications protocols.
- `sso_url` (**Required**)(String). Single sign-on (SSO) endpoint URL. Specify the link to the IdP login page here.


