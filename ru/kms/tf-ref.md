---
title: Справочник {{ TF }} для {{ kms-full-name }}
description: На этой странице приведен справочник ресурсов провайдера {{ TF }}, которые поддерживаются для сервиса {{ kms-name }}.
---

# Справочник {{ TF }} для {{ kms-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ kms-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key) | [Асимметричная ключевая пара шифрования](./concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_encryption_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре шифрования. <br>Вместо `kms_asymmetric_encryption_key_iam_binding` рекомендуется использовать `kms_asymmetric_encryption_key_iam_member` |
| [kms_asymmetric_encryption_key_iam_member]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи |
| [yandex_kms_asymmetric_signature_key]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key) | [Асимметричная ключевая пара электронной подписи](./concepts/asymmetric-signature-key.md) |
| [yandex_kms_asymmetric_signature_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи. <br>Вместо `kms_asymmetric_signature_key_iam_binding` рекомендуется использовать `kms_asymmetric_signature_key_iam_member` |
| [kms_asymmetric_signature_key_iam_member]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key_iam_member) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к асимметричной ключевой паре электронной подписи |
| [yandex_kms_secret_ciphertext]({{ tf-provider-resources-link }}/kms_secret_ciphertext) | Шифртекст |
| [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key) | [Симметричный ключ шифрования](./concepts/key.md) |
| [yandex_kms_symmetric_key_iam_binding]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к симметричному ключу шифрования. <br>Вместо `kms_symmetric_key_iam_binding` рекомендуется использовать `kms_symmetric_key_iam_member` |
| [kms_symmetric_key_iam_member]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_member)  | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к симметричному ключу шифрования |


## Источники данных {#data-sources}

Для {{ kms-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key]({{ tf-provider-datasources-link }}/kms_asymmetric_encryption_key) | Информация об [асимметричной ключевой паре шифрования](./concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_signature_key]({{ tf-provider-datasources-link }}/kms_asymmetric_signature_key) | Информация об [асимметричной ключевой паре электронной подписи](./concepts/asymmetric-signature-key.md) |
| [yandex_kms_symmetric_key]({{ tf-provider-datasources-link }}/kms_symmetric_key) | Информация о [симметричном ключе шифрования](./concepts/key.md) |