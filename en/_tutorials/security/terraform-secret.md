# Encrypting secrets in {{ TF-full }}

{% include [terraform-encryption](../../_includes/kms/terraform-encryption.md) %}

## Recommendations for safely storing secret data {#save-secret}

* Do not explicitly specify the secret values in the configuration file. Read them from a storage with restricted access (e.g., a secret storage).
* Consider [storing the {{ TF }} state remotely](https://www.terraform.io/docs/state/sensitive-data.html).

## See also {#see-also}

* [Getting started with {{ TF }} in {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [{{ yandex-cloud }} provider documentation]({{ tf-provider-link }}/).
* [Sensitive Data in State](https://www.terraform.io/docs/state/sensitive-data.html).
* [Encrypting data using the {{ yandex-cloud }}](../../kms/operations/symmetric-encryption.md) CLI and API.
* [{#T}](../../kms/tutorials/vault-secret.md)
