---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/iam_service_account_static_access_key.md
---

# yandex_iam_service_account_static_access_key (Resource)

Allows management of [Yandex Cloud IAM service account static access keys](https://yandex.cloud/docs/iam/operations/sa/create-access-key). Generated pair of keys is used to access [Yandex Object Storage](https://yandex.cloud/docs/storage) on behalf of service account.

Before using keys do not forget to [assign a proper role](https://yandex.cloud/docs/iam/operations/sa/assign-role-for-sa) to the service account.

## Example usage

```terraform
//
// Create a new IAM Service Account Static Access SKey.
//
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "aje5a**********qspd3"
  description        = "static access key for object storage"
  pgp_key            = "keybase:keybaseusername"
}
```

## Arguments & Attributes Reference

- `access_key` (*Read-Only*) (String). ID of the static access key. This is only populated when `output_to_lockbox` is not provided.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `encrypted_secret_key` (*Read-Only*) (String). The encrypted secret, base64 encoded. This is only populated when `pgp_key` is supplied.
- `id` (String). 
- `key_fingerprint` (*Read-Only*) (String). The fingerprint of the PGP key used to encrypt the secret key. This is only populated when `pgp_key` is supplied.
- `output_to_lockbox_version_id` (*Read-Only*) (String). ID of the Lockbox secret version that contains the value of `secret_key`. This is only populated when `output_to_lockbox` is supplied. This version will be destroyed when the IAM key is destroyed, or when `output_to_lockbox` is removed.
- `pgp_key` (String). An optional PGP key to encrypt the resulting secret key material. May either be a base64-encoded public key or a keybase username in the form `keybase:keybaseusername`.
- `secret_key` (*Read-Only*) (String). Private part of generated static access key. This is only populated when neither `pgp_key` nor `output_to_lockbox` are provided.
- `service_account_id` (**Required**)(String). ID of the service account which is used to get a static key.
- `output_to_lockbox` [Block]. option to create a Lockbox secret version from sensitive outputs
  - `entry_for_access_key` (**Required**)(String). entry that will store the value of access_key
  - `entry_for_secret_key` (**Required**)(String). entry that will store the value of secret_key
  - `secret_id` (**Required**)(String). ID of the Lockbox secret where to store the sensible values.


