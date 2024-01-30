# Справочник ресурсов {{ kms-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE). 

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ kms-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key) | [Асимметричная ключевая пара шифрования](./concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_encryption_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_binding) | [Роль](./security/index.md#roles-list) на асимметричную ключевую пару шифрования |
| [yandex_kms_asymmetric_signature_key]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key) | [Асимметричная ключевая пара электронной подписи](./concepts/asymmetric-signature-key.md) |
| [yandex_kms_asymmetric_signature_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key_iam_binding) | [Роль](./security/index.md#roles-list) на асимметричную ключевую пару электронной подписи |
| [yandex_kms_secret_ciphertext]({{ tf-provider-resources-link }}/kms_secret_ciphertext) | Шифртекст |
| [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key) | [Симметричный ключ шифрования](./concepts/key.md) |
| [yandex_kms_symmetric_key_iam_binding]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_binding) | [Роль](./security/index.md#roles-list) на симметричный ключ шифрования |