---
subcategory: Lockbox
---

# yandex_lockbox_secret_version_hashed (Resource)

Yandex Cloud Lockbox secret version resource (with values hashed in state). For more information, see [the official documentation](https://yandex.cloud/docs/lockbox/).

 ~> The `<NUMBER>` can range from `1` to `10`. If you only need one entry, use `key_1`/`text_value_1`. If you need a second entry, use `key_2`/`text_value_2`, and so on.

## Example usage

```terraform
//
// Create a new Lockbox Secret Hashed Version.
//
resource "yandex_lockbox_secret" "my_secret" {
  name = "test secret"
}

resource "yandex_lockbox_secret_version_hashed" "my_version" {
  secret_id = yandex_lockbox_secret.my_secret.id
  key_1     = "key1"
  // in Terraform state, these values will be stored in hash format
  text_value_1 = "sensitive value 1"
  key_2        = "k2"
  text_value_2 = "sensitive value 2"
  // etc. (up to 10 entries)
}
```

## Arguments & Attributes Reference

- `description` (String). The Yandex Cloud Lockbox secret version description.
- `id` (String). 
- `key_1` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_10` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_2` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_3` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_4` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_5` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_6` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_7` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_8` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `key_9` (String). Each of the entry keys in the Yandex Cloud Lockbox secret version.
- `secret_id` (**Required**)(String). The Yandex Cloud Lockbox secret ID where to add the version.
- `text_value_1` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_10` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_2` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_3` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_4` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_5` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_6` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_7` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_8` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.
- `text_value_9` (String). Each of the entry values in the Yandex Cloud Lockbox secret version.


