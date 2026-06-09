# Справочник {{ TF }} для {{ kms-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ kms-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key) | [Асимметричная ключевая пара шифрования](concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_encryption_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре шифрования. <br>Вместо `kms_asymmetric_encryption_key_iam_binding` рекомендуется использовать `kms_asymmetric_encryption_key_iam_member` |
| [kms_asymmetric_encryption_key_iam_member]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи |
| [yandex_kms_asymmetric_signature_key]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key) | [Асимметричная ключевая пара электронной подписи](concepts/asymmetric-signature-key.md) |
| [yandex_kms_asymmetric_signature_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи. <br>Вместо `kms_asymmetric_signature_key_iam_binding` рекомендуется использовать `kms_asymmetric_signature_key_iam_member` |
| [kms_asymmetric_signature_key_iam_member]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи |
| [yandex_kms_secret_ciphertext]({{ tf-provider-resources-link }}/kms_secret_ciphertext) | Шифртекст |
| [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key) | [Симметричный ключ шифрования](concepts/key.md) |
| [yandex_kms_symmetric_key_iam_binding]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к симметричному ключу шифрования. <br>Вместо `kms_symmetric_key_iam_binding` рекомендуется использовать `kms_symmetric_key_iam_member` |
| [kms_symmetric_key_iam_member]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_member)  | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к симметричному ключу шифрования |


## Источники данных {#data-sources}

Для {{ kms-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key]({{ tf-provider-datasources-link }}/kms_asymmetric_encryption_key) | Информация об [асимметричной ключевой паре шифрования](concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_signature_key]({{ tf-provider-datasources-link }}/kms_asymmetric_signature_key) | Информация об [асимметричной ключевой паре электронной подписи](concepts/asymmetric-signature-key.md) |
| [yandex_kms_symmetric_key]({{ tf-provider-datasources-link }}/kms_symmetric_key) | Информация о [симметричном ключе шифрования](concepts/key.md) |