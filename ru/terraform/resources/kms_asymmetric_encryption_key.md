---
subcategory: Key Management Service
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/kms_asymmetric_encryption_key.md
---

# yandex_kms_asymmetric_encryption_key (Resource)

An asymmetric KMS key that may contain several versions of the cryptographic material.

## Example usage

```terraform
//
// Create a new KMS Assymetric Encryption Key.
//
resource "yandex_kms_asymmetric_encryption_key" "key-a" {
  name                 = "example-asymetric-encryption-key"
  description          = "description for key"
  encryption_algorithm = "RSA_2048_ENC_OAEP_SHA_256"
}
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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_kms_asymmetric_encryption_key.<resource Name> <resource Id>
terraform import yandex_kms_asymmetric_encryption_key.key-a abj7u**********j38cd
```
