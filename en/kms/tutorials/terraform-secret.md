# Encrypting secrets in Hashicorp {{ TF-full }}

[The {{ TF }} provider for {{ yandex-cloud }}]({{ tf-provider-link }}) lets you encrypt secrets with a {{ kms-short-name }} key to use them later in a {{ TF }} configuration.

Specify the plaintext and {{ kms-short-name }} key to be used for encryption in the [yandex_kms_secret_ciphertext]({{ tf-provider-link }}/kms_secret_ciphertext) block:

```
resource "yandex_kms_secret_ciphertext" "encrypted_strong_password" {
  key_id      = "<key ID>"
  aad_context = "additional authenticated data"
  plaintext   = "strong password"
}
```

You can then access the ciphertext via the variable `${yandex_kms_secret_ciphertext.encrypted_strong_password.ciphertext}`.

{% note warning %}

Using `yandex_kms_secret_ciphertext` lets you hide secrets when deploying an infrastructure. However, in general, it's not safe to openly specify the `plaintext` and `aad_context` in a configuration file. Secrets can be read from configuration files or execution logs and can end up in the {{ TF }} state.

{% endnote %}

## Recommendations for safely storing secret data {#save-secret}

* Don't explicitly specify the secret values in the configuration file. Read them from storage with restricted access (for example, use secret storage).
* Consider [storing the {{ TF }} state remotely](https://www.terraform.io/docs/state/sensitive-data.html).

## See also {#see-also}

* [Getting started with {{ TF }} in {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [{{ yandex-cloud }} provider documentation]({{ tf-provider-link }}).
* [Sensitive Data in State](https://www.terraform.io/docs/state/sensitive-data.html).
* [{#T}](vault-secret.md)
