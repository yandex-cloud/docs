---
title: '{{ TF }} reference for {{ kms-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources supported for {{ kms-name }}.
---

# {{ TF }} reference for {{ kms-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ kms-name }} supports the following {{ TF }} resources :

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key) | [Asymmetric encryption key pair](./concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_encryption_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an asymmetric encryption key pair. <br>We recommend using `kms_asymmetric_encryption_key_iam_member` instead of `kms_asymmetric_encryption_key_iam_binding`. |
| [kms_asymmetric_encryption_key_iam_member]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an asymmetric digital signature key pair |
| [yandex_kms_asymmetric_signature_key]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key) | [Asymmetric digital signature key pair](./concepts/asymmetric-signature-key.md) |
| [yandex_kms_asymmetric_signature_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an asymmetric digital signature key pair. <br>We recommend using `kms_asymmetric_signature_key_iam_member` instead of `kms_asymmetric_signature_key_iam_binding`. |
| [kms_asymmetric_signature_key_iam_member]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an asymmetric digital signature key pair |
| [yandex_kms_secret_ciphertext]({{ tf-provider-resources-link }}/kms_secret_ciphertext) | Ciphertext |
| [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key) | [Symmetric encryption key](./concepts/key.md) |
| [yandex_kms_symmetric_key_iam_binding]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a symmetric encryption key. <br>We recommend using `kms_symmetric_key_iam_member` instead of `kms_symmetric_key_iam_binding`. |
| [kms_symmetric_key_iam_member]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_member)  | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a symmetric encryption key |


## Data sources {#data-sources}

{{ kms-name }} supports the following {{ TF }} data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key]({{ tf-provider-datasources-link }}/kms_asymmetric_encryption_key) | Information about an [asymmetric encryption key pair](./concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_signature_key]({{ tf-provider-datasources-link }}/kms_asymmetric_signature_key) | Information about an [asymmetric digital signature key pair](./concepts/asymmetric-signature-key.md) |
| [yandex_kms_symmetric_key]({{ tf-provider-datasources-link }}/kms_symmetric_key) | Information about a [symmetric encryption key](./concepts/key.md) |