---
title: Справочник {{ TF }} для {{ dns-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ dns-name }}.
---

# Справочник {{ TF }} для {{ dns-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ dns-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset) | [Ресурсная запись](./concepts/resource-record.md) |
| [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone) | [Зона DNS](./concepts/dns-zone.md) |

## Источники данных {#data-sources}

Для {{ dns-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_dns_zone]({{ tf-provider-datasources-link }}/dns_zone) | Информация о [зоне DNS](./concepts/dns-zone.md) |