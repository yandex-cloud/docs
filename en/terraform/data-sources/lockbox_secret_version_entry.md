---
subcategory: Lockbox
---

# yandex_lockbox_secret_version_entry (DataSource)

Get a single entry from a Yandex Cloud Lockbox secret version by key. For more information, see [the official documentation](https://yandex.cloud/docs/lockbox/).

This data source is a convenience wrapper around `yandex_lockbox_secret_version` that lets you retrieve a specific entry by key without having to filter the `entries` list yourself.

If you're creating the secret in the same project, then you should indicate `version_id`, since otherwise you may refer to a wrong version of the secret (e.g. the first version, when it is still empty).

## Example usage

```terraform
//
// Get a specific entry from the latest version of a Lockbox secret by key.
//
data "yandex_lockbox_secret_version_entry" "db_password" {
  secret_id = "some-secret-id"
  key       = "db_password"
}

output "db_password" {
  value     = data.yandex_lockbox_secret_version_entry.db_password.text_value
  sensitive = true
}
```
```terraform
//
// Get a specific entry from a pinned version of a Lockbox secret by key.
//
resource "yandex_lockbox_secret" "my_secret" {
  # ...
}

resource "yandex_lockbox_secret_version" "my_version" {
  secret_id = yandex_lockbox_secret.my_secret.id
  entries {
    key        = "db_password"
    text_value = "s3cr3t"
  }
  entries {
    key        = "db_user"
    text_value = "admin"
  }
}

data "yandex_lockbox_secret_version_entry" "db_password" {
  secret_id  = yandex_lockbox_secret.my_secret.id
  version_id = yandex_lockbox_secret_version.my_version.id
  key        = "db_password"
}

output "db_password" {
  value     = data.yandex_lockbox_secret_version_entry.db_password.text_value
  sensitive = true
}
```
```terraform
//
// Get a binary entry from a Lockbox secret version by key.
// The binary_value attribute contains the raw bytes encoded as a base64 string.
//
data "yandex_lockbox_secret_version_entry" "tls_cert" {
  secret_id = "some-secret-id"
  key       = "tls_cert"
}

output "tls_cert_b64" {
  value     = data.yandex_lockbox_secret_version_entry.tls_cert.binary_value
  sensitive = true
}
```

## Arguments & Attributes Reference

- `id` (String). 
- `key` (**Required**)(String). The key of the entry to retrieve.
- `secret_id` (**Required**)(String). The Yandex Cloud Lockbox secret ID.
- `version_id` (String). The Yandex Cloud Lockbox secret version ID. If omitted, the current (latest) version is used.
- `text_value` (*Read-Only*) (String, Sensitive). The text value of the entry. Populated when the entry holds a UTF-8 string. Mutually exclusive with `binary_value`.
- `binary_value` (*Read-Only*) (String, Sensitive). The binary value of the entry encoded as a base64 string. Populated when the entry holds binary data. Mutually exclusive with `text_value`.


