---
title: "{{ TF }} reference for {{ dns-full-name }}"
description: "This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ dns-name }}."
---

# {{ TF }} reference for {{ dns-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ dns-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset) | [Resource record](./concepts/resource-record.md) |
| [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone) | [DNS zone](./concepts/dns-zone.md) |

## Data sources {#data-sources}

{{ dns-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_dns_zone]({{ tf-provider-datasources-link }}/datasource_dns_zone) | [DNS zone](./concepts/dns-zone.md) information |