---
subcategory: Key Management Service
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/kms_asymmetric_signature_key.md
---

# yandex_kms_asymmetric_signature_key (DataSource)

An asymmetric KMS key that may contain several versions of the cryptographic material.

## Example usage

```terraform
//
// TBD
//
```

## Arguments & Attributes Reference

- `asymmetric_signature_key_id` (String). ID of the asymmetric KMS key to return. To get the ID of an asymmetric KMS key use a [AsymmetricSignatureKeyService.List] request.
- `created_at` (*Read-Only*) (String). Time when the key was created.
- `deletion_protection` (Bool). Flag that inhibits deletion of the key
- `description` (String). Description of the key.
- `folder_id` (String). ID of the folder that the key belongs to.
- `id` (String). ID of the asymmetric KMS key to return. To get the ID of an asymmetric KMS key use a [AsymmetricSignatureKeyService.List] request.
- `labels` (Map Of String). Custom labels for the key as `key:value` pairs. Maximum 64 per key.
- `name` (String). Name of the key.
- `signature_algorithm` (String). Signature Algorithm ID.
- `status` (String). Current status of the key.


