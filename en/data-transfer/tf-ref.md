---
title: "{{ TF }} reference for {{ data-transfer-full-name }}"
description: "This page provides reference information on the Terraform provider resources supported for {{ data-transfer-name }}."
---

# {{ TF }} reference for {{ data-transfer-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ data-transfer-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_datatransfer_transfer]({{ tf-provider-resources-link }}/datatransfer_transfer) | [Transfer](concepts/index.md#transfer) |
| [yandex_datatransfer_endpoint]({{ tf-provider-resources-link }}/datatransfer_endpoint) | [Endpoint](concepts/index.md#endpoint) |