---
subcategory: Identity and Access Management
---

# yandex_iam_oauth_client_secret (Resource)

Allows management of [Yandex Cloud IAM OAuth client secret](https://yandex.cloud/docs/iam/concepts/authorization/oauth-client-secret). The OAuth client secret is used for OAuth 2.0 client authentication.

## Example usage

```terraform
//
// Create a new OAuth Client Secret.
//
resource "yandex_iam_oauth_client_secret" "my-oauth-client-secret" {
  oauth_client_id = yandex_iam_oauth_client.my-oauth-client.id
  description     = "secret for oauth client"
  pgp_key         = "keybase:keybaseusername"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `encrypted_secret_value` (*Read-Only*) (String). The encrypted secret value, base64 encoded. This is only populated when `pgp_key` is supplied.
- `id` (String). 
- `key_fingerprint` (*Read-Only*) (String). The fingerprint of the PGP key used to encrypt the secret value. This is only populated when `pgp_key` is supplied.
- `masked_secret` (*Read-Only*) (String). The masked value of the OAuth client secret.
- `oauth_client_id` (**Required**)(String). ID of the OAuth client to create a secret for.
- `output_to_lockbox_version_id` (*Read-Only*) (String). ID of the Lockbox secret version that contains the value of `secret_key`. This is only populated when `output_to_lockbox` is supplied. This version will be destroyed when the IAM key is destroyed, or when `output_to_lockbox` is removed.
- `pgp_key` (String). An optional PGP key to encrypt the resulting secret value. May either be a base64-encoded public key or a keybase username in the form `keybase:keybaseusername`.
- `secret_value` (*Read-Only*) (String). The secret value. This is only populated when neither `pgp_key` nor `output_to_lockbox` are provided.
- `output_to_lockbox` [Block]. option to create a Lockbox secret version from sensitive outputs
  - `entry_for_secret_value` (**Required**)(String). entry that will store the value of secret_value
  - `secret_id` (**Required**)(String). ID of the Lockbox secret where to store the sensible values.


