---
subcategory: Key Management Service
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/kms_secret_ciphertext.md
---

# yandex_kms_secret_ciphertext (Resource)

Encrypts given plaintext with the specified Yandex KMS key and provides access to the **CipherText**.

{% note warning %}

Using this resource will allow you to conceal secret data within your resource definitions, but it does not take care of protecting that data in the logging output, plan output, or state output. Please take care to secure your secret data outside of resource definitions.

{% endnote %}

For more information, see [the official documentation](https://yandex.cloud/docs/kms/concepts/).

## Example usage

```terraform
//
// Create a new KMS Symmetric Encryption Key and Cipher Secret for it.
//
resource "yandex_kms_symmetric_key" "example" {
  name        = "example-symetric-key"
  description = "description for key"
}

resource "yandex_kms_secret_ciphertext" "password" {
  key_id      = yandex_kms_symmetric_key.example.id
  aad_context = "additional authenticated data"
  plaintext   = "strong password"
}
```

## Arguments & Attributes Reference

- `aad_context` (String). Additional authenticated data (AAD context), optional. If specified, this data will be required for decryption with the `SymmetricDecryptRequest`.
- `ciphertext` (*Read-Only*) (String). Resulting CipherText, encoded with `standard` base64 alphabet as defined in RFC 4648 section 4.
- `id` (String). 
- `key_id` (**Required**)(String). ID of the symmetric KMS key to use for encryption.
- `plaintext` (**Required**)(String). Plaintext to be encrypted.


