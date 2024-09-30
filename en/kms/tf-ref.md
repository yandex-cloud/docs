---
title: "{{ TF }} reference for {{ kms-full-name }}"
description: "This page gives reference information about the Terraform provider resources supported for {{ kms-name }}."
---

# {{ TF }} reference for {{ kms-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ kms-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_kms_asymmetric_encryption_key]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key) | [Asymmetric encryption key pair](./concepts/asymmetric-encryption-key.md) |
| [yandex_kms_asymmetric_encryption_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_encryption_key_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an asymmetric encryption key pair |
| [yandex_kms_asymmetric_signature_key]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key) | [Asymmetric digital signature key pair](./concepts/asymmetric-signature-key.md) |
| [yandex_kms_asymmetric_signature_key_iam_binding]({{ tf-provider-resources-link }}/kms_asymmetric_signature_key_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an asymmetric digital signature key pair |
| [yandex_kms_secret_ciphertext]({{ tf-provider-resources-link }}/kms_secret_ciphertext) | Ciphertext |
| [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key) | [Symmetric encryption key](./concepts/key.md) |
| [yandex_kms_symmetric_key_iam_binding]({{ tf-provider-resources-link }}/kms_symmetric_key_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a symmetric encryption key |