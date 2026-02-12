---
subcategory: Lockbox
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/lockbox_secret_version.md
---

# yandex_lockbox_secret_version (DataSource)

Get information about Yandex Cloud Lockbox secret version. For more information, see [the official documentation](https://yandex.cloud/docs/lockbox/).
If you're creating the secret in the same project, then you should indicate `version_id`, since otherwise you may refer to a wrong version of the secret (e.g. the first version, when it is still empty).

## Example usage

```terraform
//
// Get information about existing Lockbox Secret Version.
//
data "yandex_lockbox_secret_version" "my_secret_version" {
  secret_id  = "some-secret-id"
  version_id = "some-version-id" # if you don't indicate it, by default refers to the latest version
}

output "my_secret_entries" {
  value = data.yandex_lockbox_secret_version.my_secret_version.entries
}
```
```terraform
//
// Get information about existing Lockbox Secret Version.
//
resource "yandex_lockbox_secret" "my_secret" {
  # ...
}

resource "yandex_lockbox_secret_version" "my_version" {
  secret_id = yandex_lockbox_secret.my_secret.id
  # ...
}

data "yandex_lockbox_secret_version" "my_version" {
  secret_id  = yandex_lockbox_secret.my_secret.id
  version_id = yandex_lockbox_secret_version.my_version.id
}

output "my_secret_entries" {
  value = data.yandex_lockbox_secret_version.my_version.entries
}
```

## Arguments & Attributes Reference

- `entries` [Block]. List of entries in the Yandex Cloud Lockbox secret version. Must be omitted for secrets with a payload specification.

{% note warning %}

One either `text_value` or `command` is required.

{% endnote %}


  - `key` (**Required**)(String). The key of the entry.
  - `text_value` (String). The text value of the entry.
- `id` (String). 
- `secret_id` (**Required**)(String). The Yandex Cloud Lockbox secret ID where to add the version.
- `version_id` (String). The Yandex Cloud Lockbox secret version ID.


