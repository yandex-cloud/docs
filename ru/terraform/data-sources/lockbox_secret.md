---
subcategory: Lockbox
---

# yandex_lockbox_secret (DataSource)

Get information about Yandex Cloud Lockbox secret. For more information, see [the official documentation](https://yandex.cloud/docs/lockbox/).

{% note warning %}

One of `secret_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Lockbox Secret.
//
data "yandex_lockbox_secret" "my_secret" {
  secret_id = "some ID"
}

output "my_secret_created_at" {
  value = data.yandex_lockbox_secret.my_secret.created_at
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `current_version` (*Read-Only*) (List Of Object). Current secret version.
  - `created_at` . 
  - `description` . 
  - `destroy_at` . 
  - `id` . 
  - `payload_entry_keys` . 
  - `secret_id` . 
  - `status` . 
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `kms_key_id` (String). The KMS key used to encrypt the Yandex Cloud Lockbox secret.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `password_payload_specification` [Block]. Payload specification for password generation.
  - `excluded_punctuation` (String). String of punctuation characters to exclude from the default. Requires `include_punctuation = true`. Default is empty.
  - `include_digits` (Bool). Use digits in the generated password. Default is true.
  - `include_lowercase` (Bool). Use lowercase letters in the generated password. Default is true.
  - `include_punctuation` (Bool). Use punctuations (`!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~`) in the generated password. Default is true.
  - `include_uppercase` (Bool). Use capital letters in the generated password. Default is true.
  - `included_punctuation` (String). String of specific punctuation characters to use. Requires `include_punctuation = true`. Default is empty.
  - `length` (Number). Length of generated password. Default is `36`.
  - `password_key` (**Required**)(String). The key with which the generated password will be placed in the secret version.
- `secret_id` (String). The Yandex Cloud Lockbox secret ID.
- `status` (*Read-Only*) (String). The Yandex Cloud Lockbox secret status.


