---
title: '{{ TF }} reference for {{ dns-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ dns-name }}.
---

# {{ TF }} reference for {{ dns-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ dns-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset) | [Resource record](./concepts/resource-record.md) |
| [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone) | [DNS zone](./concepts/dns-zone.md) |
| [yandex_dns_zone_iam_binding]({{ tf-provider-resources-link }}/dns_zone_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a DNS zone |

## Data sources {#data-sources}

{{ dns-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_dns_zone]({{ tf-provider-datasources-link }}/dns_zone) | [DNS zone](./concepts/dns-zone.md) information |