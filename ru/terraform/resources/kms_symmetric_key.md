---
subcategory: Key Management Service
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

- `created_at` (*Read-Only*) (String). Time when the key was created.
- `default_algorithm` (String). Default encryption algorithm to be used with new versions of the key.
- `deletion_protection` (Bool). Flag that inhibits deletion of the key
- `description` (String). Description of the key.
- `folder_id` (String). ID of the folder that the key belongs to.
- `id` (String). ID of the symmetric KMS key to return.
 To get the ID of a symmetric KMS key use a [SymmetricKeyService.List] request.
- `labels` (Map Of String). Custom labels for the key as `key:value` pairs. Maximum 64 per key.
- `name` (String). Name of the key.
- `rotated_at` (*Read-Only*) (String). Time of the last key rotation (time when the last version was created).
 Empty if the key does not have versions yet.
- `rotation_period` (String). Time period between automatic key rotations.
- `status` (String). Current status of the key.
- `symmetric_key_id` (String). ID of the symmetric KMS key to return.
 To get the ID of a symmetric KMS key use a [SymmetricKeyService.List] request.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_kms_symmetric_key.<resource Name> <resource Id>
terraform import yandex_kms_symmetric_key.key-a abjjf**********p3gp8
```
