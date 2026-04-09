---
subcategory: Key Management Service
---

# yandex_kms_asymmetric_encryption_key (DataSource)

An asymmetric KMS key that may contain several versions of the cryptographic material.

## Example usage

```terraform
//
// TBD
//
```

## Arguments & Attributes Reference

- `asymmetric_encryption_key_id` (String). ID of the asymmetric KMS key to return.
 To get the ID of an asymmetric KMS key use a [AsymmetricEncryptionKeyService.List] request.
- `created_at` (*Read-Only*) (String). Time when the key was created.
- `deletion_protection` (Bool). Flag that inhibits deletion of the key
- `description` (String). Description of the key.
- `encryption_algorithm` (String). Asymmetric Encryption Algorithm ID.
- `folder_id` (String). ID of the folder that the key belongs to.
- `id` (String). ID of the asymmetric KMS key to return.
 To get the ID of an asymmetric KMS key use a [AsymmetricEncryptionKeyService.List] request.
- `labels` (Map Of String). Custom labels for the key as `key:value` pairs. Maximum 64 per key.
- `name` (String). Name of the key.
- `status` (String). Current status of the key.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


