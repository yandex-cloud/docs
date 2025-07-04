---
title: Справочник {{ TF }} для {{ mgl-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ mgl-name }}.
---

# Справочник {{ TF }} для {{ mgl-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ mgl-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_gitlab_instance]({{ tf-provider-resources-link }}/gitlab_instance) | [Инстанс {{ GL }}](./concepts/index.md#instance) |

## Источники данных {#data-sources}

Для {{ mgl-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_gitlab_instance]({{ tf-provider-datasources-link }}/gitlab_instance) | Информация об [инстансе {{ GL }}](./concepts/index.md#instance) |
