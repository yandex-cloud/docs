# Справочник Terraform для Yandex Key Management Service

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Key Management Service поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key](../terraform/resources/kms_asymmetric_encryption_key.md) | [Асимметричная ключевая пара шифрования](concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_encryption_key_iam_binding](../terraform/resources/kms_asymmetric_encryption_key_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре шифрования. <br>Вместо `kms_asymmetric_encryption_key_iam_binding` рекомендуется использовать `kms_asymmetric_encryption_key_iam_member` |
| [kms_asymmetric_encryption_key_iam_member](../terraform/resources/kms_asymmetric_encryption_key_iam_member.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи |
| [yandex_kms_asymmetric_signature_key](../terraform/resources/kms_asymmetric_signature_key.md) | [Асимметричная ключевая пара электронной подписи](concepts/asymmetric-signature-key.md) |
| [yandex_kms_asymmetric_signature_key_iam_binding](../terraform/resources/kms_asymmetric_signature_key_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи. <br>Вместо `kms_asymmetric_signature_key_iam_binding` рекомендуется использовать `kms_asymmetric_signature_key_iam_member` |
| [kms_asymmetric_signature_key_iam_member](../terraform/resources/kms_asymmetric_signature_key_iam_member.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи |
| [yandex_kms_secret_ciphertext](../terraform/resources/kms_secret_ciphertext.md) | Шифртекст |
| [yandex_kms_symmetric_key](../terraform/resources/kms_symmetric_key.md) | [Симметричный ключ шифрования](concepts/key.md) |
| [yandex_kms_symmetric_key_iam_binding](../terraform/resources/kms_symmetric_key_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к симметричному ключу шифрования. <br>Вместо `kms_symmetric_key_iam_binding` рекомендуется использовать `kms_symmetric_key_iam_member` |
| [kms_symmetric_key_iam_member](../terraform/resources/kms_symmetric_key_iam_member.md)  | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к симметричному ключу шифрования |


## Источники данных {#data-sources}

Для Key Management Service поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key](../terraform/data-sources/kms_asymmetric_encryption_key.md) | Информация об [асимметричной ключевой паре шифрования](concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_signature_key](../terraform/data-sources/kms_asymmetric_signature_key.md) | Информация об [асимметричной ключевой паре электронной подписи](concepts/asymmetric-signature-key.md) |
| [yandex_kms_symmetric_key](../terraform/data-sources/kms_symmetric_key.md) | Информация о [симметричном ключе шифрования](concepts/key.md) |