# Encrypting secrets in {{ TF-full }}

{% include [terraform-encryption](../../_includes/kms/terraform-encryption.md) %}

## Recommendations for safely storing secret data {#save-secret}

* Don't explicitly specify the secret values in the configuration file. Read them from storage with restricted access (for example, use secret storage).
* Consider [storing the {{ TF }} state remotely](https://www.terraform.io/docs/state/sensitive-data.html).

## See also {#see-also}

* [Getting started with {{ TF }} in {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [The {{ yandex-cloud }} provider documentation]({{ tf-provider-link }}/).
* [Sensitive Data in State](https://www.terraform.io/docs/state/sensitive-data.html).
* [Encrypting data using the {{ yandex-cloud }} CLI and API](../../kms/operations/encryption.md).
{% if product == "yandex-cloud" %}
* [{#T}](vault-secret.md).
{% endif %}
