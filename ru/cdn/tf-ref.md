---
title: "Справочник {{ TF }} для {{ cdn-full-name }}"
description: "На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ cdn-name }}."
---

# Справочник {{ TF }} для {{ cdn-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ cdn-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group) | [Группа источников](./concepts/origins.md#groups) |
| [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource) | [CDN-ресурс](./concepts/resource.md) |

## Источники данных {#data-sources}

Для {{ cdn-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_cdn_origin_group]({{ tf-provider-datasources-link }}/datasource_cdn_origin_group) | Информация о [группе источников](./concepts/origins.md#groups) |
| [yandex_cdn_resource]({{ tf-provider-datasources-link }}/datasource_cdn_resource) | Информация о [CDN-ресурсе](./concepts/resource.md) |