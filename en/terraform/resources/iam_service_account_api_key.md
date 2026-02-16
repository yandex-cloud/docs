---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/iam_service_account_api_key.md
---

# yandex_iam_service_account_api_key (Resource)

Allows management of a [Yandex Cloud IAM service account API key](https://yandex.cloud/docs/iam/concepts/authorization/api-key). The API key is a private key used for simplified authorization in the Yandex Cloud API. API keys are only used for [service accounts](https://yandex.cloud/docs/iam/concepts/users/service-accounts).

API keys do not expire. This means that this authentication method is simpler, but less secure. Use it if you can't automatically request an [IAM token](https://yandex.cloud/docs/iam/concepts/authorization/iam-token).

## Example usage

```terraform
//
// Create a new IAM Service Account API Key.
//
resource "yandex_iam_service_account_api_key" "sa-api-key" {
  lifecycle {
    ignore_changes = [scope]
  }
  service_account_id = "aje5a**********qspd3"
  description        = "api key for authorization"
  scopes             = ["yc.ydb.topics.manage", "yc.ydb.tables.manage"]
  expires_at         = "2024-11-11T00:00:00Z"
  pgp_key            = "keybase:keybaseusername"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `encrypted_secret_key` (*Read-Only*) (String). The encrypted secret key, base64 encoded. This is only populated when `pgp_key` is supplied.
- `expires_at` (String). The key will be no longer valid after expiration timestamp.
- `id` (String). 
- `key_fingerprint` (*Read-Only*) (String). The fingerprint of the PGP key used to encrypt the secret key. This is only populated when `pgp_key` is supplied.
- `output_to_lockbox_version_id` (*Read-Only*) (String). ID of the Lockbox secret version that contains the value of `secret_key`. This is only populated when `output_to_lockbox` is supplied. This version will be destroyed when the IAM key is destroyed, or when `output_to_lockbox` is removed.
- `pgp_key` (String). An optional PGP key to encrypt the resulting secret key material. May either be a base64-encoded public key or a keybase username in the form `keybase:keybaseusername`.
- `scope` (String). The scope of the key. Use `lifecycle {ignore_changes = [scope]}` directive to avoid false changes on apply.
- `scopes` (List Of String). The list of scopes of the key.
- `secret_key` (*Read-Only*) (String). The secret key. This is only populated when neither `pgp_key` nor `output_to_lockbox` are provided.
- `service_account_id` (**Required**)(String). ID of the service account to an API key for.
- `output_to_lockbox` [Block]. option to create a Lockbox secret version from sensitive outputs
  - `entry_for_secret_key` (**Required**)(String). entry that will store the value of secret_key
  - `secret_id` (**Required**)(String). ID of the Lockbox secret where to store the sensible values.


