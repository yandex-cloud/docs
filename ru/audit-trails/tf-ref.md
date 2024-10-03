---
title: "Справочник {{ TF }} для {{ at-full-name }}"
description: "На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ at-name }}."
---

# Справочник {{ TF }} для {{ at-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ at-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_audit_trails_trail]({{ tf-provider-resources-link }}/audit_trails_trail) | [Трейл](./concepts/trail.md) |


## Источники данных {#data-sources}

Для {{ at-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_audit_trails_trail]({{ tf-provider-datasources-link }}/datasource_audit_trails_trail) | Информация о [трейле](./concepts/trail.md) |