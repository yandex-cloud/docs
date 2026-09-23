[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Lockbox > Data Sources > lockbox_secret

# yandex_lockbox_secret (DataSource)

Get information about Yandex Cloud Lockbox secret. For more information, see [the official documentation](../../lockbox/index.md).

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
- `deletion_protection` (*Read-Only*) (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `kms_key_id` (*Read-Only*) (String). The KMS key used to encrypt the Yandex Cloud Lockbox secret.
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `password_payload_specification` (*Read-Only*) (List Of Object). 
  - `excluded_punctuation` . 
  - `include_digits` . 
  - `include_lowercase` . 
  - `include_punctuation` . 
  - `include_uppercase` . 
  - `included_punctuation` . 
  - `length` . 
  - `password_key` . 
- `secret_id` (String). The Yandex Cloud Lockbox secret ID.
- `status` (*Read-Only*) (String). The Yandex Cloud Lockbox secret status.