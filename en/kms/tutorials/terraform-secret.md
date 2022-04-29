# Encrypting secrets in Hashicorp Terraform

[The Terraform provider for {{ yandex-cloud }}](https://www.terraform.io/docs/providers/yandex/index.html) lets you encrypt secrets with a {{ kms-short-name }} key to use them later in a Terraform configuration.

Specify the plaintext and {{ kms-short-name }} key to be used for encryption in the [yandex_kms_secret_ciphertext](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_secret_ciphertext) block:

```
resource "yandex_kms_secret_ciphertext" "encrypted_strong_password" {
  key_id      = "<key ID>"
  aad_context = "additional authenticated data"
  plaintext   = "strong password"
}
```

You can then access the ciphertext via the variable `${yandex_kms_secret_ciphertext.encrypted_strong_password.ciphertext}`.

{% note warning %}

Using `yandex_kms_secret_ciphertext` lets you hide secrets when deploying an infrastructure. However, in general, it's not safe to openly specify the `plaintext` and `aad_context` in a configuration file. Secrets can be read from configuration files or execution logs and can end up in the Terraform state.

{% endnote %}

## Recommendations for safely storing secret data {#save-secret}

* Don't explicitly specify the secret values in the configuration file. Read them from storage with restricted access (for example, use secret storage).
* Consider [storing the Terraform state remotely](https://www.terraform.io/docs/state/sensitive-data.html).

## See also {#see-also}

* [Getting started with Terraform in {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [{{ yandex-cloud }} provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).
* [Sensitive Data in State](https://www.terraform.io/docs/state/sensitive-data.html).

