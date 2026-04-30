---
title: '{{ TF }} reference for {{ certificate-manager-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ certificate-manager-name }}.
---

# {{ TF }} reference for {{ certificate-manager-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ certificate-manager-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate) | [TLS certificate](./concepts/index.md#types) |
| [yandex_cm_certificate_iam_binding]({{ tf-provider-resources-link }}/cm_certificate_iam_binding)| [Access bindings](../iam/concepts/access-control/index.md#access-bindings) for a TLS certificate; limited to 1,000 bindings per resource. <br>We recommend using `yandex_cm_certificate_iam_member` instead of `yandex_cm_certificate_iam_binding`. |
| [yandex_cm_certificate_iam_member]({{ tf-provider-resources-link }}/cm_certificate_iam_member) |  [Access bindings](../iam/concepts/access-control/index.md#access-bindings) for a TLS certificate; |


## Data sources {#data-sources}

{{ certificate-manager-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_cm_certificate]({{ tf-provider-datasources-link }}/cm_certificate) | [TLS certificate](./concepts/index.md#types) details |
| [yandex_cm_certificate_content]({{ tf-provider-datasources-link }}/cm_certificate_content) | TLS certificate contents |