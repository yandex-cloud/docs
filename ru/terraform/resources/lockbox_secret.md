---
subcategory: Lockbox
---

# yandex_lockbox_secret (Resource)

Yandex Cloud Lockbox secret resource. For more information, see [the official documentation](https://yandex.cloud/docs/lockbox/). The created secret will contain a version with the generated password. You can use `yandex_lockbox_secret_version` to create new versions.

## Example usage

```terraform
//
// Create a new LockBox Secret.
//
resource "yandex_lockbox_secret" "my_secret" {
  name = "test secret"
}
```
```terraform
//
// Create a new LockBox Secret with password.
//
resource "yandex_lockbox_secret" "my_secret" {
  name = "test secret with passowrd"

  password_payload_specification {
    password_key = "some_password"
    length       = 12
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `kms_key_id` (String). The KMS key used to encrypt the Yandex Cloud Lockbox secret.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `status` (*Read-Only*) (String). The Yandex Cloud Lockbox secret status.
- `password_payload_specification` [Block]. Payload specification for password generation.
  - `excluded_punctuation` (String). String of punctuation characters to exclude from the default. Requires `include_punctuation = true`. Default is empty.
  - `include_digits` (Bool). Use digits in the generated password. Default is true.
  - `include_lowercase` (Bool). Use lowercase letters in the generated password. Default is true.
  - `include_punctuation` (Bool). Use punctuations (`!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~`) in the generated password. Default is true.
  - `include_uppercase` (Bool). Use capital letters in the generated password. Default is true.
  - `included_punctuation` (String). String of specific punctuation characters to use. Requires `include_punctuation = true`. Default is empty.
  - `length` (Number). Length of generated password. Default is `36`.
  - `password_key` (**Required**)(String). The key with which the generated password will be placed in the secret version.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_lockbox_secret.<resource Name> <resource Id>
terraform import yandex_lockbox_secret.my_secret ...
```
