---
subcategory: Key Management Service
---

# yandex_kms_symmetric_key (DataSource)

Get data from Yandex KMS symmetric key.

## Example usage

```terraform
//
// TBD
//
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `default_algorithm` (String). Encryption algorithm to be used with a new key version, generated with the next rotation. The default value is `AES_128`.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `rotated_at` (*Read-Only*) (String). Last rotation timestamp of the key.
- `rotation_period` (String). Interval between automatic rotations. To disable automatic rotation, omit this parameter.
- `status` (*Read-Only*) (String). The status of the key.
- `symmetric_key_id` (String). The symmetric key ID.


