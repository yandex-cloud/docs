---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/iam_service_account_key.md
---

# yandex_iam_service_account_key (Resource)

Allows management of [Yandex Cloud IAM service account authorized keys](https://yandex.cloud/docs/iam/concepts/authorization/key). Generated pair of keys is used to create a [JSON Web Token](https://tools.ietf.org/html/rfc7519) which is necessary for requesting an [IAM Token](https://yandex.cloud/docs/iam/concepts/authorization/iam-token) for a [service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts).

## Example usage

```terraform
//
// Create a new IAM Service Account Key.
//
resource "yandex_iam_service_account_key" "sa-auth-key" {
  service_account_id = "aje5a**********qspd3"
  description        = "key for service account"
  key_algorithm      = "RSA_4096"
  pgp_key            = "keybase:keybaseusername"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `encrypted_private_key` (*Read-Only*) (String). The encrypted private key, base64 encoded. This is only populated when `pgp_key` is supplied.
- `format` (String). The output format of the keys. `PEM_FILE` is the default format.
- `id` (String). 
- `key_algorithm` (String). The algorithm used to generate the key. `RSA_2048` is the default algorithm. Valid values are listed in the [API reference](https://yandex.cloud/docs/iam/api-ref/Key).
- `key_fingerprint` (*Read-Only*) (String). The fingerprint of the PGP key used to encrypt the private key. This is only populated when `pgp_key` is supplied.
- `output_to_lockbox_version_id` (*Read-Only*) (String). ID of the Lockbox secret version that contains the value of `secret_key`. This is only populated when `output_to_lockbox` is supplied. This version will be destroyed when the IAM key is destroyed, or when `output_to_lockbox` is removed.
- `pgp_key` (String). An optional PGP key to encrypt the resulting private key material. May either be a base64-encoded public key or a keybase username in the form `keybase:keybaseusername`.
- `private_key` (*Read-Only*) (String). The private key. This is only populated when neither `pgp_key` nor `output_to_lockbox` are provided.
- `public_key` (*Read-Only*) (String). The public key.
- `service_account_id` (**Required**)(String). ID of the service account to create a pair for.
- `output_to_lockbox` [Block]. option to create a Lockbox secret version from sensitive outputs
  - `entry_for_private_key` (**Required**)(String). entry that will store the value of private_key
  - `secret_id` (**Required**)(String). ID of the Lockbox secret where to store the sensible values.


