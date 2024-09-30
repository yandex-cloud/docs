---
title: "{{ TF }} reference for {{ certificate-manager-full-name }}"
description: "This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ certificate-manager-name }}."
---

# {{ TF }} reference for {{ certificate-manager-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ certificate-manager-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate) | [TLS certificate](./concepts/index.md#types) |

## Data sources {#data-sources}

{{ certificate-manager-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_cm_certificate]({{ tf-provider-datasources-link }}/datasource_cm_certificate) | [TLS certificate](./concepts/index.md#types) information |
| [yandex_cm_certificate_content]({{ tf-provider-datasources-link }}/datasource_cm_certificate_content) | TLS certificate contents |