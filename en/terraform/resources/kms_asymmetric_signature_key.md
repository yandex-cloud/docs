---
subcategory: Key Management Service
---

# yandex_kms_asymmetric_signature_key (Resource)

An asymmetric KMS key that may contain several versions of the cryptographic material.

## Example usage

```terraform
//
// Create a new KMS Assymetric Signature Key.
//
resource "yandex_kms_asymmetric_signature_key" "key-a" {
  name                = "example-asymetric-signature-key"
  description         = "description for key"
  signature_algorithm = "RSA_2048_SIGN_PSS_SHA_256"
}
```

## Arguments & Attributes Reference

- `asymmetric_signature_key_id` (String). ID of the asymmetric KMS key to return.
 To get the ID of an asymmetric KMS key use a [AsymmetricSignatureKeyService.List] request.
- `created_at` (*Read-Only*) (String). Time when the key was created.
- `deletion_protection` (Bool). Flag that inhibits deletion of the key
- `description` (String). Description of the key.
- `folder_id` (String). ID of the folder that the key belongs to.
- `id` (String). ID of the asymmetric KMS key to return.
 To get the ID of an asymmetric KMS key use a [AsymmetricSignatureKeyService.List] request.
- `labels` (Map Of String). Custom labels for the key as `key:value` pairs. Maximum 64 per key.
- `name` (String). Name of the key.
- `signature_algorithm` (String). Signature Algorithm ID.
- `status` (String). Current status of the key.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_kms_asymmetric_signature_key.<resource Name> <resource Id>
terraform import yandex_kms_asymmetric_signature_key.key-a abjjf**********p3gp8
```
