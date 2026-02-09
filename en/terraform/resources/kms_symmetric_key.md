---
subcategory: Key Management Service
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/kms_symmetric_key.md
---

# yandex_kms_symmetric_key (Resource)

A symmetric KMS key that may contain several versions of the cryptographic material.

## Example usage

```terraform
//
// Create KMS Symmetric Key.
//
resource "yandex_kms_symmetric_key" "key-a" {
  name              = "example-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}
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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_kms_symmetric_key.<resource Name> <resource Id>
terraform import yandex_kms_symmetric_key.key-a abjjf**********p3gp8
```
